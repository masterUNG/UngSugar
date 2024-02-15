import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungsugar/utility/app_constant.dart';
import 'package:ungsugar/utility/app_controller.dart';
import 'package:ungsugar/widgets/widget_form.dart';
import 'package:ungsugar/widgets/widget_icon_button.dart';
import 'package:ungsugar/widgets/widget_image_asset.dart';
import 'package:ungsugar/widgets/widget_text.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  //นี่คือ Dependency ที่ใช่ในการ call Rx
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 64),
                  width: 250,
                  child: Column(
                    children: [
                      displayLogoAndAppName(),
                      WidgetForm(
                        hint: 'Email :',
                        sufficWidget: Icon(Icons.email),
                      ),
                      Obx(() => WidgetForm(
                            hint: 'Password :',
                            obsecu: appController.redEye.value,
                            sufficWidget: WidgetIconButton(
                              iconData: appController.redEye.value ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                              pressFunc: () {
                                appController.redEye.value =
                                    !appController.redEye.value;
                              },
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row displayLogoAndAppName() {
    return Row(
      children: [
        displayImage(),
        WidgetText(
          data: 'Ung Sugar',
          textStyle: AppConstant().h2Style(),
        ),
      ],
    );
  }

  WidgetImageAsset displayImage() {
    return const WidgetImageAsset(
      path: 'images/logo.png',
      size: 48,
    );
  }
}
