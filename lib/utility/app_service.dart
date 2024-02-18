import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ungsugar/models/area_model.dart';
import 'package:ungsugar/models/respon_model.dart';
import 'package:ungsugar/models/user_api_model.dart';
import 'package:ungsugar/models/user_model.dart';
import 'package:ungsugar/states/main_home.dart';
import 'package:ungsugar/utility/app_constant.dart';
import 'package:ungsugar/utility/app_controller.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ungsugar/utility/app_dialog.dart';
import 'package:ungsugar/widgets/widget_button.dart';
import 'package:ungsugar/widgets/widget_text.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> processTakePhoto({required ImageSource imageSource}) async {
    var result = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (result != null) {
      appController.files.add(File(result.path));
    }
  }

  Future<void> processCreateNewAccount({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      String uid = value.user!.uid;
      print('uid ที่ได้จากการสมัคร  ---> $uid');

      //Process Upload Image to Storage
      String nameFile = '$uid.jpg';

      FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      Reference reference = firebaseStorage.ref().child('avatar/$nameFile');
      UploadTask uploadTask = reference.putFile(appController.files.last);

      await uploadTask.whenComplete(() async {
        String? urlImage = await reference.getDownloadURL();

        print('Upload $urlImage Success');

        UserModel userModel = UserModel(
            uid: uid,
            name: name,
            email: email,
            password: password,
            urlImage: urlImage);

        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .set(userModel.toMap())
            .then((value) async {
          print('insert firebase Success');

          //Insert Data to api
          UserApiModel userApiModel = UserApiModel(
              name: name,
              email: email,
              password: password,
              fuidstr: uid,
              bod: DateTime.now().toString(),
              picurl: urlImage);

          await dio.Dio()
              .post(AppConstant.urlAPI, data: userApiModel.toMap())
              .then((value) {
            if (value.statusCode == 200) {
              ResponModel responModel = ResponModel.fromMap(value.data);

              AppDialog().narmalDialog(
                  title: 'Create Account Success',
                  contentWidget: WidgetText(data: responModel.message),
                  secontWidget: WidgetButton(
                    label: 'ThankYou',
                    pressFunc: () {
                      context.loaderOverlay.hide();
                      Get.back();
                      Get.back();
                    },
                  ));
            } else {}
          });
        });
      });
    }).catchError((onError) {
      context.loaderOverlay.hide();
      Get.snackbar(onError.code, onError.message,
          backgroundColor: GFColors.DANGER, colorText: GFColors.WHITE);
    });
  }

  Future<void> processCheckLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      context.loaderOverlay.hide();
      Get.offAll(const MainHome());
      Get.snackbar('Authen Success', 'Welcome to MyApp ${value.user!.uid}');
    }).catchError((onError) {
      context.loaderOverlay.hide();

      Get.snackbar(onError.code, onError.message,
          backgroundColor: GFColors.DANGER, colorText: GFColors.WHITE);
    });
  }

  Future<void> processFindLocation() async {
    bool locationService = await Geolocator.isLocationServiceEnabled();

    if (locationService) {
      //เปิด location service

      LocationPermission locationPermission =
          await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.deniedForever) {
        //denedForever
        dialogCallPermission();
      } else {
        //Dened, Alway, One

        if (locationPermission == LocationPermission.denied) {
          //Denied
          locationPermission = await Geolocator.requestPermission();

          if ((locationPermission != LocationPermission.always) &&
              (locationPermission != LocationPermission.whileInUse)) {
            dialogCallPermission();
          } else {
            Position position = await Geolocator.getCurrentPosition();
            appController.positions.add(position);
          }
        } else {
          //Alway, One
          Position position = await Geolocator.getCurrentPosition();
          appController.positions.add(position);
        }
      }
    } else {
      // ปิด location service
      AppDialog().narmalDialog(
          title: 'Open Service',
          contentWidget: const WidgetText(data: 'Please Open Service'),
          secontWidget: WidgetButton(
            label: 'Open Service',
            pressFunc: () async {
              await Geolocator.openLocationSettings();
              exit(0);
            },
          ));
    }
  }

  void dialogCallPermission() {
    AppDialog().narmalDialog(
        title: 'Open Permission',
        secontWidget: WidgetButton(
          label: 'Open Permission',
          pressFunc: () async {
            await Geolocator.openAppSettings();
            exit(0);
          },
        ));
  }

  Future<void> processSaveArea(
      {required String nameArea, required List<LatLng> latlngs}) async {
    var geoPoints = <GeoPoint>[];
    for (var element in latlngs) {
      geoPoints.add(GeoPoint(element.latitude, element.longitude));
    }

    AreaModel areaModel = AreaModel(
      nameArea: nameArea,
      timestamp: Timestamp.fromDate(DateTime.now()),
      geoPoints: geoPoints,
      qrCode: 'ki${Random().nextInt(1000000)}',
    );

    var user = FirebaseAuth.instance.currentUser;
    String uidLogin = user!.uid;

    print('## uidLogin ---> $uidLogin');
    print('## areaModel ---> ${areaModel.toMap()}');

    await FirebaseFirestore.instance
        .collection('user')
        .doc(uidLogin)
        .collection('area')
        .doc()
        .set(areaModel.toMap())
        .then((value) {
      Get.snackbar('Add Success', 'ThankYou');
      appController.indexBody.value = 0;
    });
  }

  Future<void> processReadAllArea() async {
    var user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('area')
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) {
      if (appController.areaModels.isNotEmpty) {
        appController.areaModels.clear();
      }

      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          AreaModel areaModel = AreaModel.fromMap(element.data());
          appController.areaModels.add(areaModel);
        }
      }
    });
  }

  String convertTimeToString({required Timestamp timestamp}) {
    DateFormat dateFormat = DateFormat('dd MMMM yy HH:mm');
    String result = dateFormat.format(timestamp.toDate());
    return result;
  }

  Future<AreaModel?> findQRcode({required String qrCode}) async {
    AreaModel? areaModel;
    var user = FirebaseAuth.instance.currentUser;

    var response = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('area')
        .where('qrCode', isEqualTo: qrCode)
        .get();

    if (response.docs.isNotEmpty) {
      for (var element in response.docs) {
        areaModel = AreaModel.fromMap(element.data());
      }
    }
    return areaModel;
  }
}
