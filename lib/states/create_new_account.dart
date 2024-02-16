import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungsugar/widgets/widget_button.dart';
import 'package:ungsugar/widgets/widget_form.dart';
import 'package:ungsugar/widgets/widget_icon_button.dart';
import 'package:ungsugar/widgets/widget_image_asset.dart';
import 'package:ungsugar/widgets/widget_text.dart';

class CreateNewAccount extends StatelessWidget {
  const CreateNewAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(data: 'Create New Accoun'),
      ),
      body: ListView(
        children: [
          displayImage(),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width * 0.6,
                child: Column(
                  children: [
                    WidgetForm(labelWidget: WidgetText(data: 'Displey Name :'),),
                    WidgetForm(labelWidget: WidgetText(data: 'Email :'),),
                    WidgetForm(labelWidget: WidgetText(data: 'Password :'),),
                    WidgetButton(
                      label: 'Create New Account',
                      pressFunc: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row displayImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width * 0.6,
          height: Get.width * 0.6,
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: WidgetImageAsset(
                  path: 'images/avatar.png',
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: WidgetIconButton(
                  iconData: Icons.photo_camera,
                  pressFunc: () {},
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
