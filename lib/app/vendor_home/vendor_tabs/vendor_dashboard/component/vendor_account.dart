import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/component/add_acc.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_text.dart';

class VendorSaveBanks extends StatefulWidget {
  const VendorSaveBanks({Key? key}) : super(key: key);

  @override
  State<VendorSaveBanks> createState() => _VendorSaveBanksState();
}

class _VendorSaveBanksState extends State<VendorSaveBanks> {
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
                                Get.put(VendorController()).accountLoading.value?Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: Get.height * 0.35),
                                    Center(
                                        child: SpinKitThreeBounce(
                                            size: 20, color: AppColor.primaryColor)),
                                  ],
                                ):
                                Get.put(VendorController()).accountList.isNotEmpty?

                                ListView.builder(
                                    itemCount: Get.put(VendorController()).accountList.length,
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
                                                        title: title.tr,
                                                        size: AppSizes.size_15,
                                                        fontFamily: AppFont.medium,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColor.blackColor,
                                                      ),

                                                      AppText(
                                                        title: Get.put(VendorController()).accountList[index].cardName.toString(),
                                                        size: AppSizes.size_15,
                                                        fontFamily: AppFont.medium,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColor.blackColor,
                                                      ),
                                                    ],
                                                  ),
                                                  // GestureDetector(
                                                  //   onTap: (){
                                                  //     showAlertDialog(
                                                  //         context: context,
                                                  //         text: 'Do you want to delete it ? ',
                                                  //         yesOnTap: () {
                                                  //           Get.back();
                                                  //           showLoading(context: context);
                                                  //           ApiManger().deleteCal(id:Get.put(VendorController()).accountList[index].id.toString() );
                                                  //         });
                                                  //   },
                                                  //   child: Icon(Icons.delete_forever_rounded,color: Colors.red,
                                                  //     size: AppSizes.size_25,
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                              SizedBox(height: Get.height*0.01,),
                                              Row(
                                                children: [
                                                  AppText(
                                                    title:ibanNumber.tr,
                                                    size: AppSizes.size_15,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.blackColor,
                                                  ),

                                                  AppText(
                                                    title: Get.put(VendorController()).accountList[index].ibnNo.toString(),
                                                    size: AppSizes.size_15,
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
                                                    title: accountNumber.tr,
                                                    size: AppSizes.size_15,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.blackColor,
                                                  ),

                                                  AppText(
                                                    title: Get.put(VendorController()).accountList[index].accountNo.toString(),
                                                    size: AppSizes.size_15,
                                                    fontFamily: AppFont.medium,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.blackColor,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: Get.height*0.01,),


                                            ],
                                          ),
                                        ),
                                      );
                                    }):noData(height: Get.height*0.35);
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
          Positioned(
              top: Get.height*0.055,
              right: 10,
              child:  GestureDetector(
                onTap: (){
                  Get.to(VendorAddAccounts());
                },
                child: Container(
                  height: Get.height * 0.035,
                  width: Get.height * 0.035,
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
              ))
        ],
      ),
    );
  }
}