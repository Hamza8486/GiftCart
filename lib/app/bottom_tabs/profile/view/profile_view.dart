import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/app/auth/login.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/about.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/account_list.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/edit_profile.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/faq_view.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/notification_view.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/privacy_policy.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/store_list.dart';

import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/bottom_sheet.dart';
import 'package:mr_bet/widgets/helper_function.dart';

import '../../../home/controller/home_controller.dart';
import '../component/game_mannual.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: Get.height*0.06,),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(


                  children: [

                        GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: Image.asset("assets/icons/backs.png",
                              height: 30,
                              width: 30,
                            )),
                    SizedBox(width: Get.width*0.04,),
                     AppText(
                      title: profileSetting.tr,
                      size: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primaryColor,
                    ),


                  ],
                ),
                Container()
              ],
            ),
          ),

          SizedBox(height: Get.height*0.015,),
          Column(
            children: [
              Container(
                height: 125,
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  gradient:  LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [

                      Color(0xffFB6D72),
                      Color(0xffF33F41),
                    ],
                  ),
                ),
                child:      Obx(() {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Get.put(HomeController()).imageLoader.value
                          ? const Center(
                          child: SpinKitThreeBounce(
                              size: 17, color: AppColor.primaryColor))
                          : GestureDetector(
                        onTap: () {},
                        child: Container(
                            height: 72,
                            width: 72,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColor.primaryColor,
                                  width: Get.put(HomeController())
                                      .name
                                      .value
                                      .isNotEmpty
                                      ? 1
                                      : 1),
                              shape: BoxShape.circle,
                            ),
                            child: Obx(() {
                              return ClipRRect(
                                borderRadius:
                                BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  placeholder: (context, url) =>
                                  const Center(
                                      child: SpinKitThreeBounce(
                                          size: 16,
                                          color: AppColor
                                              .primaryColor)),
                                  imageUrl:
                                  Get.put(HomeController())
                                      .image
                                      .value,
                                  fit: Get.put(HomeController())
                                      .image
                                      .value
                                      .isEmpty
                                      ? BoxFit.cover
                                      : BoxFit.cover,
                                  errorWidget:
                                      (context, url, error) =>
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        child: Image.asset(
                                          "assets/images/persons.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                ),
                              );
                            })),
                      ),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            title: Get.put(HomeController()).name.value,
                            size: 16,

                            fontWeight: FontWeight.w600,
                            color: AppColor.whiteColor,
                          ),
                          SizedBox(height: 2,),
                          Row(
                            children: [
                              Image.asset("assets/icons/sms.png",
                              height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 10,),
                              AppText(
                                title:
                                Get.put(HomeController()).email.value,
                                size: 12,

                                fontWeight: FontWeight.w400,
                                color: AppColor.whiteColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Image.asset("assets/icons/call.png",
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 10,),
                              AppText(
                                title:
                                Get.put(HomeController()).phone.value,
                                size: 12,

                                fontWeight: FontWeight.w400,
                                color: AppColor.whiteColor,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  );
                }),
              ),


            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    profileWidget(
                        text: accountSettings.tr,
                        image: "assets/icons/profile.svg",

                        onTap: () {
                          Get.to(EditProfile());
                        }),
                    SizedBox(
                      height: Get.height * 0.034,
                    ),
                    profileWidget(
                        text: notifications.tr,
                        image: "assets/icons/noti.svg",

                        onTap: () {
                          Get.put(HomeController()).getNotiHis();
                          Get.to(NotificationView());
                        }),
                    SizedBox(
                      height: Get.height * 0.034,
                    ),
                    profileWidget(
                        text: faceFinger.tr,
                        image: "assets/icons/face.svg",
                        child: toggleButton1(),
                        onTap: () {}),
                    SizedBox(
                      height: Get.height * 0.034,
                    ),
                    profileWidget(
                        text: switchTheme.tr,
                        image: "assets/icons/theme.svg",
                        child: toggleButton2(),
                        onTap: () {}),
                    SizedBox(
                      height: Get.height * 0.034,
                    ),
                    profileWidget(
                        text: updateBankAcc.tr,
                        image: "assets/icons/banks.svg",
                        child: const SizedBox.shrink(),
                        onTap: () {
                          Get.to(const SaveBanks(),
                              transition: Transition.rightToLeft);
                        }),
                    SizedBox(
                      height: Get.height * 0.034,

                    ),
                    profileWidget(
                        text: privacyPolicy.tr,
                        image: "assets/icons/security.svg",
                        child:  SizedBox.shrink(),
                        onTap: () {
                          Get.to( PrivacyPolicy(),
                              transition: Transition.rightToLeft);
                        }),
                    SizedBox(
                      height: Get.height * 0.034,

                    ),
                    profileWidget(
                        text: aboutUs.tr,
                        image: "assets/icons/security.svg",
                        child: const SizedBox.shrink(),
                        onTap: () {
                          Get.to( AboutUs(),
                              transition: Transition.rightToLeft);
                        }),
                  ],
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
          //   child: GestureDetector(
          //     onTap: () {
          //       showExit(
          //           context: context,
          //           onTap: () async {
          //             ApiManger().logoutApi();
          //             await Get.delete<HomeController>();
          //
          //             await HelperFunctions().clearPrefs();
          //             Get.offAll(LoginView());
          //           });
          //     },
          //     child: Container(
          //       margin: const EdgeInsets.symmetric(horizontal: 10),
          //       width: Get.width,
          //       decoration: BoxDecoration(
          //         border:
          //             Border.all(color: AppColor.primaryColor, width: 1.7),
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: Padding(
          //         padding: EdgeInsets.symmetric(
          //             horizontal: 12, vertical: Get.height * 0.015),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             SvgPicture.asset(
          //               "assets/images/logOut.svg",
          //               color: AppColor.primaryColor,
          //             ),
          //             SizedBox(
          //               width: Get.width * 0.03,
          //             ),
          //             const AppText(
          //               title: "Log Out",
          //               size: 15,
          //               fontWeight: FontWeight.w600,
          //               color: AppColor.primaryColor,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
