import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungsugar/models/area_model.dart';
import 'package:ungsugar/states/qr_reader.dart';
import 'package:ungsugar/utility/app_constant.dart';
import 'package:ungsugar/utility/app_controller.dart';
import 'package:ungsugar/utility/app_dialog.dart';
import 'package:ungsugar/utility/app_service.dart';
import 'package:ungsugar/widgets/widget_button.dart';
import 'package:ungsugar/widgets/widget_map.dart';
import 'package:ungsugar/widgets/widget_text.dart';

class BodyListArea extends StatefulWidget {
  const BodyListArea({super.key});

  @override
  State<BodyListArea> createState() => _BodyListAreaState();
}

class _BodyListAreaState extends State<BodyListArea> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    AppService().processReadAllArea();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => appController.areaModels.isEmpty
        ? const SizedBox()
        : SizedBox(
            width: Get.width,
            height: Get.height,
            child: Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: appController.areaModels.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      print('You tap index --> $index');
                      displayDialog(areaModel: appController.areaModels[index]);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WidgetText(
                          data: appController.areaModels[index].nameArea,
                          textStyle: AppConstant().h2Style(),
                        ),
                        WidgetText(
                            data: AppService().convertTimeToString(
                                timestamp:
                                    appController.areaModels[index].timestamp)),
                        const Divider(
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: WidgetButton(
                    label: 'QR Reader',
                    pressFunc: () {
                      Get.to(QRreader());
                    },
                  ),
                )
              ],
            ),
          ));
  }

  void displayDialog({required AreaModel areaModel}) {
    AppDialog().narmalDialog(
        title: 'รายละเอียด',
        contentWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200,
              height: 180,
              child: WidgetMap(
                  lat: areaModel.geoPoints.last.latitude,
                  lng: areaModel.geoPoints.last.longitude),
            ),
            WidgetText(data: 'QRcode --> ${areaModel.qrCode}'),
          ],
        ));
  }
}
