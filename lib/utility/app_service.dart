import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungsugar/utility/app_controller.dart';

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
}
