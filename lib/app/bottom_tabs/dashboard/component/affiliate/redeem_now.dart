import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_bet/util/translation_keys.dart';

import '../../../../../util/theme.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../auth/component.dart';

class RedeemNowWidget extends StatelessWidget {
  const RedeemNowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return DraggableScrollableSheet(
      initialChildSize: isKeyBoard ? 0.9 : 0.6,
      minChildSize: isKeyBoard ? 0.9 : 0.6,
      maxChildSize: isKeyBoard ? 0.9 : 0.6,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/slide.png",
                    scale: 3,
                  )
                ],
              ),
              SizedBox(height: 38),
              AppText(
                  title: redeem.tr,
                  size: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackColor),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 38,
                    ),
                    textAuth(text: amount.tr, color: Colors.transparent),
                    SizedBox(height: Get.height * 0.013),
                    betField(
                        hint: typeAmountHere.tr,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.phone),
                    SizedBox(height: 20),
                    Container(
                      height: 88,
                      decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          border: Border.all(
                              color: AppColor.greyLightColor2.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/bank.png",
                              height: 64,
                              width: 64,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                    title: "**** **** 3434",
                                    size: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.blackColor),
                                SizedBox(height: 6),
                                AppText(
                                    title: royalBankOfCanada.tr,
                                    size: 10,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.greyLightColor2),
                              ],
                            )),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/edits.png",
                                  height: 18,
                                  width: 18,
                                ),
                                SizedBox(width: 25),
                                Image.asset(
                                  "assets/images/delete.png",
                                  height: 18,
                                  width: 18,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              AppButton(
                  buttonWidth: Get.width,
                  buttonRadius: BorderRadius.circular(10),
                  buttonName: redeemNow.tr,
                  gard: true,
                  fontWeight: FontWeight.w600,
                  textSize: 16,
                  buttonColor: AppColor.primaryColor,
                  textColor: AppColor.whiteColor,
                  onTap: () {
                    Get.back();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
