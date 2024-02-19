import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';

class PendingView extends StatelessWidget {
  const PendingView({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.04),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.06,
            ),
            Row(
              children: [
                backButton(

                    onTap: () {
                      Get.back();
                    }),
                SizedBox(
                  width: Get.width * 0.16,
                ),
                AppText(
                  title: "Pending Payments",
                  color: AppColor.blackColor,
                  size: AppSizes.size_18,
                  fontFamily: AppFont.semi,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: () {

                          },
                          child: Row(

                            children: [

                              Container(
                                height:Get.height*0.06,
                                width: Get.height*0.06,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.yellowColor.withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset("assets/images/Icon.png")),
                                ),
                              ),
                              SizedBox(width: Get.width*0.01,),

                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.017),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            title:

                                            "TXN123456",

                                            fontFamily: AppFont.medium,
                                            fontWeight: FontWeight.w500,
                                            size: AppSizes.size_13,
                                            color: AppColor.blackColor,
                                          ),
                                          SizedBox(height: Get.height*0.001,),
                                          AppText(
                                            title: "Aug 10, 2023",
                                            maxLines: 1,
                                            overFlow: TextOverflow.ellipsis,

                                            fontFamily: AppFont.regular,
                                            fontWeight: FontWeight.w500,
                                            size: AppSizes.size_13,
                                            color: AppColor.greyColor,
                                          ),



                                        ],
                                      ),
                                      AppText(
                                        title:

                                        "\$150.00",

                                        fontFamily: AppFont.semi,
                                        fontWeight: FontWeight.w600,
                                        size: AppSizes.size_15,
                                        color: AppColor.yellowColor,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),


              ],)),

          ],
        ),
      ),
    );
  }
}
