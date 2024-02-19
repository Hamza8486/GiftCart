import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_text.dart';

class SlotHistoryData extends StatefulWidget {
  const SlotHistoryData({Key? key}) : super(key: key);

  @override
  State<SlotHistoryData> createState() => _SlotHistoryDataState();
}

class _SlotHistoryDataState extends State<SlotHistoryData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          TopBar(onTap1: (){},onTap: (){
            Get.back();
          },text: ordersAndBookings.tr,
              image: "assets/icons/share.svg",color: AppColor.whiteColor
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
                    Obx(
                            () {
                          return
                            Get.put(HomeController()).slotLoading.value?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: Get.height * 0.32),
                                Center(
                                  child: Container(
                                    height: 57,width: 57,

                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                                      color: AppColor.primaryColor,),
                                    child:  Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          backgroundColor: Colors.white,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              AppColor.primaryColor.withOpacity(0.5) //<-- SEE HERE

                                          ),
                                          // strokeWidth: 5,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ):
                            Get.put(HomeController()).slotHistList.isNotEmpty?
                            ListView.builder(
                                itemCount: Get.put(HomeController()).slotHistList.length,
                                shrinkWrap: true,
                                primary: false,
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 9),
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
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Row(
                                            children: [

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      AppText(
                                                        title: "Invoice no - #${Get.put(HomeController()).slotHistList[index].id.toString()} ",
                                                        size: 15,

                                                        fontWeight: FontWeight.w600,
                                                        color: AppColor.blackColor,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: Get.height*0.01,),
                                                  AppText(
                                                    title: "${Get.put(HomeController()).slotHistList[index].slot.toString()} Coupons (${Get.put(HomeController()).slotHistList[index].name.toString()})",
                                                    size: 14,

                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.blackColor,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              AppText(
                                                title: "\$${Get.put(HomeController()).slotHistList[index].totalPrice.toString()}.00",
                                                size: 16,

                                                fontWeight: FontWeight.w600,
                                                color: AppColor.primaryColor,
                                              ),
                                              SizedBox(height: Get.height*0.01,),
                                              SvgPicture.asset("assets/icons/true.svg")
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  );
                                })


                                :Column(
                              children: [
                                SizedBox(height: Get.height*0.37,),
                                Center(child: AppText(title: noOrderBookingData.tr,
                                  color: AppColor.blackColor.withOpacity(0.7),
                                  size: 16,
                                  fontWeight: FontWeight.w500,
                                ))
                              ],
                            );
                        }
                    ),
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}