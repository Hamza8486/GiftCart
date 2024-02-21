import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';

import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/app/home/home_view.dart';
import 'package:mr_bet/services/api_manager.dart';

import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_button.dart';

class HelpCenter extends StatelessWidget {
   HelpCenter({Key? key}) : super(key: key);

  var text= TextEditingController();
  var text1= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            body: Column(children: [
              TopBar(
                  onTap1: () {},
                  onTap: () {
                    Get.back();
                  },
                  text: helpCenter.tr,
                  image: "assets/icons/share.svg",
                  color: AppColor.whiteColor),
              Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          textAuth(text: title.tr),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),

                          betField(
                            hint: enterTitle.tr,
                            max: 1,

                            controller: text1,


                          )
                          ,
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          textAuth(text: writeMessage.tr),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),

                          betField(
                            hint: enterMessage.tr,
                            max: 7,

                            controller: text,


                          ),

                          SizedBox(
                            height: Get.height * 0.06,
                          ),
                          Obx(() {
                            return Get.put(HomeController()).slotAdd.value
                                ?  Center(
                                child: SpinKitThreeBounce(
                                    size: 25, color: AppColor.primaryColor))
                                : AppButton(
                                buttonWidth: Get.width,
                                buttonHeight: Get.height * 0.051,
                                buttonRadius: BorderRadius.circular(30),
                                buttonName: submit.tr,
                                fontWeight: FontWeight.w500,
                                textSize: AppSizes.size_15,
                                buttonColor: Get.put(HomeController())
                                    .slotAddList.isNotEmpty
                                    ? AppColor.primaryColor
                                    : AppColor.primaryColor,
                                textColor: AppColor.whiteColor,
                                onTap: () {
                                  if(validateRegister(context)){
                                    Get.put(HomeController()).updateAddSlot(true);
                                    ApiManger().sendMessage(
                                   text1: text1.text,
                                      text: text.text,
                                      context: context,
                                    );
                                  }

                                });
                          })
                        ],
                      ),
                    ),
                  ))
            ])),
      ],
    );
  }

   bool validateRegister(BuildContext context) {


     if (text1.text.isEmpty) {
       flutterToast(msg: pleaseEnterTitle.tr);
       return false;
     }
     if (text.text.isEmpty) {
       flutterToast(msg: pleaseEnterMessage.tr);
       return false;
     }


     return true;
   }
}


// ignore_for_file: prefer_const_constructors


