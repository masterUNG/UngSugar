import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ungsugar/models/area_model.dart';

class AppController extends GetxController {
  RxBool redEye = true.obs;
  RxList<File> files = <File>[].obs;
  RxInt indexBody = 0.obs;
  RxList<Position> positions = <Position>[].obs;
  RxMap<MarkerId, Marker> mapMarkers = <MarkerId, Marker>{}.obs;
  RxBool displayAddMarker = true.obs;
  RxBool displaySave = false.obs;
  RxSet<Polygon> setPolygons = <Polygon>{}.obs;

  RxList<AreaModel> areaModels = <AreaModel>[].obs;
}
