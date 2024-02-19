import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/component/order_detail.dart';

import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_text.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            body: Column(children: [
              TopBar(onTap1: (){},onTap: (){
                Get.back();
              },text: orders.tr,
                  image: "assets/icons/share.svg",color: AppColor.whiteColor
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: 16,vertical: 7),
                          child:  Obx(() {
                            return

                              Get.put(VendorController()).allPaymentLoader.value?
                              Column(
                                children: [
                                  SizedBox(height: 300,),
                                  Center(
                                      child: SpinKitThreeBounce(
                                          size: 25, color: AppColor.primaryColor)),
                                ],
                              ):
                              Get.put(VendorController()).getProofList.isEmpty?
                              Column(
                                children: [
                                  SizedBox(height: Get.height*0.2,),
                                  Center(child: AppText(title: noOrderData.tr,
                                    color: AppColor.blackColor.withOpacity(0.7),
                                    size: 16,
                                    fontWeight: FontWeight.w500,
                                  ))
                                ],
                              ):
                              ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount:Get.put(VendorController()).getProofList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    DateTime time = DateTime.parse(
                                      Get.put(VendorController()).getProofList[index].createdAt.toString(),
                                    );
                                    return Padding(
                                      padding:  EdgeInsets.symmetric(vertical: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xffF65356).withOpacity(0.1),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {

                                          },
                                          child: Padding(
                                            padding:  EdgeInsets.only(top: 13),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
                                                  child: Row(

                                                    children: [

                                                      Image.asset("assets/icons/grocery.png",
                                                        width: 30,
                                                        height: 30,
                                                      ),
                                                      SizedBox(width: Get.width*0.01,),

                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: Get.width * 0.017),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [

                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  AppText(
                                                                    title: grocery.tr,
                                                                    fontWeight: FontWeight.w600,
                                                                    size: 16,
                                                                    color: AppColor.blackColor,
                                                                  ),
                                                                  SizedBox(height: Get.height*0.001,),
                                                                  AppText(
                                                                    title: "${Get.put(VendorController()).getProofList.length.toString()} items",
                                                                    fontWeight: FontWeight.w500,
                                                                    size:12,
                                                                    color: AppColor.greyLightColor2,
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  AppText(
                                                                    title:

                                                                    "\$${Get.put(VendorController()).getProofList[index].amount.toString()}",
                                                                    fontWeight: FontWeight.w600,
                                                                    size: 16,
                                                                    color: AppColor.blackColor,
                                                                  ),
                                                                  SizedBox(height: Get.height*0.001,),
                                                                  AppText(
                                                                    title: invoice.tr,
                                                                    fontWeight: FontWeight.w500,
                                                                    size: 14,
                                                                    color: AppColor.primaryColor,
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
                                                SizedBox(height: 15,),
                                                Container(
                                                  height: 31,
                                                  width: Get.width,
                                                  decoration: BoxDecoration(
                                                      color: AppColor.primaryColor.withOpacity(0.1)
                                                  ),
                                                  child: Padding(
                                                    padding:  EdgeInsets.symmetric(horizontal: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        AppText(
                                                          title:     DateFormat('MMM dd, yyyy').format(time),
                                                          fontWeight: FontWeight.w500,
                                                          size: 14,
                                                          color: AppColor.blackColor,
                                                        ),
                                                        Container()
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                          }
                          ),
                        ),
                      ],
                    ),
                  ))
            ])),
      ],
    );
  }
}


