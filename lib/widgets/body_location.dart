import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ungsugar/utility/app_controller.dart';
import 'package:ungsugar/utility/app_service.dart';
import 'package:ungsugar/widgets/widget_icon_button.dart';
import 'package:ungsugar/widgets/widget_map.dart';
import 'package:ungsugar/widgets/widget_text.dart';

class BodyLocation extends StatefulWidget {
  const BodyLocation({super.key});

  @override
  State<BodyLocation> createState() => _BodyLocationState();
}

class _BodyLocationState extends State<BodyLocation> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    AppService().processFindLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => appController.positions.isEmpty
        ? const SizedBox()
        : SizedBox(
            width: Get.width,
            height: Get.height,
            child: Stack(
              children: [
                WidgetMap(
                  lat: appController.positions.last.latitude,
                  lng: appController.positions.last.longitude,
                  myLocationEnable: true,
                ),
                Positioned(
                  top: 32,
                  left: 32,
                  child: WidgetIconButton(
                    iconData: Icons.add_box,
                    pressFunc: () {},
                    size: GFSize.LARGE,
                    gfButtonType: GFButtonType.outline2x,
                  ),
                )
              ],
            ),
          ));
  }
}
