import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/business_register.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/auth/partner_signup/basic_info.dart';
import 'package:mr_bet/app/auth/register.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';

import '../../util/translation_keys.dart';



class AccountType extends StatefulWidget {
  const AccountType({Key? key}) : super(key: key);

  @override
  State<AccountType> createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountType> {

  String type="user";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
              right: Get.width * 0.04,left: Get.width * 0.04, top: Get.height * 0.08, bottom: Get.height * 0.03),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(

                    children: [
                      SizedBox(height: Get.height*0.17,),
                      Center(
                          child: Image.asset(
                            "assets/images/logo1.png",
                            height:82,
                            width: 110,
                          )),
                      Column(

                        children: [
                          SizedBox(height: Get.height*0.07,),

                          AppText(
                              title: accountType.tr,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.w500,
                              size: 20),

                          AppText(
                              title: chooseAccType,
                              color: AppColor.greyColor,
                              fontWeight: FontWeight.w400,
                              size: 14),
                          SizedBox(
                            height: Get.height * 0.08,
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      type="user";
                                      Get.put(AuthController()).updateNameProv("");
                                    });

                                  },
                                  child: typeWidget(
                                    text: individual.tr,
                                    image: "assets/images/user.svg",
                                    color:type == "user"
                                        ? AppColor.primaryColor
                                        : AppColor.whiteColor,
                                    color1: type == "user"
                                        ? AppColor.primaryColor
                                        : AppColor.whiteColor,
                                    color2: type == "user"
                                        ? AppColor.primaryColor1
                                        : AppColor.whiteColor,
                                    textColor:type == "user"
                                        ? AppColor.whiteColor
                                        : AppColor.greyColors,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.04,
                                ),
                                AppText(
                                    title: or_.tr,
                                    color: AppColor.whiteColor,
                                    fontFamily: AppFont.medium,
                                    size: AppSizes.size_15),
                                SizedBox(
                                  width: Get.width * 0.04,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Get.put(AuthController()).updateNameProv("");
                                        type="admin";
                                      });
                                    },
                                    child: typeWidget(
                                        text: business.tr,
                                        image: "assets/images/home.svg",
                                        color:type == "admin"
                                            ? AppColor.primaryColor
                                            : AppColor.whiteColor,
                                        color1: type == "admin"
                                            ? AppColor.primaryColor
                                            : AppColor.whiteColor,
                                        color2: type == "admin"
                                            ? AppColor.primaryColor1
                                            : AppColor.whiteColor,
                                        textColor:type == "admin"
                                            ? AppColor.whiteColor
                                            : AppColor.greyColors,
                                        imageColor: type == "admin"
                                            ? AppColor.blackColor
                                            : null
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.02,),
              AppButton(
                  buttonWidth: Get.width,
                  buttonRadius: BorderRadius.circular(10),
                  buttonName:  next.tr,
                  fontWeight: FontWeight.w500,
                  textSize: AppSizes.size_15,
                  buttonColor: AppColor.primaryColor,
                  textColor: AppColor.whiteColor,
                  onTap:
                  type=="user"  ?
                      () {
                        Get.put(AuthController()).clear();
                    Get.to(Register());


                  }:(){
                    Get.put(AuthController()).clear();
                    Get.to(BasicInformation());
                  }),
              SizedBox(height: Get.height*0.02,),
            ],
          ),
        )
    );
  }
}
Widget typeWidget({
  image,
  text,
  color,
  color1,
  color2,
  Color?textColor,
  Color?imageColor
}) {
  return Container(
    height: 100,
    width: 130,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColor.primaryColor1,width: 1.3),
      gradient: new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
        color2,
          color1,



        ],
      ),
    ),
    child: SizedBox(
      height: Get.height*0.13,
      width: Get.height*0.14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            color: imageColor,
            height: Get.height * 0.042,
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          AppText(
              title: text,
              color: textColor??AppColor.greyColors,
             fontWeight: FontWeight.w500,
              size: 14),
        ],
      ),
    ),
  );
}