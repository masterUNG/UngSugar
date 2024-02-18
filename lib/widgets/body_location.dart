import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ungsugar/utility/app_controller.dart';
import 'package:ungsugar/utility/app_dialog.dart';
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

  var latlngs = <LatLng>[];

  @override
  void initState() {
    super.initState();

    appController.displaySave.value = false;
    appController.displayAddMarker.value = true;

    if (appController.mapMarkers.isNotEmpty) {
      appController.mapMarkers.clear();
    }

    if (appController.setPolygons.isNotEmpty) {
      appController.setPolygons.clear();
    }

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
                  child: Column(
                    children: [
                      Obx(() => appController.displayAddMarker.value
                          ? WidgetIconButton(
                              iconData: Icons.add_box,
                              pressFunc: () {
                                AppService()
                                    .processFindLocation()
                                    .then((value) {
                                  print(
                                      appController.positions.last.toString());

                                  latlngs.add(LatLng(
                                      appController.positions.last.latitude,
                                      appController.positions.last.longitude));

                                  MarkerId markerId = MarkerId(
                                      'id${appController.mapMarkers.length}');
                                  Marker marker = Marker(
                                      markerId: markerId,
                                      position: LatLng(
                                          appController.positions.last.latitude,
                                          appController
                                              .positions.last.longitude));

                                  appController.mapMarkers[markerId] = marker;
                                });
                              },
                              size: GFSize.LARGE,
                              gfButtonType: GFButtonType.outline2x,
                            )
                          : const SizedBox()),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(() => appController.mapMarkers.length >= 3
                          ? WidgetIconButton(
                              iconData: Icons.select_all,
                              pressFunc: () {
                                appController.displayAddMarker.value = false;
                                print(
                                    'ขนาดของจุดที่ต้องเขียนเส้น ---> ${latlngs.length}');

                                appController.setPolygons.add(Polygon(
                                  polygonId: const PolygonId('id'),
                                  points: latlngs,
                                  fillColor: Colors.green.withOpacity(0.25),
                                  strokeColor: Colors.green.shade800,
                                  strokeWidth: 2,
                                ));

                                appController.mapMarkers.clear();

                                appController.displaySave.value = true;

                                setState(() {});
                              },
                              size: GFSize.LARGE,
                              gfButtonType: GFButtonType.outline2x,
                            )
                          : const SizedBox()),
                      Obx(() => appController.displaySave.value
                          ? WidgetIconButton(
                              iconData: Icons.save,
                              size: GFSize.LARGE,
                              gfButtonType: GFButtonType.outline2x,
                              pressFunc: () {
                                AppDialog().narmalDialog(title: 'Confirm Save');
                              },
                            )
                          : const SizedBox()),
                    ],
                  ),
                )
              ],
            ),
          ));
  }
}
