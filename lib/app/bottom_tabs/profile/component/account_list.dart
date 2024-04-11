import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/bottom_tabs/component/component.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/add_account.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';
import 'package:giftcart/services/api_manager.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/util/toast.dart';
import 'package:giftcart/util/translation_keys.dart';
import 'package:giftcart/widgets/app_text.dart';

class SaveBanks extends StatefulWidget {
  const SaveBanks({Key? key}) : super(key: key);

  @override
  State<SaveBanks> createState() => _SaveBanksState();
}

class _SaveBanksState extends State<SaveBanks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Column(
            children: [
              TopBar(onTap1: (){},onTap: (){
                Get.back();
              },text: bankAccounts.tr,
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
                                Get.put(HomeController()).accountLoading.value?Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: Get.height * 0.35),
                                    Center(
                                        child: SpinKitThreeBounce(
                                            size: 20, color: AppColor.primaryColor)),
                                  ],
                                ):
                                Get.put(HomeController()).accountList.isNotEmpty?

                                ListView.builder(
                                    itemCount: Get.put(HomeController()).accountList.length,
                                    shrinkWrap: true,
                                    primary: false,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(vertical: 9),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.withOpacity(0.5)),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(

                                            children: [
                                              SizedBox(height: Get.height*0.01,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      AppText(
                                                        title: "${title.tr}: ",
                                                        size: 14,
                                                        fontFamily: AppFont.medium,
                                                        fontWeight: FontWeight.w400,
                                                        color: AppColor.blackColor,
                                                      ),

                                                      AppText(
                                                        title: Get.put(HomeController()).accountList[index].username.toString(),
                                                        size: 14,
                                                        fontFamily: AppFont.medium,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColor.blackColor,
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                              SizedBox(height: Get.height*0.01,),
                                              Row(
                                                children: [
                                                  AppText(
                                                    title:accountNumber.tr,
                                                    size: 14,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColor.blackColor,
                                                  ),

                                                  AppText(
                                                    title: Get.put(HomeController()).accountList[index].accountNo.toString(),
                                                    size: 14,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.blackColor,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: Get.height*0.01,),
                                              Row(
                                                children: [
                                                  AppText(
                                                    title: "Address: ",
                                                    size: 14,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColor.blackColor,
                                                  ),

                                                  Expanded(
                                                    child: AppText(
                                                      title: Get.put(HomeController()).accountList[index].address.toString(),
                                                      size: 14,
                                                      fontFamily: AppFont.medium,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColor.blackColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: Get.height*0.01,),


                                            ],
                                          ),
                                        ),
                                      );
                                    }):Column(children: [
                                  SizedBox(height:280),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(AddAccounts());
                                    },
                                    child: Container(
                                      height: Get.height * 0.052,
                                      width: Get.height * 0.052,
                                      decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(Get.height * 0.1))),
                                      child: Icon(
                                        Icons.add,
                                        color: AppColor.whiteColor,
                                        size: AppSizes.size_20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Center(
                                      child: AppText(
                                        title: "Add bank details to manage\ntransactions seamlessly.",
                                        size: 14,
                                        color: AppColor.greyLightColor2,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  SizedBox(height: Get.height * 0.01),
                                ]);
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
          Obx(
            () {
              return
                Get.put(HomeController()).accountList.isEmpty?SizedBox.shrink():
                Positioned(
                  top: Get.height*0.055,
                  right: 15,
                  child:  GestureDetector(
                    onTap: (){
                      Get.to(AddAccounts());
                    },
                    child: Container(
                      height: Get.height * 0.038,
                      width: Get.height * 0.038,
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Get.height * 0.1))),
                      child: Icon(
                        Icons.add,
                        color: AppColor.whiteColor,
                        size: AppSizes.size_20,
                      ),
                    ),
                  ));
            }
          )
        ],
      ),
    );
  }
}