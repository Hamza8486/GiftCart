import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/component/notification_detail.dart';
import 'package:intl/intl.dart';
import 'package:giftcart/app/bottom_tabs/component/component.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/notification_detail.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/util/translation_keys.dart';
import 'package:giftcart/widgets/app_text.dart';

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
          },text: notifications.tr,
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

                          Column(children: [
                            SizedBox(height:Get.height*0.3),
                            Image.asset(
                              "assets/icons/cloud.png",
                              height: 50,
                              width: 50,
                            ),
                            SizedBox(height: Get.height * 0.01),
                            Center(
                                child: AppText(
                                  title: "No Data!",
                                  size: 14,
                                  color: AppColor.greyLightColor2,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w500,
                                )),
                            SizedBox(height: Get.height * 0.01),
                          ]):
                          ListView.builder(
                          itemCount:  Get.put(HomeController()).notiList.length,
                          shrinkWrap: true,
                          reverse: true,
                          primary: false,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            DateTime time = DateTime.parse(
                              Get.put(HomeController()).notiList[index].date,
                            );
                            return Padding(
                                padding:  EdgeInsets.only(top:

                                index==0?0:10,bottom:10),
                                child:   GestureDetector(
                                  onTap: (){


                                    Get.to(NotificationData(data:Get.put(HomeController()).notiList[index] ,
                                      type: Get.put(HomeController()).notiList[index].title=="Slot Message"?"user":
                                      Get.put(HomeController()).notiList[index].title=="Slot win"?"win":

                                      "",

                                    ));
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
                                                  title: Get.put(HomeController()).notiList[index].title==null?"Notification":
                                                  Get.put(HomeController()).notiList[index].title=="Slot win"?"One year give way":
                                                  Get.put(HomeController()).notiList[index].title=="Slot Message"?"User Message":

                                                  Get.put(HomeController()).notiList[index].title.toString(),
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
                                                        title: DateFormat.Hm().format(DateTime.parse("${Get.put(HomeController()).notiList[index].date.toString()} ${Get.put(HomeController()).notiList[index].time.toString()}")),
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
