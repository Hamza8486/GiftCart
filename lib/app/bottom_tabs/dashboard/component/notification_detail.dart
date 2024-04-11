import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/bottom_tabs/component/component.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/claim_view.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/widgets/app_button.dart';
import 'package:giftcart/widgets/app_text.dart';




class NotificationData extends StatefulWidget {
  NotificationData({super.key,this.type,this.data});

  var data;
  var type;



  @override
  State<NotificationData> createState() => _NotificationDataState();
}

class _NotificationDataState extends State<NotificationData> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(onTap1: (){},onTap: (){
            Get.back();
          },text: "Notification Detail",
              image: "assets/icons/share.svg",color: AppColor.whiteColor
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                widget.type=="user"?Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height*0.01,),
                    AppText(
                        title:"${widget.data.text.toString().split("\n").first}: ",
                        size: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                    SizedBox(height: 10,),
                    AppText(
                        title:"${widget.data.text.toString().split("\n").last} 🎁",
                        size: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackColor),
                    SizedBox(height: 10,),


                  ],
                ):
                widget.type=="win"?

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                        title:"Congratulations! You've got a year's supply of groceries from MR Gift Cart! Enjoy your shopping spree!",
                        size: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blackColor),
                    SizedBox(height: 10,),
                    AppText(
                        title:"To claim your year's supply of groceries from MR Gift Cart, simply follow these steps:",
                        size: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackColor),
                    SizedBox(height: 10,),
                    AppText(
                        title:"Click on the 'Claim Now' button.",
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                    SizedBox(height: 5,),
                    AppText(
                        title:"1. Fill out the form with your Name, BC ID, Phone Number, Email, and Address.",
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                    SizedBox(height: 5,),
                    AppText(
                        title:"2. Don't forget to attach a photo and a short video expressing your excitement!",
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                    SizedBox(height: 5,),
                    AppText(
                        title:"3. Click on 'Claim Now' to submit your entry.",
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),

                  ],
                ):Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                        title:"To everyone else: Stay tuned, you could be the next family member! We're thrilled to have you as part of our community.",
                        size: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blackColor),
                    SizedBox(height: 10,),
                    AppText(
                        title:"Let's all congratulate together and wish them happy shopping!",
                        size: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackColor),


                  ],
                ),
              ),
            ),
          ),

          widget.type=="user"?SizedBox.shrink():
          widget.type=="win"?

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppButton(
                buttonWidth: Get.width,
                buttonRadius: BorderRadius.circular(10),
                buttonName: "Claim Now", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor, onTap: (){
              Get.to(ClaimView(), transition: Transition.rightToLeft);
            }),
          ):SizedBox.shrink()





        ],
      ),
    );
  }
}

