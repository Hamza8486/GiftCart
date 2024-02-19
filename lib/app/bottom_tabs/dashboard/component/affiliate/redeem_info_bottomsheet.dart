import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../util/translation_keys.dart';
import '../../../../../util/theme.dart';
import '../../../../../widgets/app_text.dart';

class RedeemInfoBottomSheet extends StatelessWidget {
  const RedeemInfoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return
      DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.92,
      maxChildSize: 0.92,
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
              SizedBox(height: Get.height * 0.03),
               AppText(
                  title: howDoesItWork.tr,
                  size: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackColor),
              SizedBox(height: Get.height * 0.025),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/rewardInfoo.png",
                        width: 242,
                        height: 394,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    AppText(
                        title:
                        oneReferYourFriend.tr,
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                    SizedBox(height: Get.height * 0.015),
                    AppText(
                        title:
                        twoAfter100Users.tr,
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                    SizedBox(height: Get.height * 0.015),
                    AppText(
                        title:
                        threeYouCanEarn.tr,
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                    SizedBox(height: Get.height * 0.015),
                    AppText(
                        title:fourNoInviteLimit.tr,
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                    SizedBox(height: Get.height * 0.015),
                    AppText(
                        title: fiveEasyWithdrawals.tr,
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
