import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ungsugar/utility/app_controller.dart';
import 'package:ungsugar/utility/app_dialog.dart';
import 'package:ungsugar/utility/app_service.dart';

class QRreader extends StatefulWidget {
  const QRreader({super.key});

  @override
  State<QRreader> createState() => _QRreaderState();
}

class _QRreaderState extends State<QRreader> {
  QRViewController? qrViewController;
  AppController appController = Get.put(AppController());

  final qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();

    if (GetPlatform.isAndroid) {
      qrViewController!.pauseCamera();
    }

    if (GetPlatform.isIOS) {
      qrViewController!.resumeCamera();
    }
  }

  @override
  void dispose() {
    qrViewController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 250,
            height: 250,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (p0) {
                qrViewController = p0;

                qrViewController!.scannedDataStream.listen((event) {
                  if (event.code != null) {
                    String result = event.code!;
                    qrViewController!.stopCamera();

                    AppService().findQRcode(qrCode: result).then((value) {
                      if (value == null) {
                        AppDialog().narmalDialog(title: 'ไม่มี Data');
                      } else {}
                    });
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
