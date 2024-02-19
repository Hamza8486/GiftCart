import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_text.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  String selectTab = "store";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(
              onTap1: () {},
              onTap: () {
                Get.back();
              },
              text: invoiceDetails.tr,
              image: "assets/icons/share.svg",
              color: AppColor.whiteColor),
          SizedBox(
            height: Get.height * 0.015,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    ListView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: EdgeInsets.only(
                                top: index == 0 ? 0 : 10, bottom: 10),
                            child: GestureDetector(
                              onTap: () {},
                              child: DottedBorder(
                                color: Colors.grey,
                                dashPattern: const [8, 4],
                                strokeWidth: 1,
                                borderType: BorderType.RRect,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  child: Container(
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.04,
                                          vertical: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const AppText(
                                                  title:
                                                      "Invoice no - #1234223344 ",
                                                  size: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.blackColor),
                                              SizedBox(
                                                height: Get.height * 0.005,
                                              ),
                                              Row(
                                                children: [
                                                  AppText(
                                                      title: "Delivery - ",
                                                      size: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColor.blackColor),
                                                  AppText(
                                                      title:
                                                          "#1232, North way, AB",
                                                      size: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColor
                                                          .greyLightColor),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.005,
                                              ),
                                              AppText(
                                                  title: "Date(12-11-2023) ",
                                                  size: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      AppColor.greyLightColor2),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const AppText(
                                                  title: "\$23.94",
                                                  size: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.primaryColor),
                                              SizedBox(
                                                height: Get.height * 0.005,
                                              ),
                                              SvgPicture.asset(
                                                  "assets/icons/yes.svg")
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ));
                      },
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: index == 0 ? 0 : 6, bottom: 6),
                          child: Container(
                            height: 96,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => Center(
                                            child: SpinKitThreeBounce(
                                                size: 13,
                                                color: AppColor.primaryColor),
                                          ),
                                          imageUrl: "",
                                          height: 58,
                                          width: 58,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            "assets/images/anaar.png",
                                            fit: BoxFit.cover,
                                            height: 87,
                                            width: 130,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.03,
                                          ),
                                          const AppText(
                                              title: "Pomegranate",
                                              size: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.boldBlackColor),
                                          SizedBox(
                                            height: Get.height * 0.003,
                                          ),
                                          Row(
                                            children: [
                                              AppText(
                                                  title: "254 Calories",
                                                  size: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.gray),
                                              SizedBox(
                                                width: Get.width * 0.01,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: 100,
                                    height: 33,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColor.primaryColor,
                                            width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: AppColor.primaryColor,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        AppText(
                                          title: "120",
                                          size: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.primaryColor,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.remove,
                                          color: AppColor.primaryColor,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    AppText(
                        title: totalBill.tr,
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.05,
                            vertical: Get.height * 0.013),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  title: "Subtotal",
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackLightColor,
                                ),
                                AppText(
                                  title: "\$23.94",
                                  size: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackLightColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: DottedDecoration(
                                      color: Colors.grey.withOpacity(0.7),
                                      strokeWidth: 1,
                                      linePosition: LinePosition.bottom,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  title: "PST",
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackLightColor,
                                ),
                                AppText(
                                  title: "\$23.94",
                                  size: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackLightColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: DottedDecoration(
                                      color: Colors.grey.withOpacity(0.7),
                                      strokeWidth: 1,
                                      linePosition: LinePosition.bottom,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  title: "GST",
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackLightColor,
                                ),
                                AppText(
                                  title: "\$23.94",
                                  size: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackLightColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: DottedDecoration(
                                      color: Colors.grey.withOpacity(0.7),
                                      strokeWidth: 1,
                                      linePosition: LinePosition.bottom,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  title: deliveryCharges.tr,
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackLightColor,
                                ),
                                AppText(
                                  title: "\$23.94",
                                  size: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackLightColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: DottedDecoration(
                                      color: Colors.grey.withOpacity(0.7),
                                      strokeWidth: 1,
                                      linePosition: LinePosition.bottom,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  title: studentDiscounts.tr,
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackLightColor,
                                ),
                                AppText(
                                  title: "\$23.94",
                                  size: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackLightColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: DottedDecoration(
                                      color: Colors.grey.withOpacity(0.7),
                                      strokeWidth: 1,
                                      linePosition: LinePosition.bottom,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  title: total.tr,
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackLightColor,
                                ),
                                AppText(
                                  title: "\$23.94",
                                  size: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
