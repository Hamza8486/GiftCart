import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/auth/component.dart';
import 'package:giftcart/app/bottom_tabs/component/component.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/all_data.dart';
import 'package:giftcart/app/bottom_tabs/wallet/controller/wallet_controller.dart';
import 'package:giftcart/services/api_manager.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/util/toast.dart';
import 'package:giftcart/util/translation_keys.dart';
import 'package:giftcart/widgets/app_button.dart';
import 'package:giftcart/widgets/app_text.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class TapPay extends StatefulWidget {
  const TapPay({Key? key}) : super(key: key);

  @override
  State<TapPay> createState() => _TapPayState();
}

class _TapPayState extends State<TapPay> {
  var amountController = TextEditingController();
  var barCodeController = TextEditingController();

  Barcode? result;
  QRViewController? controller;

  var qrData = TextEditingController();

  //
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          controller!.pauseCamera();
          barCodeController.text = result!.code.toString();
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
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              TopBar(
                  onTap1: () {},
                  onTap: () {
                    Get.back();
                  },
                  text: tapToPay.tr,
                  image: "assets/icons/share.svg",
                  color: AppColor.whiteColor),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: GestureDetector(
                            onTap: () {
                              controller?.resumeCamera();
                              setState(() {});
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
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
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Center(
                          child: AppText(
                            title: or.tr,
                            size: AppSizes.size_16,
                            fontFamily: AppFont.medium,
                            fontWeight: FontWeight.w600,
                            color: AppColor.boldBlackColor.withOpacity(0.6),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        textAuth(text: barcode.tr),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(
                          hint: barcode.tr,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.phone,
                          controller: barCodeController,
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        textAuth(text: amount.tr),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(
                          hint: "300\$",
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.phone,
                          controller: amountController,
                        ),
                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              isKeyBoard
                  ? SizedBox.shrink()
                  : Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.005,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                          child: Obx(() {
                            return Get.put(PaymentController()).storePayment.value
                                ? Center(
                                    child: SpinKitThreeBounce(
                                        size: 25, color: AppColor.primaryColor))
                                : AppButton(
                                    buttonWidth: Get.width,
                                    buttonRadius: BorderRadius.circular(10),
                                    buttonName: payWithBarCode.tr,
                                    fontWeight: FontWeight.w500,
                                    textSize: AppSizes.size_14,
                                    fontFamily: AppFont.medium,
                                    buttonColor: AppColor.primaryColor,
                                    textColor: AppColor.whiteColor,
                                    onTap: () {
                                      if (barCodeController.text.isEmpty) {
                                        flutterToast(
                                            msg: pleaseEnterOrScanBarcode.tr);
                                      } else if (amountController.text.isEmpty) {
                                        flutterToast(msg: enterAmount.tr);
                                      } else {
                                        Get.put(PaymentController())
                                            .updateStorePayment(true);
                                        ApiManger().addPaymentStore(
                                            id: barCodeController.text, amount: amountController.text);
                                      }
                                    });
                          }),
                        ),
                        SizedBox(
                          height: Get.height * 0.012,
                        ),
                      ],
                    )
            ],
          ),
          Positioned(
              top: Get.height * 0.058,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Get.to(AllData(name: "Payment to grocery store",link: "https://admin.mr-corp.ca/help/Payment%20to%20grocery%20store",));

                },
                child: Image.asset(
                  "assets/icons/info.png",
                  height: 25,
                  width: 25,
                ),
              )),
        ],
      ),
    );
  }
}
