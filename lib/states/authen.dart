import 'package:flutter/material.dart';
import 'package:ungsugar/utility/app_constant.dart';
import 'package:ungsugar/widgets/widget_form.dart';
import 'package:ungsugar/widgets/widget_image_asset.dart';
import 'package:ungsugar/widgets/widget_text.dart';

class Authen extends StatelessWidget {
  const Authen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(margin: const EdgeInsets.only(top: 64),
                  width: 250,
                  child: Column(
                    children: [
                      displayLogoAndAppName(),
                      WidgetForm(hint: 'Email :', sufficWidget: Icon(Icons.email),),
                      WidgetForm(hint: 'Password :',),
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
