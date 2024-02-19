import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/notification_detail.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_text.dart';

import 'package:timeago/timeago.dart' as timeago;
class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(onTap1: (){},onTap: (){
            Get.back();
          },text: "Notifications",
              image: "assets/icons/share.svg",color: AppColor.whiteColor
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: Get.height*0.025,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                    child: Obx(
                      () {
                        return

                          Get.put(HomeController()).notiLoading.value?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: Get.height * 0.38),
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
                          Get.put(HomeController()).notiList.isEmpty?

                          Column(
                            children: [
                              SizedBox(height: Get.height*0.38,),
                              Center(child: AppText(title: "No Notification Data!",
                                color: AppColor.blackColor.withOpacity(0.7),
                                size: 16,
                                fontWeight: FontWeight.w500,
                              ))
                            ],
                          ):
                          ListView.builder(
                          itemCount:  Get.put(HomeController()).notiList.length,
                          shrinkWrap: true,
                          reverse: true,
                          primary: false,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            DateTime time = DateTime.parse(
                              Get.put(HomeController()).notiList[index].dateController,
                            );
                            return Padding(
                                padding:  EdgeInsets.only(top:

                                index==0?0:10,bottom:10),
                                child:   GestureDetector(
                                  onTap: (){
                                    Get.to(NotificationDetail());
                                  },
                                  child: Container(
                                    width: Get.width,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
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
                                      padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 14),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,


                                        children: [

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                               AppText(
                                                  title: Get.put(HomeController()).notiList[index].title==null?"Notification":Get.put(HomeController()).notiList[index].title.toString(),
                                                  size: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.blackColor),
                                              Row(
                                                children: [
                                                  Container(
                                                    height:6,
                                                    width: 6,
                                                    decoration: BoxDecoration(
                                                        color: AppColor.primaryColor,
                                                        shape: BoxShape.circle
                                                    ),),
                                                  SizedBox(width: Get.width*0.01,),
                                                  GestureDetector(
                                                    onTap: (){
                                                      print(Get.put(HomeController()).notiList[index].time.toString());
                                                    },
                                                    child: AppText(
                                                        title: DateFormat.Hm().format(DateTime.parse("${Get.put(HomeController()).notiList[index].dateController.toString()} ${Get.put(HomeController()).notiList[index].time.toString()}")),
                                                        size: 11,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColor.primaryColor),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: Get.height*0.005,),
                                          AppText(
                                              title: Get.put(HomeController()).notiList[index].text.toString(),
                                              size: 12,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.greyLightColor2),
                                          SizedBox(height: Get.height*0.005,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              AppText(
                                                  title:"${DateFormat('MMM dd, yyyy').format(
                                                      time
                                                  )} ",
                                                  size: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.greyLightColor2),
                                            ],
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            );
                          },
                        );
                      }
                    ),
                  ),




                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
