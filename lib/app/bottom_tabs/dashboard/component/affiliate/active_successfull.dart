import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../util/theme.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/app_text.dart';
import '../affliate_main.dart';

class ActiveAffiliateSuccessfulDialog extends StatelessWidget {
  const ActiveAffiliateSuccessfulDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.4,
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: Get.height * 0.07),
              Center(
                child: Image.asset(
                  "assets/images/yes.png",
                  height: 38,
                  width: 38,
                ),
              ),
              SizedBox(height: Get.height * 0.015),
              Center(
                child: AppText(
                    title: "Activation successful",
                    size: 19,
                    fontWeight: FontWeight.w600,
                    color: AppColor.blackColor),
              ),
              SizedBox(height: Get.height * 0.005),
              Center(
                child: AppText(
                    title: "Your affiliate account is active now",
                    size: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColor.greyLightColor2),
              ),
              Spacer(),
              AppButton(
                buttonName: "Go to affiliate info",
                buttonColor: AppColor.primaryColor,
                textColor: AppColor.whiteColor,
                onTap: () {
                  Get.to(AffiliateViewMain(
                    isShowActivateNow: false,
                  ));
                },
                buttonWidth: Get.width,
                buttonRadius: BorderRadius.circular(10),
                gard: true,
              ),
              SizedBox(height: Get.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
