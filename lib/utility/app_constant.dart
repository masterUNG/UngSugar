import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ungsugar/widgets/body_list_area.dart';
import 'package:ungsugar/widgets/body_location.dart';
import 'package:ungsugar/widgets/body_profile.dart';

class AppConstant {
  //field

  static Color primaryColor = const Color(0xffadd500);
  static Color secondColor = const Color(0xff133c29);

  static List<String> titles = <String>[
    'List Area',
    'My Location',
    'Profile',
  ];

  static List<IconData> iconDatas = <IconData>[
    Icons.list,
    Icons.map,
    Icons.person,
  ];

  static List<Widget> bodys = <Widget>[
    const BodyListArea(),
    const BodyLocation(),
    const BodyProfile(),
  ];

  static Color fieldColor = Colors.grey.withOpacity(0.4);

  static String urlAPI = 'http://110.164.149.104:9295/fapi/userFlutter';

  //method
  BoxDecoration radialBox({
    AlignmentGeometry? center,
  }) =>
      BoxDecoration(
          gradient: RadialGradient(
              colors: [Colors.white, primaryColor],
              radius: 1.0,
              center: center ?? Alignment.center));

  TextStyle h1Style() {
    return TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: secondColor,
    );
  }

  TextStyle h2Style() {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: secondColor,
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: secondColor,
    );
  }
}
