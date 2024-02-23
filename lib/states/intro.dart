import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:ungsugar/states/create_new_account.dart';
import 'package:ungsugar/utility/app_constant.dart';
import 'package:ungsugar/widgets/widget_button.dart';
import 'package:ungsugar/widgets/widget_image_asset.dart';
import 'package:ungsugar/widgets/widget_text.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: AppConstant().radialBox(),
        child: Stack(
          // fit: StackFit.expand,
          children: [
            Positioned(
              left: Get.width * 0.2,
              top: Get.height * 0.2,
              child: WidgetImageAsset(
                path: 'images/intro.png',
                size: Get.width * 0.6,
              ),
            ),
            Positioned(
              top: Get.height * 0.2 + Get.width * 0.6,
              // height: Get.height,
              child: SizedBox(
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        WidgetText(
                          data: 'Ung Sugar',
                          textStyle: AppConstant().h1Style(),
                        ),
                        WidgetText(
                          data: 'Slogan App สโลแกนของแอพ',
                          textStyle: AppConstant().h3Style(),
                        ),
                        WidgetText(
                          data: 'เขียนไว้ที่นี่ได้เลยครับ',
                          textStyle: AppConstant().h3Style(),
                        ),
                        Row(
                          children: [
                            WidgetButton(
                              label: 'Log In',
                              pressFunc: () {
                                Get.toNamed('/authen');
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            WidgetButton(
                              label: 'Sign Up',
                              pressFunc: () {
                                Get.to(const CreateNewAccount());
                              },
                              gfButtonType: GFButtonType.outline2x,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
