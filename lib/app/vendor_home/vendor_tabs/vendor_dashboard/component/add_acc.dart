import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';

import '../../../../../util/translation_keys.dart';


class VendorAddAccounts extends StatefulWidget {
  const VendorAddAccounts({Key? key}) : super(key: key);

  @override
  State<VendorAddAccounts> createState() => _VendorAddAccountsState();
}

class _VendorAddAccountsState extends State<VendorAddAccounts> {

  var name = TextEditingController();
  var iban = TextEditingController();
  var number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Stack(
      children: [
        Scaffold(

          body: Stack(
            children: [
              Column(
                children: [
                  TopBar(onTap1: (){},onTap: (){
                    Get.back();
                  },text: addBankAccounts.tr,
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
                            Image.asset("assets/images/card.png"),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            textAuth(text: cardHolderName.tr),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            betField(
                              hint: cardHolderName.tr,
                              controller: name,
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            textAuth(text:ibanNumber_.tr),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            betField(
                                hint: ibanNumber_.tr,
                                controller: iban,
                                textInputType: TextInputType.phone
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            textAuth(text:accountNumber.tr),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            betField(
                                hint: accountNumber.tr,
                                controller: number,
                                textInputType: TextInputType.phone,
                                textInputAction: TextInputAction.done
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  isKeyBoard?SizedBox.shrink():
                  Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.005,
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                        child: AppButton(
                            buttonWidth: Get.width,
                            buttonRadius: BorderRadius.circular(10),
                            buttonName: add.tr,


                            fontWeight: FontWeight.w500,
                            textSize: AppSizes.size_14,
                            fontFamily: AppFont.medium,
                            buttonColor: AppColor.primaryColor,
                            textColor: AppColor.whiteColor,
                            onTap: () {
                              if(validateAccount(context)){
                                Get.put(VendorController()).updateBankLoader(true);
                                ApiManger().addBank(card: name.text,
                                    iban: iban.text,
                                    account: number.text
                                );
                              }
                            }),
                      ),

                      SizedBox(
                        height: Get.height * 0.012,
                      ),

                    ],
                  )
                ],
              ),
              Positioned(
                  top: Get.height*0.057,
                  right: 10,
                  child:  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      height: Get.height * 0.045,
                      width: Get.height * 0.045,
                      decoration: BoxDecoration(
                          color: AppColor.transParent,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Get.height * 0.1))),
                      child: Icon(
                        Icons.add,
                        color: AppColor.transParent,
                        size: AppSizes.size_20,
                      ),
                    ),
                  ))
            ],
          ),
        ),
        Obx(() {
          return Get.put(VendorController()).adBankLoader.value == false
              ? SizedBox.shrink()
              : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black26,
            child:  Center(
                child: SpinKitThreeBounce(
                    size: 25, color: AppColor.blackColor)
            ),
          );



        })
      ],
    );
  }
  bool validateAccount(BuildContext context) {


    if (name.text.isEmpty) {
      flutterToast(msg: pleaseEnterCardHolderName.tr);
      return false;
    }
    if (iban.text.isEmpty) {
      flutterToast(msg:pleaseEnterIbanNum.tr);
      return false;
    }
    if (number.text.isEmpty) {
      flutterToast(msg: pleaseEnterAccNum.tr);
      return false;
    }






    return true;
  }
}