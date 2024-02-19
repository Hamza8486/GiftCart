import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/notification_view.dart';
import 'package:mr_bet/app/bottom_tabs/wallet/view/wallet_view.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';

Widget dashboardTopBar({onTap,onTap1,text,boo}){
  return Container(
    decoration: BoxDecoration(boxShadow:  [

      BoxShadow(
        color: AppColor.greyColor.withOpacity(0.4),
        spreadRadius: 2,
        blurRadius: 3,
        offset: Offset(0, 0.01),

      ),
    ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Padding(
      padding:  EdgeInsets.only(left: Get.width*0.03,right: Get.width*0.03,bottom: 8),
      child: Column(
        children: [
          SizedBox(height: Get.height*0.05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              navBar(onTap:onTap),

              Row(
                children: [
                  Image.asset("assets/images/logo1.png",height: Get.height*0.065,


                  ),
                  SizedBox(width: Get.width*0.13,),
                 GestureDetector(
                   onTap: (){
                     Get.to(NotificationView());
                   },
                   child: Image.asset("assets/icons/not.png",
                   height: 32,
                     width: 32,
                   ),
                 ),
                  SizedBox(width: Get.width*0.16,),
                  Container()
                ],
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget profileWidget({text, image , Widget? child,onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  child: SvgPicture.asset(
                    image,
                    height: Get.height * 0.027,
                    color: AppColor.primaryColor,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                AppText(
                  title: text,
                  size: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.boldBlackColor,
                ),
              ],
            ),
            child?? SizedBox.shrink(),

          ],
        ),
      ),
    ),
  );
}
Widget toggleButton(){

  final animationDuration = Duration(milliseconds: 500);
  return Obx(
          () {
        return GestureDetector(
          onTap: (){
            Get.put(HomeController()).isValue.value =!Get.put(HomeController()).isValue.value;
          },
          child: AnimatedContainer(
            height: 23,
            width: 44,
            duration: animationDuration,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Get.put(HomeController()).isValue.value == true ? AppColor.primaryColor :AppColor.grey,
              border: Border.all(
                  color: Get.put(HomeController()).isValue.value == true ? AppColor.primaryColor :AppColor.grey,
                  width: 1.5
              ),

            ),
            child: AnimatedAlign(
              duration: animationDuration,
              alignment: Get.put(HomeController()).isValue.value == true ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Get.put(HomeController()).isValue.value == true ? AppColor.whiteColor :AppColor.whiteColor,
                  ),
                ),
              ),
            ),

          ),
        );
      }
  );
}
Widget toggleButton1(){

  final animationDuration = Duration(milliseconds: 500);
  return Obx(
          () {
        return GestureDetector(
          onTap: (){
           // Get.put(HomeController()).isValue1.value =!Get.put(HomeController()).isValue1.value;
          },
          child: AnimatedContainer(
            height: 23,
            width: 44,
            duration: animationDuration,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Get.put(HomeController()).isValue1.value == true ? AppColor.primaryColor :AppColor.grey,
              border: Border.all(
                  color: Get.put(HomeController()).isValue1.value == true ? AppColor.primaryColor :AppColor.grey,
                  width: 1.5
              ),

            ),
            child: AnimatedAlign(
              duration: animationDuration,
              alignment: Get.put(HomeController()).isValue1.value == true ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Get.put(HomeController()).isValue1.value == true ? AppColor.whiteColor :AppColor.whiteColor,
                  ),
                ),
              ),
            ),

          ),
        );
      }
  );
}
Widget toggleButton2(){

  final animationDuration = Duration(milliseconds: 500);
  return Obx(
          () {
        return GestureDetector(
          onTap: (){
            Get.put(HomeController()).isValue2.value =!Get.put(HomeController()).isValue2.value;
            print(Get.put(HomeController()).isValue2.value);
            Get.put(HomeController()).updateValue2(Get.put(HomeController()).isValue2.value);
          },
          child: AnimatedContainer(
            height: 23,
            width: 44,
            duration: animationDuration,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Get.put(HomeController()).isValue2.value == true ? AppColor.primaryColor :AppColor.grey,
              border: Border.all(
                  color: Get.put(HomeController()).isValue2.value == true ? AppColor.primaryColor :AppColor.grey,
                  width: 1.5
              ),

            ),
            child: AnimatedAlign(
              duration: animationDuration,
              alignment: Get.put(HomeController()).isValue2.value == true ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Get.put(HomeController()).isValue2.value == true ? AppColor.whiteColor :AppColor.whiteColor,
                  ),
                ),
              ),
            ),

          ),
        );
      }
  );
}


Widget TopBar({onTap,onTap1,text,image,color,bool isValue=false,Widget?Child}){
  return Container(
    decoration: BoxDecoration(boxShadow:  [

      BoxShadow(
        color: AppColor.greyColor.withOpacity(0.4),
        spreadRadius: 2,
        blurRadius: 3,
        offset: Offset(0, 0.01),

      ),
    ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Padding(
      padding:  EdgeInsets.only(left: Get.width*0.035,right: Get.width*0.03,bottom: 10),
      child: Column(
        children: [
          SizedBox(height: Get.height*0.055,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isValue?navBar(onTap: onTap):
              Child??
              GestureDetector(
              onTap: onTap,
              child: Image.asset("assets/icons/backs.png",
              height: 30,
                width: 30,
              )),
              AppText(
                title: text,
                size: 17,
                fontWeight: FontWeight.w600,
                color: AppColor.boldBlackColor,
              ),
              GestureDetector(
                onTap: onTap1,
                child: SvgPicture.asset(image,
                color: color,
                ),
              )


            ],
          ),
        ],
      ),
    ),
  );
}