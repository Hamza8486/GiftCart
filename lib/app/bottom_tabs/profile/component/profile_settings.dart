import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/login.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/account_list.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/edit_profile.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/store_list.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/helper_function.dart';

class NewProfileSettings extends StatelessWidget {
  const NewProfileSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: Get.width,
                height: Get.height * 0.28,
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor.primaryColor1,
                      AppColor.primaryColor,


                    ],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                "assets/images/remove.svg",
                                height: Get.height * 0.03,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          AppText(
                            title: "Profile",
                            size: AppSizes.size_21,
                            fontFamily: AppFont.semi,
                            fontWeight: FontWeight.w500,
                            color: AppColor.whiteColor,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(EditProfile());
                            },
                            child: SvgPicture.asset(
                              "assets/images/edit.svg",
                              height: Get.height * 0.024,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.2,
                        ),
                        profileWidget(
                            text: "Notification",
                            image: "assets/icons/noti.svg",
                            child: toggleButton(),
                            onTap: () {}),
                        SizedBox(
                          height: Get.height * 0.034,
                        ),
                        profileWidget(
                            text: "FaceId/FingerPrint Lock",
                            image: "assets/icons/face.svg",
                            child: toggleButton1(),
                            onTap: () {}),
                        SizedBox(
                          height: Get.height * 0.034,
                        ),
                        profileWidget(
                            text: "Switch Theme",
                            image: "assets/icons/theme.svg",
                            child: toggleButton2(),
                            onTap: () {}),
                        SizedBox(
                          height: Get.height * 0.034,
                        ),
                        profileWidget(
                            text: "Saved Bank Accounts",
                            image: "assets/icons/card.svg",
                            child: SizedBox.shrink(),
                            onTap: () {
                              Get.to(SaveBanks(),
                                  transition: Transition.rightToLeft);
                            }),
                        SizedBox(
                          height: Get.height * 0.034,
                        ),
                        profileWidget(
                            text: partners.tr,
                            image: "assets/icons/banks.svg",
                            child: SizedBox.shrink(),
                            onTap: () {
                              Get.to(StoreList(),
                                  transition: Transition.rightToLeft);
                            }),
                        SizedBox(
                          height: Get.height * 0.034,
                        ),
                        profileWidget(
                            text: "Security",
                            image: "assets/icons/security.svg",
                            child: SizedBox.shrink(),
                            onTap: () {
                              Get.to(SaveBanks(),
                                  transition: Transition.rightToLeft);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: GestureDetector(
                  onTap: () {
                    showExit(
                        context: context,
                        onTap: () async {
                          await  Get.delete<HomeController>();

                          await  HelperFunctions().clearPrefs();
                          Get.offAll(LoginView());



                        });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: Get.width,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColor.primaryColor, width: 1.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: Get.height * 0.018),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/logOut.svg",
                            color: AppColor.primaryColor,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          AppText(
                            title: "Log Out",
                            size: AppSizes.size_14,
                            fontFamily: AppFont.bold,
                            color: AppColor.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
            ],
          ),
          Positioned(
              left: Get.width * 0.065,
              right: Get.width * 0.065,
              top: Get.height * 0.21,
              child: SizedBox(
                width: Get.width,
                height: Get.height * 0.23,
                child: Material(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.07,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.03),
                        child: Obx(() {
                          return AppText(
                            title: Get.put(HomeController()).name.value,
                            size: AppSizes.size_18,
                            fontFamily:
                                Get.put(HomeController()).name.value.isNotEmpty
                                    ? AppFont.medium
                                    : AppFont.medium,
                            fontWeight: FontWeight.w600,
                            color: AppColor.boldBlackColor,
                          );
                        }),
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.015,
                                ),

                                Obx(
                                        () {
                                      return AppText(
                                        title: "\$${Get.put(HomeController()).totalEarning.value.toString()} ",
                                        size: AppSizes.size_17,
                                        fontFamily: AppFont.medium,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.boldBlackColor,


                                      );
                                    }
                                ),

                                SizedBox(
                                  height: Get.height * 0.005,
                                ),
                                AppText(
                                  title: "Total Earn",
                                  size: AppSizes.size_14,
                                  fontFamily: AppFont.regular,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      AppColor.boldBlackColor.withOpacity(0.7),
                                ),
                              ],
                            ),
                            Container(
                              height: Get.height * 0.07,
                              width: Get.width * 0.002,
                              color: Colors.grey.withOpacity(0.6),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.015,
                                ),
                                AppText(
                                  title: "3",
                                  size: AppSizes.size_17,
                                  fontFamily: AppFont.medium,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.boldBlackColor,
                                ),
                                AppText(
                                  title: "Days",
                                  size: AppSizes.size_14,
                                  fontFamily: AppFont.regular,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      AppColor.boldBlackColor.withOpacity(0.7),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Positioned(
            top: Get.height * 0.14,
            left: Get.width * 0.38,
            child: Obx(() {
              return Container(
                  height: Get.put(HomeController()).name.value.isNotEmpty
                      ? Get.height * 0.125
                      : Get.height * 0.125,
                  width: Get.height * 0.125,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.primaryColor, width: 3),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Center(
                          child: SpinKitThreeBounce(
                              size: 16, color: AppColor.primaryColor)),
                      imageUrl: Get.put(HomeController()).image.value,
                      fit: Get.put(HomeController()).image.value.isEmpty
                          ? BoxFit.cover
                          : BoxFit.cover,
                      errorWidget: (context, url, error) => ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/images/persons.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ));
            }),
          )
        ],
      ),
    );
  }
}
