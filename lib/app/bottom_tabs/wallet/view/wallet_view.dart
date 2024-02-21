import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/tap_pay.dart';
import 'package:mr_bet/app/bottom_tabs/wallet/controller/wallet_controller.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/giftcartapp.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/bottom_sheet.dart';
import 'package:mr_bet/widgets/helper_function.dart';

class WalletView extends StatefulWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  String wallet = "wallet";

  @override
  Widget build(BuildContext context) {
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
                  text: wallet.tr,
                  image: "assets/icons/share.svg",
                  color: AppColor.whiteColor),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          wallet = "wallet";
                        });
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.primaryColor),
                            color: wallet == "wallet"
                                ? AppColor.primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: AppText(
                            title: wallet.tr,
                            size: 12,
                            fontWeight: FontWeight.w500,
                            color: wallet == "wallet"
                                ? Colors.white
                                : AppColor.blackColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          wallet = "gift";
                        });
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.primaryColor),
                            color: wallet == "gift"
                                ? AppColor.primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: AppText(
                            title: giftWallet.tr,
                            size: 12,
                            fontWeight: FontWeight.w500,
                            color: wallet == "gift"
                                ? Colors.white
                                : AppColor.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        AppText(
                          title: wallet == "gift"
                              ? yourTotalWinnings.tr
                              : yourTotalBalance.tr,
                          size: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.greyColors,
                        ),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        wallet == "gift"
                            ? Container(
                                height: 155,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(() {
                                        return Get.put(HomeController())
                                                .transactionLoadingValue
                                                .value
                                            ? Center(
                                                child: SpinKitThreeBounce(
                                                    size: 13,
                                                    color:
                                                        AppColor.primaryColor))
                                            : Get.put(HomeController())
                                                        .totalAmountWallet
                                                        .value ==
                                                    "0"
                                                ? Center(
                                                    child: AppText(
                                                      title: "\$0",
                                                      size: 30,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                : Center(
                                                    child: AppText(
                                                      title: "0",
                                                      size: 25,
                                                      letterSpacing: 1.1,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  );
                                      }),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.06),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Obx(() {
                                                return Get.put(
                                                            PaymentController())
                                                        .checkLoader
                                                        .value
                                                    ? Center(
                                                        child:
                                                            SpinKitThreeBounce(
                                                                size: 25,
                                                                color: AppColor
                                                                    .primaryColor))
                                                    : AppButton(
                                                        buttonWidth: Get.width,
                                                        buttonRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        buttonName: addMoney.tr,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        buttonHeight:
                                                            Get.height * 0.054,
                                                        textSize: 16,
                                                        buttonColor: AppColor
                                                            .primaryColor,
                                                        textColor:
                                                            AppColor.whiteColor,
                                                        onTap: () {
                                                          Get.generalDialog(
                                                              pageBuilder:
                                                                  (context, __,
                                                                          ___) =>
                                                                      AlertDialog(
                                                                        content:
                                                                            SizedBox(
                                                                          height:
                                                                              Get.height * 0.18,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              textAuth(text: enterAmount.tr),
                                                                              SizedBox(
                                                                                height: Get.height * 0.01,
                                                                              ),
                                                                              betField(
                                                                                hint: enterAmount.tr,
                                                                                textInputAction: TextInputAction.done,
                                                                                onChange: (val) {
                                                                                  setState(() {
                                                                                    if (val!.isEmpty || val == "0") {
                                                                                      Get.put(PaymentController()).updateCheckPayment("");
                                                                                      Get.put(PaymentController()).priceController.clear();
                                                                                    } else {
                                                                                      Get.put(PaymentController()).updateCheckPayment(val.toString());
                                                                                    }
                                                                                  });
                                                                                },
                                                                                controller: Get.put(PaymentController()).priceController,
                                                                              ),
                                                                              SizedBox(
                                                                                height: Get.height * 0.025,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: AppButton(
                                                                                        buttonWidth: Get.width,
                                                                                        buttonHeight: Get.height * 0.055,
                                                                                        buttonRadius: BorderRadius.circular(10),
                                                                                        borderColor: AppColor.primaryColor,
                                                                                        borderWidth: 1.5,
                                                                                        buttonName: cancel.tr,
                                                                                        buttonColor: AppColor.transParent,
                                                                                        textColor: AppColor.whiteColor,
                                                                                        onTap: () {
                                                                                          Get.back();
                                                                                        }),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: Get.width * 0.03,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Obx(() {
                                                                                      return AppButton(
                                                                                          buttonWidth: Get.width,
                                                                                          buttonHeight: Get.put(PaymentController()).checkPayment.value.isEmpty ? Get.height * 0.055 : Get.height * 0.055,
                                                                                          buttonRadius: BorderRadius.circular(10),
                                                                                          buttonName: add.tr,
                                                                                          buttonColor: Get.put(PaymentController()).checkPayment.value.isEmpty ? AppColor.primaryColor.withOpacity(0.6) : AppColor.primaryColor,
                                                                                          textColor: AppColor.whiteColor,
                                                                                          onTap: Get.put(PaymentController()).checkPayment.value.isEmpty
                                                                                              ? () {
                                                                                                  flutterToast(msg: pleaseEnterAmount.tr);
                                                                                                }
                                                                                              : () {
                                                                                                  Get.put(PaymentController()).updateCheckLoader(true);
                                                                                                  // Get.put(PaymentController()).priceController.clear();

                                                                                                  Get.back();
                                                                                                  setState(() {
                                                                                                    Get.put(PaymentController()).makePayment(amount: Get.put(PaymentController()).checkPayment.value, currency: 'cad');
                                                                                                  });
                                                                                                });
                                                                                    }),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ));
                                                        });
                                              }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                height: 155,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(() {
                                        return Get.put(HomeController())
                                                .transactionLoadingValue
                                                .value
                                            ? Center(
                                                child: SpinKitThreeBounce(
                                                    size: 13,
                                                    color:
                                                        AppColor.primaryColor))
                                            : Get.put(HomeController())
                                                        .totalAmountWallet
                                                        .value ==
                                                    "0"
                                                ? Center(
                                                    child: AppText(
                                                      title: "\$0",
                                                      size: 30,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                : Center(
                                                    child: AppText(
                                                      title:
                                                          "\$${Get.put(HomeController()).totalAmountWallet.value.toString()}",
                                                      size: 25,
                                                      letterSpacing: 1.1,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  );
                                      }),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.06),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Obx(() {
                                                return Get.put(PaymentController())
                                                        .checkLoader
                                                        .value
                                                    ? Center(
                                                        child: SpinKitThreeBounce(
                                                            size: 25,
                                                            color: AppColor
                                                                .primaryColor))
                                                    : AppButton(
                                                        buttonWidth: Get.width,
                                                        buttonRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        buttonName:
                                                            uploadReceipt.tr,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        buttonHeight:
                                                            Get.height * 0.054,
                                                        textSize:
                                                            AppSizes.size_15,
                                                        buttonColor: AppColor
                                                            .primaryColor,
                                                        textColor:
                                                            AppColor.whiteColor,
                                                        onTap: () {
                                                          setState(() {
                                                            Get.put(HomeController())
                                                                .file1 = null;
                                                            Get.put(HomeController())
                                                                .priceController
                                                                .clear();
                                                          });
                                                          Get.generalDialog(
                                                              pageBuilder:
                                                                  (context, __,
                                                                          ___) =>
                                                                      AlertDialog(
                                                                        content:
                                                                            SizedBox(
                                                                          height:
                                                                              Get.height * 0.18,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              textAuth(text: enterAmount.tr),
                                                                              SizedBox(
                                                                                height: Get.height * 0.01,
                                                                              ),
                                                                              betField(
                                                                                hint: enterAmount.tr,
                                                                                textInputAction: TextInputAction.done,
                                                                                onChange: (val) {
                                                                                  setState(() {
                                                                                    if (val!.isEmpty || val == "0") {
                                                                                      Get.put(PaymentController()).updateCheckPayment("");
                                                                                      Get.put(PaymentController()).priceController.clear();
                                                                                    } else {
                                                                                      Get.put(PaymentController()).updateCheckPayment(val.toString());
                                                                                    }
                                                                                  });
                                                                                },
                                                                                controller: Get.put(PaymentController()).priceController,
                                                                              ),
                                                                              SizedBox(
                                                                                height: Get.height * 0.025,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: AppButton(
                                                                                        buttonWidth: Get.width,
                                                                                        buttonHeight: Get.height * 0.055,
                                                                                        buttonRadius: BorderRadius.circular(10),
                                                                                        borderColor: AppColor.primaryColor,
                                                                                        borderWidth: 1.5,
                                                                                        buttonName: cancel.tr,
                                                                                        buttonColor: AppColor.transParent,
                                                                                        textColor: AppColor.whiteColor,
                                                                                        onTap: () {
                                                                                          Get.back();
                                                                                        }),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: Get.width * 0.03,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Obx(() {
                                                                                      return AppButton(
                                                                                          buttonWidth: Get.width,
                                                                                          buttonHeight: Get.put(PaymentController()).checkPayment.value.isEmpty ? Get.height * 0.055 : Get.height * 0.055,
                                                                                          buttonRadius: BorderRadius.circular(10),
                                                                                          buttonName: add.tr,
                                                                                          buttonColor: Get.put(PaymentController()).checkPayment.value.isEmpty ? AppColor.primaryColor.withOpacity(0.6) : AppColor.primaryColor,
                                                                                          textColor: AppColor.whiteColor,
                                                                                          onTap: Get.put(PaymentController()).checkPayment.value.isEmpty
                                                                                              ? () {
                                                                                                  flutterToast(msg: pleaseEnterAmount.tr);
                                                                                                }
                                                                                              : () {
                                                                                                  Get.put(PaymentController()).updateCheckLoader(true);
                                                                                                  // Get.put(PaymentController()).priceController.clear();

                                                                                                  Get.back();
                                                                                                  setState(() {
                                                                                                    Get.put(PaymentController()).makePayment(amount: Get.put(PaymentController()).checkPayment.value, currency: 'cad');
                                                                                                  });
                                                                                                });
                                                                                    }),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ));
                                                        });
                                              }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        AppText(
                          title: transactions.tr,
                          size: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.greyColors,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        wallet != "gift"
                            ? Obx(() {
                                return Get.put(HomeController())
                                        .transactionLoadingValue
                                        .value
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: Get.height * 0.05),
                                          Center(
                                              child: SpinKitThreeBounce(
                                                  size: 25,
                                                  color:
                                                      AppColor.primaryColor)),
                                        ],
                                      )
                                    : Get.put(HomeController())
                                            .transList
                                            .isNotEmpty
                                        ? ListView.builder(
                                            itemCount: Get.put(HomeController())
                                                .transList
                                                .length,
                                            shrinkWrap: true,
                                            primary: false,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              DateTime time = DateTime.parse(
                                                Get.put(HomeController())
                                                    .transList[index]
                                                    .createdAt
                                                    .toString(),
                                              );

                                              DateTime dateTime =
                                                  DateTime.parse(
                                                      Get.put(HomeController())
                                                          .transList[index]
                                                          .createdAt
                                                          .toString());
                                              String formattedTime =
                                                  DateFormat('hh:mm a')
                                                      .format(dateTime);
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 9),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(0.5)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: Get.height *
                                                                0.05,
                                                            width: Get.height *
                                                                0.05,
                                                            decoration: BoxDecoration(
                                                                color: AppColor
                                                                    .primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Center(
                                                              child: AppText(
                                                                title: Get.put(
                                                                        HomeController())
                                                                    .transList[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                size: AppSizes
                                                                    .size_14,
                                                                fontFamily:
                                                                    AppFont
                                                                        .medium,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColor
                                                                    .whiteColor,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: Get.width *
                                                                0.04,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              AppText(
                                                                title:
                                                                    "\$${Get.put(HomeController()).transList[index].amount.toString()}",
                                                                size: AppSizes
                                                                    .size_15,
                                                                fontFamily:
                                                                    AppFont
                                                                        .medium,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColor
                                                                    .blackColor,
                                                              ),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              AppText(
                                                                title:
                                                                    "${DateFormat('dd MMM yyyy').format(time)} ",
                                                                size: AppSizes
                                                                    .size_13,
                                                                fontFamily:
                                                                    AppFont
                                                                        .regular,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColor
                                                                    .blackColor,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      AppText(
                                                        title: formattedTime
                                                            .toString(),
                                                        size: AppSizes.size_13,
                                                        fontFamily:
                                                            AppFont.regular,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColor.blackColor,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.1,
                                              ),
                                              Center(
                                                  child: AppText(
                                                title: noTransactionData.tr,
                                                color: AppColor.blackColor
                                                    .withOpacity(0.7),
                                                size: 16,
                                                fontWeight: FontWeight.w500,
                                              ))
                                            ],
                                          );
                              })
                            : ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                primary: false,
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 9),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: Get.height * 0.05,
                                                width: Get.height * 0.05,
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColor.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                  child: AppText(
                                                    title: db.tr,
                                                    size: AppSizes.size_14,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.whiteColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.04,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AppText(
                                                    title: groceryCoupon.tr,
                                                    size: AppSizes.size_15,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.blackColor,
                                                  ),
                                                  AppText(
                                                    title: "Coupon : 23Wcd345 ",
                                                    size: AppSizes.size_13,
                                                    fontFamily: AppFont.regular,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColor
                                                        .greyLightColor2,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          AppText(
                                            title: "\$3600.00",
                                            size: 14,
                                            fontFamily: AppFont.regular,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.blackColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: AppButton(
                    buttonWidth: Get.width,
                    buttonRadius: BorderRadius.circular(10),
                    buttonName: uploadReceipt.tr,
                    fontWeight: FontWeight.w500,
                    buttonHeight: Get.height * 0.054,
                    textSize: AppSizes.size_15,
                    buttonColor: AppColor.primaryColor,
                    textColor: AppColor.whiteColor,
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          isDismissible: true,
                          context: context,
                          builder: (context) => UploadReceiipt());
                    }),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Positioned(
              top: Get.height * 0.058,
              right: 60,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context,
                      builder: (context) => infoWidget());
                },
                child: Image.asset(
                  "assets/icons/info.png",
                  height: 25,
                  width: 25,
                ),
              )),
          Positioned(
              top: Get.height * 0.06,
              right: 18,
              child: GestureDetector(
                onTap: () {
                  Get.to(TapPay(), transition: Transition.rightToLeft);
                },
                child: Image.asset(
                  "assets/icons/bar.png",
                  height: 23,
                  width: 23,
                ),
              ))
        ],
      ),
    );
  }

  bool validateReceipt(BuildContext context) {
    if (Get.put(HomeController()).file1 == null) {
      flutterToast(msg: pleaseUploadReceipt.tr);
      return false;
    }
    if (Get.put(HomeController()).priceController.text.isEmpty) {
      flutterToast(msg: pleaseEnterPrice.tr);
      return false;
    }

    return true;
  }
}

class UploadReceiipt extends StatefulWidget {
  const UploadReceiipt({super.key});

  @override
  State<UploadReceiipt> createState() => _UploadReceiiptState();
}

class _UploadReceiiptState extends State<UploadReceiipt> {
  bool stripe = false;
  File? file;
  File? file1;

  var amoountCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.85,
      maxChildSize: 0.85,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/slide.png",
                    scale: 3,
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              AppText(
                  title: uploadPaymentProof.tr,
                  size: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackColor),
              SizedBox(
                height: Get.height * 0.04,
              ),
              textAuth(text: amount.tr, color: Colors.transparent),
              SizedBox(
                height: Get.height * 0.01,
              ),
              betField(
                  hint: "\$300",
                  max: 1,
                  controller: amoountCon,
                  textInputAction: TextInputAction.done),
              SizedBox(
                height: Get.height * 0.02,
              ),
              textAuth(text: uploadBillCopy.tr, color: Colors.transparent),
              SizedBox(height: Get.height * 0.01),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (builder) => bottomSheet(onCamera: () {
                            Navigator.pop(context);
                            HelperFunctions.pickImage(ImageSource.camera)
                                .then((value) {
                              setState(() {
                                file = value!;
                              });
                            });
                          }, onGallery: () {
                            Navigator.pop(context);
                            HelperFunctions.pickImage(ImageSource.gallery)
                                .then((value) {
                              setState(() {
                                file = value!;
                              });
                            });
                          }));
                },
                child: Container(
                  width: Get.width,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.greyLightColor2)),
                  child: file == null
                      ? Center(
                          child: Icon(
                            Icons.add,
                            color: AppColor.blackColor,
                            size: 40,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            file as File,
                            fit: BoxFit.cover,
                            height: 120,
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              textAuth(text: uploadPaymentProof.tr, color: Colors.transparent),
              SizedBox(height: Get.height * 0.01),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (builder) => bottomSheet(onCamera: () {
                            Navigator.pop(context);
                            HelperFunctions.pickImage(ImageSource.camera)
                                .then((value) {
                              setState(() {
                                file1 = value!;
                              });
                            });
                          }, onGallery: () {
                            Navigator.pop(context);
                            HelperFunctions.pickImage(ImageSource.gallery)
                                .then((value) {
                              setState(() {
                                file1 = value!;
                              });
                            });
                          }));
                },
                child: Container(
                  width: Get.width,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.greyLightColor2)),
                  child: file1 == null
                      ? Icon(
                          Icons.add,
                          color: AppColor.blackColor,
                          size: 40,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            file1 as File,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              Spacer(),
              Obx(() {
                return Get.put(HomeController()).paymentProof.value
                    ? Center(
                        child: SpinKitThreeBounce(
                            size: 25, color: AppColor.primaryColor))
                    : AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(10),
                        buttonName: upload.tr,
                        fontWeight: FontWeight.w600,
                        textSize: 16,
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          if (validateUploadProof(context)) {
                            Get.put(HomeController()).updatePaymentProof(true);
                            ApiManger().paymentProof(
                                context: context,
                                title: amoountCon.text,
                                file1: file1,
                                file: file);
                          }
                        },
                        buttonColor: AppColor.primaryColor,
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }

  bool validateUploadProof(BuildContext context) {
    if (amoountCon.text.isEmpty) {
      flutterToast(msg: enterAmount.tr);
      return false;
    }
    if (file == null) {
      flutterToast(msg: uploadBillCopy.tr);
      return false;
    }
    if (file1 == null) {
      flutterToast(msg: pleaseUploadPaymentCopy.tr);
      return false;
    }

    return true;
  }
}

Widget infoWidget() {
  return DraggableScrollableSheet(
    initialChildSize: 0.7,
    minChildSize: 0.7,
    maxChildSize: 0.7,
    builder: (_, controller) => Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/slide.png",
                  scale: 3,
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            AppText(
                title: infoAboutCoupons.tr,
                size: 20,
                fontWeight: FontWeight.w600,
                color: AppColor.blackColor),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  primary: false,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          AppText(
                              title: "${index + 1} - ",
                              size: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.blackColor),
                          AppText(
                              title: clearExpDateForeachCoupon.tr,
                              size: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.blackColor),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ),
  );
}

class LanguageWidget extends StatefulWidget {
  LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  List language = [
    {"title": "ENG", "sub": "English", "code": "en"},
    {"title": "Français", "sub": "French", "code": "fr"},
    {"title": "Punjabi", "sub": "Punjabi", "code": "pa"},
    {"title": "Español", "sub": "Spanish", "code": "es"},
    {"title": "Italiano", "sub": "Italian", "code": "it"},
    {"title": "Deutsch", "sub": "German", "code": "nl"},
    {"title": "Tagalog", "sub": "Tagalog", "code": "tl"},
    {"title": "Chinese", "sub": "Chinese", "code": "zh"},
  ];

  int indexValue = 0;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.7,
      maxChildSize: 0.7,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/slide.png",
                    scale: 3,
                  )
                ],
              ),
              SizedBox(
                height: 38,
              ),
              AppText(
                  title: selectLanguage.tr,
                  size: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackColor),
              SizedBox(
                height: 38,
              ),
              Expanded(
                child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 100 / 100,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemCount: language.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(()  {
                            indexValue = index;
                            Locale locale = new Locale(language[index]
                                ['code']); //languageCode=ru or es
                            Get.updateLocale(locale);
                            GiftCartApp.updateLocale(language[index]['code']);
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: indexValue == index
                                  ? AppColor.Home_GRADIENT
                                  : null,
                              border: Border.all(
                                  color: indexValue == index
                                      ? AppColor.primaryColor
                                      : AppColor.greyLightColor2
                                          .withOpacity(0.5))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText(
                                title: language[index]["title"],
                                size: 16,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                                color: indexValue == index
                                    ? AppColor.whiteColor
                                    : AppColor.blackColor,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              AppText(
                                title: language[index]["sub"],
                                size: 14,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w400,
                                color: indexValue == index
                                    ? AppColor.whiteColor
                                    : AppColor.greyLightColor2,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              AppButton(
                  buttonWidth: Get.width,
                  buttonRadius: BorderRadius.circular(10),
                  buttonName: apply.tr,
                  gard: true,
                  fontWeight: FontWeight.w600,
                  textSize: 16,
                  buttonColor: AppColor.primaryColor,
                  textColor: AppColor.whiteColor,
                  onTap: () {
                    Get.back();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class GiftNow extends StatelessWidget {
  const GiftNow({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.6,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/slide.png",
                    scale: 3,
                  )
                ],
              ),
              SizedBox(
                height: 38,
              ),
              AppText(
                  title: congratulationsScratchCoupon.tr,
                  size: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackColor),
              SizedBox(
                height: 38,
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      "assets/images/gif.png",
                      width: 142,
                      height: 164,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    AppText(
                        title: youHaveWonGiftCoupon.tr,
                        size: 16,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                    SizedBox(
                      height: 48,
                    ),
                  ],
                ),
              ),
              AppButton(
                  buttonWidth: Get.width,
                  buttonRadius: BorderRadius.circular(10),
                  buttonName: claimNow.tr,
                  gard: true,
                  fontWeight: FontWeight.w600,
                  textSize: 16,
                  buttonColor: AppColor.primaryColor,
                  textColor: AppColor.whiteColor,
                  onTap: () {
                    Get.back();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class OtherUserWin extends StatelessWidget {
  const OtherUserWin({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.6,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/slide.png",
                    scale: 3,
                  )
                ],
              ),
              SizedBox(
                height: 38,
              ),
              AppText(
                  title: todaysWinner.tr,
                  size: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackColor),
              SizedBox(
                height: 38,
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      "assets/images/gif.png",
                      width: 142,
                      height: 164,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                     AppText(
                        title: userHaveWon.tr,
                        size: 16,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                    SizedBox(
                      height: 48,
                    ),
                  ],
                ),
              ),
              AppButton(
                  buttonWidth: Get.width,
                  buttonRadius: BorderRadius.circular(10),
                  buttonName: message.tr,
                  gard: true,
                  fontWeight: FontWeight.w600,
                  textSize: 16,
                  buttonColor: AppColor.primaryColor,
                  textColor: AppColor.whiteColor,
                  onTap: () {
                    Get.back();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
