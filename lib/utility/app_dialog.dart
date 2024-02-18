import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungsugar/widgets/widget_button.dart';
import 'package:ungsugar/widgets/widget_text.dart';

class AppDialog {
  void narmalDialog({
    required String title,
    Widget? iconWidget,
    Widget? contentWidget,
    Widget? firstWidget,
    Widget? secontWidget,
  }) {
    Get.dialog(AlertDialog(
      icon: iconWidget,
      title: WidgetText(data: title),
      content: contentWidget,
      actions: [
        firstWidget ?? const SizedBox(),
        secontWidget ??
            WidgetButton(
              label: firstWidget != null ? 'Cancel' : 'OK',
              pressFunc: () => Get.back(),
            )
      ],
    ), barrierDismissible: false);
  }
}
