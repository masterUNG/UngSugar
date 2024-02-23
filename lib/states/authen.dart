import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ungsugar/states/create_new_account.dart';
import 'package:ungsugar/utility/app_constant.dart';
import 'package:ungsugar/utility/app_controller.dart';
import 'package:ungsugar/utility/app_service.dart';
import 'package:ungsugar/widgets/widget_button.dart';
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

  //key ที่ใช้ในการเช็ค validate
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            width: Get.width,
            height: Get.height,
            decoration:
                AppConstant().radialBox(center: const Alignment(-0.5, -0.5)),
            child: Stack(
              children: [
                ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 64),
                          width: 250,
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                displayLogoAndAppName(),
                                emailForm(),
                                passwordForm(),
                                loginButton(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(bottom: 8,
                  child: SizedBox(width: Get.width,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        createNewAccountButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
       
      ),
    );
  }

  WidgetButton createNewAccountButton() {
    return WidgetButton(
      label: 'Create New Account',
      pressFunc: () {
        Get.to(const CreateNewAccount());
      },
      gfButtonType: GFButtonType.transparent,
    );
  }

  Container loginButton() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: 250,
      child: WidgetButton(
        label: 'Login',
        pressFunc: () {
          if (formKey.currentState!.validate()) {
            //Start Process
            context.loaderOverlay.show();

            AppService().processCheckLogin(
              email: emailController.text,
              password: passwordController.text,
              context: context,
            );
          }
        },
      ),
    );
  }

  Obx passwordForm() {
    return Obx(() => WidgetForm(
          textEditingController: passwordController,
          validateFunc: (p0) {
            if (p0?.isEmpty ?? true) {
              return 'Please Fill Password';
            } else {
              return null;
            }
          },
          hint: 'Password :',
          obsecu: appController.redEye.value,
          sufficWidget: WidgetIconButton(
            iconData: appController.redEye.value
                ? Icons.remove_red_eye
                : Icons.remove_red_eye_outlined,
            pressFunc: () {
              appController.redEye.value = !appController.redEye.value;
            },
          ),
        ));
  }

  WidgetForm emailForm() {
    return WidgetForm(
      textEditingController: emailController,
      validateFunc: (p0) {
        if (p0?.isEmpty ?? true) {
          return 'Please Fill Email';
        } else {
          return null;
        }
      },
      hint: 'Email :',
      sufficWidget: Icon(Icons.email),
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
