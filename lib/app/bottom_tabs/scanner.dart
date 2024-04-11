import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/bottom_tabs/component/drawer.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/util/translation_keys.dart';
import 'package:giftcart/widgets/app_text.dart';
import 'package:giftcart/widgets/helper_function.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'dashboard/view/dashboard_view.dart';

class ScanQrPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  Barcode? result;
  String nameValue = "";
  var qrData = TextEditingController();
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          controller!.pauseCamera();
          qrData.text = result!.code.toString();
          showDialog(
            context: context,
            builder: (context) {
              return ScanResultDialog(
                qrData: qrData.text,
                onClose: () {
                  controller!.resumeCamera();
                },
              );
            },
          );
        }
      });
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    HelperFunctions.getFromPreference("scanner").then((value) {
      nameValue = value;
      print(nameValue.toString());
      if (value == "value3") {
      } else {
        HelperFunctions.saveInPreference("scanner", "value3");
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          show_tutorialcochmark();
        });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey item = GlobalKey();
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> target = [];
  void show_tutorialcochmark() {
    _inittaget();
    tutorialCoachMark = TutorialCoachMark(targets: target, hideSkip: true)
      ..show(context: context);
  }

  void _inittaget() {
    target = [
      TargetFocus(identify: "item", keyTarget: item, contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return Cochmarkdesc(
              text:
                  "Simplify shopping with our QR Scan: Just scan, pay, and enjoy convenient grocery shopping with Gift Cart's exclusive rewards program!",
              onnext: () {
                controller.next();
              },
              onskip: () {
                controller.skip();
              },
            );
          },
        )
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: GestureDetector(
        onTap: () {
          controller?.resumeCamera();
        },
        child: Column(
          children: [
            Container(
              height: 102,
              width: Get.width,
              decoration: BoxDecoration(color: AppColor.whiteColor),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 52,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: Image.asset(
                            key: item,
                            "assets/images/menu.png",
                            height: 38,
                            width: 38,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: AppText(
                            title: "Scanner",
                            size: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColor.boldBlackColor,
                          ),
                        ),
                        AppText(
                          title: testimonimals.tr,
                          size: 0,
                          fontWeight: FontWeight.w500,
                          color: AppColor.whiteColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.orange,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 250,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScanResultDialog extends StatefulWidget {
  final String qrData;
  final Function onClose;

  ScanResultDialog({required this.qrData, required this.onClose});

  @override
  _ScanResultDialogState createState() => _ScanResultDialogState();
}

class _ScanResultDialogState extends State<ScanResultDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(QRValue.tr),
      content: TextFormField(
        initialValue: widget.qrData,
        readOnly: true,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onClose();
            Navigator.of(context).pop();
          },
          child: Text(done.tr),
        ),
      ],
    );
  }
}
