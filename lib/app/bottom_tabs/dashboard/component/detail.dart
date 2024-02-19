import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../util/translation_keys.dart';


class AddDetail extends StatefulWidget {
   AddDetail({super.key,this.data});

  var data;

  @override
  State<AddDetail> createState() => _AddDetailState();
}

class _AddDetailState extends State<AddDetail> {
  String selectTab = "wallet";
  String selectTabs = "earned";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        children: [

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.06,
                ),
                Row(

                  children: [
                    backButton(onTap: (){
                      Get.back();
                    }),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    AppText(
                      title: widget.data.title.toString(),
                      size: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColor.blackLightColor,
                    ),

                  ],
                ),




                SizedBox(height: Get.height*0.015,),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height*0.015,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(widget.data.image,
                              width: Get.width,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: Get.height*0.02,),
                          AppText(
                            title: widget.data.title,
                            size: 16,
                            fontWeight: FontWeight.w600,
                            color:AppColor.blackLightColor,
                          ),

                          SizedBox(height: Get.height*0.02,),
                          Row(


                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/icons/likes.svg"),
                                  SizedBox(width: 7,),
                                  AppText(
                                      title:  ok.tr,
                                      size: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.gray),
                                ],
                              ),
                              SizedBox(width: Get.width*0.03,),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/icons/total.svg"),
                                  SizedBox(width: 7,),
                                  AppText(
                                      title:  ok.tr,
                                      size: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.gray),
                                ],
                              ),
                              SizedBox(width: Get.width*0.03,),

                              Row(
                                children: [
                                  AppText(
                                      title:  published.tr,
                                      size: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.greyLightColor2),
                                  SvgPicture.asset("assets/icons/times.svg",
                                    height: 16,
                                    width: 16,
                                  ),
                                  SizedBox(width: 7,),
                                  AppText(
                                      title:timeago.format(DateTime.parse((widget.data.adDate).toString())),
                                      size: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.blackColor),

                                ],
                              ),

                            ],
                          ),
                          SizedBox(height: Get.height*0.03,),

                          AppText(
                            title:  analytics.tr,
                            size: 16,
                            fontWeight: FontWeight.w600,
                            color:AppColor.blackLightColor,
                          ),


                          SizedBox(height: Get.height*0.015,),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectTabs="earned";
                                  });
                                },
                                child: Container(
                                  height: 42,
                                  width: 100,
                                  decoration:BoxDecoration(
                                    color:
                                    selectTabs=="earned"?AppColor.primaryColor:
                                    AppColor.whiteColor,
                                    gradient:  selectTabs=="earned"?
                                    AppColor.Home_GRADIENT:null,
                                    // border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ) ,
                                  child: Center(
                                    child: AppText(
                                      title:  fiveDays.tr,
                                      size: 12,
                                      fontWeight: FontWeight.w500,
                                      color:
                                      selectTabs=="earned"?AppColor.whiteColor:
                                      AppColor.blackLightColor,
                                    ),
                                  ) ,
                                ),
                              ),
                              SizedBox(width: Get.width*0.04,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectTabs="redeem";
                                  });
                                },
                                child: Container(
                                  height: 42,
                                  width: 108,
                                  decoration:BoxDecoration(
                                    color:
                                    selectTabs=="redeem"?AppColor.primaryColor:
                                    AppColor.whiteColor,
                                    gradient:  selectTabs=="redeem"?
                                    AppColor.Home_GRADIENT:null,
                                    // border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ) ,
                                  child: Center(
                                    child: AppText(
                                      title:  twentyDays.tr,
                                      size: 12,
                                      fontWeight: FontWeight.w500,
                                      color:
                                      selectTabs=="redeem"?AppColor.whiteColor:
                                      AppColor.blackLightColor,
                                    ),
                                  ) ,
                                ),
                              ),
                              SizedBox(width: Get.width*0.04,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectTabs="5";
                                  });
                                },
                                child: Container(
                                  height: 42,
                                  width: 108,
                                  decoration:BoxDecoration(
                                    color:
                                    selectTabs=="5"?AppColor.primaryColor:
                                    AppColor.whiteColor,
                                    gradient:  selectTabs=="5"?
                                    AppColor.Home_GRADIENT:null,
                                    // border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ) ,
                                  child: Center(
                                    child: AppText(
                                      title:  fourtyDays.tr,
                                      size: 12,
                                      fontWeight: FontWeight.w500,
                                      color:
                                      selectTabs=="5"?AppColor.whiteColor:
                                      AppColor.blackLightColor,
                                    ),
                                  ) ,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: Get.height*0.03,),
                          Image.asset("assets/images/graph1.png",
                            height:135 ,
                            width: Get.width,
                            fit: BoxFit.cover,
                          ),
                          // SizedBox(height: Get.height*0.04,),
                          // AppText(
                          //   title: "Invoice details",
                          //   size: 16,
                          //   fontWeight: FontWeight.w600,
                          //   color:AppColor.blackLightColor,
                          // ),
                          //
                          //
                          //
                          //
                          // SizedBox(height: Get.height*0.015,),
                          // GestureDetector(
                          //   onTap: (){
                          //
                          //   },
                          //   child: DottedBorder(
                          //     color: Colors.grey,
                          //     dashPattern: const [8, 4],
                          //     strokeWidth: 1,
                          //     borderType: BorderType.RRect,
                          //     child: ClipRRect(
                          //       borderRadius: BorderRadius.all(Radius.circular(12)),
                          //       child: Container(
                          //
                          //         width: Get.width,
                          //
                          //
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           // border: Border.all(color: Colors.black),
                          //           borderRadius: BorderRadius.circular(10),
                          //           boxShadow: [
                          //             BoxShadow(
                          //               color: Colors.grey.withOpacity(0.1),
                          //               spreadRadius: 2,
                          //               blurRadius: 7,
                          //               offset: const Offset(0, 2), // changes position of shadow
                          //             ),
                          //           ],
                          //         ),
                          //         child: Padding(
                          //           padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04,
                          //               vertical: 15),
                          //           child: Row(
                          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               Column(
                          //                 crossAxisAlignment: CrossAxisAlignment.start,
                          //
                          //
                          //                 children: [
                          //
                          //                   const AppText(
                          //                       title: "Invoice no - #1234223344 ",
                          //                       size: 16,
                          //                       fontWeight: FontWeight.w500,
                          //                       color: AppColor.blackColor),
                          //                   SizedBox(height: Get.height*0.005,),
                          //                   Row(
                          //
                          //                     children: [
                          //                       AppText(
                          //                           title: "Delivery - ",
                          //                           size: 14,
                          //                           fontWeight: FontWeight.w500,
                          //                           color: AppColor.blackColor),
                          //                       AppText(
                          //                           title: "#1232, North way, AB",
                          //                           size: 14,
                          //                           fontWeight: FontWeight.w400,
                          //                           color: AppColor.greyLightColor),
                          //                     ],
                          //                   ),
                          //                   SizedBox(height: Get.height*0.005,),
                          //                   AppText(
                          //                       title: "Date(12-11-2023) ",
                          //                       size: 12,
                          //                       fontWeight: FontWeight.w400,
                          //                       color: AppColor.greyLightColor2),
                          //
                          //                 ],
                          //               ),
                          //               Column(
                          //
                          //
                          //
                          //                 children: [
                          //
                          //                   const AppText(
                          //                       title: "\$23.94",
                          //                       size: 16,
                          //                       fontWeight: FontWeight.w600,
                          //                       color: AppColor.primaryColor),
                          //                   SizedBox(height: Get.height*0.005,),
                          //                   SvgPicture.asset("assets/icons/yes.svg")
                          //
                          //
                          //                 ],
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // )



                        ],
                      )
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
