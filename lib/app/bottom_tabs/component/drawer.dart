import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/auth/login.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/component/affliate_main.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/component/promote_business.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/component/transaction.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/component/wallet.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/all_data.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/claim_view.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/earn_refrence.dart';

import 'package:giftcart/app/bottom_tabs/profile/component/help.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/store_list.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/tap_pay.dart';
import 'package:giftcart/app/bottom_tabs/profile/view/profile_view.dart';
import 'package:giftcart/app/coupon_app_rewards/view/coupon_app_rewards.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';
import 'package:giftcart/services/api_manager.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/util/toast.dart';
import 'package:giftcart/widgets/app_text.dart';
import 'package:giftcart/widgets/helper_function.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../util/translation_keys.dart';

class CustomDrawer extends StatelessWidget {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          Container(
            width: 303,
            height: 153,
            decoration: BoxDecoration(
              gradient:  LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [

                  Color(0xffFB6D72),
                  Color(0xffF33F41),
                ],
              ),
              borderRadius: BorderRadius.only(topRight: Radius.circular(50))
            ),
            child: Padding(
              padding:  EdgeInsets.only(left: 10,top: 20),
              child: Row(
                children: [
                  Container(
                      height:
                      Get.put(HomeController()).name.value.isNotEmpty
                          ? 72
                          : 72,
                      width: 72,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.whiteColor,width: 3),
                        shape: BoxShape.circle,
                      ),
                      child:
                      Obx(
                              () {
                            return ClipRRect(
                              borderRadius:


                              BorderRadius.circular(

                                  100),
                              child: CachedNetworkImage(
                                placeholder: (context, url) =>Center(
                                    child: SpinKitThreeBounce(
                                        size: 16, color: AppColor.primaryColor)
                                ),
                                imageUrl:Get.put(HomeController()).image.value,
                                fit: Get.put(HomeController()).image.value.isEmpty
                                    ? BoxFit.cover
                                    : BoxFit.cover,
                                errorWidget: (context, url, error) => ClipRRect(
                                  borderRadius:


                                  BorderRadius.circular(100),
                                  child: Image.asset(
                                    "assets/images/persons.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }
                      )





                  ),
                  SizedBox(width: Get.width*0.018,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 35,),
                      Obx(
                              () {
                            return AppText(
                              title: Get.put(HomeController()).name.value,
                              size:
                              Get.put(HomeController()).name.value.isEmpty?16:16,

                              fontWeight: FontWeight.w600,
                              color: AppColor.whiteColor,
                            );
                          }
                      ),
                      Obx(
                              () {
                            return AppText(
                              title: Get.put(HomeController()).email.value,
                              size:
                              Get.put(HomeController()).email.value.isEmpty?11:11,

                              fontWeight: FontWeight.w400,
                              color: AppColor.whiteColor,
                            );
                          }
                      ),
                      Obx(
                              () {
                            return AppText(
                              title: Get.put(HomeController()).phone.value,
                              size:
                              Get.put(HomeController()).email.value.isEmpty?11:11,

                              fontWeight: FontWeight.w400,
                              color: AppColor.whiteColor,
                            );
                          }
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          Container(
            width: 303,

            color: AppColor.whiteColor,
            child: Padding(
              padding: EdgeInsets.only(left: Get.width * 0.05,right: Get.width*0.05),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  GestureDetector(
                    onTap: () {
                      Get.to(ProfileView(),
                          transition: Transition.rightToLeft
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/frame.svg",
                                height: Get.height * 0.024,
                                color: AppColor.grey3Color,
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              AppText(
                                title: profileSetting.tr,
                                size: 15,
                                fontWeight: FontWeight.w400,
                                color: AppColor.boldBlackColor,
                              ),
                            ],
                          ),
                          SvgPicture.asset("assets/icons/arrow.svg")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey.withOpacity(0.6),),
                  SizedBox(height: 10,),

                  GetBuilder<HomeController>(
                    builder: (controller) {
                      return Column(
                        crossAxisAlignment: controller.slotProfileId.isEmpty
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.start,

                        children: [
                          GestureDetector(
                            onTap: controller.slotProfileId.isEmpty
                                ? () {
                              flutterToast(msg: youDontHaveReward.tr);
                            }
                                : () {
                              Get.to(ClaimView(), transition: Transition.rightToLeft);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/frame1.svg",
                                        height: Get.height * 0.024,
                                        color: AppColor.grey3Color,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.03,
                                      ),
                                      AppText(
                                        title: claim.tr,
                                        size: 15,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.boldBlackColor,
                                      ),


                                    ],
                                  ),
                                  controller.slotProfileId.isEmpty?Container():
                                  Image.asset("assets/images/logo.gif",
                                    height: 55,
                                    width: 55,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),






                  SizedBox(height: 10,),
                  Divider(color: Colors.grey.withOpacity(0.6),),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      Get.to(AllData(name: "User Manual",link: "https://admin.mr-corp.ca/help/User%20Mannual",));
                     // Get.to(GameManual(), transition: Transition.rightToLeft);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/mannual.png",
                          height: Get.height * 0.025,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        AppText(
                          title: userManual.tr,
                          size: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColor.boldBlackColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey.withOpacity(0.6),),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      Get.to(AffiliateViewMain(),
                      transition: Transition.rightToLeft
                      );

                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/frame3.svg",
                            height: Get.height * 0.025,

                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          AppText(
                            title: affiliate.tr,

                            size: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColor.boldBlackColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey.withOpacity(0.6),),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      Get.put(HomeController()).getTransData();
                      Get.put(HomeController()).getProfileData();
                      Get.put(HomeController()).getSlotHis();
                      Get.to(NewWalletView(),
                          transition: Transition.rightToLeft
                      );

                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/frame3.svg",
                            height: Get.height * 0.025,

                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          AppText(
                            title: wallet.tr,

                            size: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColor.boldBlackColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey.withOpacity(0.6),),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      Get.to(const EarnRefrence(),
                          transition: Transition.rightToLeft);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/frame4.svg",
                            height: Get.height * 0.025,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          Expanded(
                            child: AppText(
                              title: referAndEarnRewards.tr,
                              size: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColor.boldBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey.withOpacity(0.6),),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      Get.put(HomeController()).getSlotHis();
                      Get.to(const SlotHistoryData(),
                          transition: Transition.rightToLeft);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/frame5.svg",
                            height: Get.height * 0.025,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          Expanded(
                            child: AppText(
                              title: ordersAndBookings.tr,
                              size: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColor.boldBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey.withOpacity(0.6),),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      Get.to(StoreList(),
                          transition: Transition.rightToLeft
                      );
                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/frame6.svg",
                            height: Get.height * 0.025,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          AppText(
                            title: partners.tr,
                            size: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColor.boldBlackColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey.withOpacity(0.6),),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      Get.put(HomeController()).getInvoiceData();
                      Get.put(HomeController()).updateCoins("");
                      Get.to(RewardView());
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/coin1.png",
                            height: Get.height * 0.025,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          AppText(
                            title: "Reward",
                            size: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColor.boldBlackColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey.withOpacity(0.6),),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      Get.put(HomeController()).getAdsData();
                      Get.to(PromoteBusiness(),
                          transition: Transition.rightToLeft
                      );
                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/frame7.svg",
                            height: Get.height * 0.025,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          AppText(
                            title: promoteYourBusiness.tr,
                            size: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColor.boldBlackColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                Obx(
                  () {
                    return
                      Get.put(HomeController()).rewardEarning.value=="0"?SizedBox.shrink():

                      Column(

                      children: [
                        Divider(color: Colors.grey.withOpacity(0.6),),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: () {
                            Get.to(TapPay(),
                                transition: Transition.rightToLeft
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/frame7.svg",
                                  height: Get.height * 0.025,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                AppText(
                                  title: tapAndPay.tr,
                                  size: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.boldBlackColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    );
                  }
                ),
                  // Divider(color: Colors.grey.withOpacity(0.6),),
                  // SizedBox(height: 10,),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //
                  //     GestureDetector(
                  //       onTap: () {
                  //         Get.to(AllData(name: "FAQ",link: "https://admin.mr-corp.ca/help/Faq",));
                  //         // Get.put(HomeController()).getFaqData();
                  //         // Get.to(FaqView(),
                  //         //     transition: Transition.rightToLeft);
                  //       },
                  //       child: Container(
                  //         color: Colors.transparent,
                  //         child: Row(
                  //           children: [
                  //             SvgPicture.asset(
                  //               "assets/icons/frame8.svg",
                  //               height: Get.height * 0.028,
                  //             ),
                  //             SizedBox(
                  //               width: Get.width * 0.03,
                  //             ),
                  //             AppText(
                  //               title: faqs.tr,
                  //               size: 15,
                  //               fontWeight: FontWeight.w400,
                  //               color: AppColor.boldBlackColor,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10,),
                  // Divider(color: Colors.grey.withOpacity(0.6),),
                  // SizedBox(height: 10,),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.to(HelpCenter(),
                  //         transition: Transition.rightToLeft
                  //     );
                  //   },
                  //   child: Container(
                  //     child: Row(
                  //       children: [
                  //         SvgPicture.asset(
                  //           "assets/icons/frame9.svg",
                  //           height: Get.height * 0.028,
                  //         ),
                  //         SizedBox(
                  //           width: Get.width * 0.027,
                  //         ),
                  //         AppText(
                  //           title: helpAndSupport.tr,
                  //           size: 15,
                  //           fontWeight: FontWeight.w400,
                  //           color: AppColor.boldBlackColor,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  SizedBox(height: 10,),
                  Divider(color: Colors.grey.withOpacity(0.6),),
                  SizedBox(height: 10,),

                  GestureDetector(
                    onTap: () {
                      showExit(
                          context: context,
                          onTap: () async {
                            ApiManger().logoutApi();
                            await  Get.delete<HomeController>();

                            await  HelperFunctions().clearPrefs();
                            Get.offAll(LoginView());



                          });
                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/frame10.svg",
                            height: Get.height * 0.025,
                            color: AppColor.grey3Color,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          AppText(
                            title: logout.tr,

                            size: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColor.boldBlackColor,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap:(){
                          launchTwitter(urlDef: "https://www.facebook.com/mrcorp.ca");
                        },
                        child: Image.asset('assets/icons/facebook.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                      SizedBox(width: 25,),
                      GestureDetector(
                        onTap:(){launchTwitter(urlDef: "https://www.instagram.com/mrcorp.ca/");
                        },
                        child: Image.asset('assets/icons/instagram.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                      SizedBox(width: 25,),
                      GestureDetector(
                        onTap:(){
                          launchTwitter(urlDef: "https://www.instagram.com/mrcorp.ca/");
                        },
                        child: Image.asset('assets/icons/linkedin.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                      SizedBox(width: 25,),
                      GestureDetector(
                        onTap:(){
                          launchTwitter(urlDef: "https://twitter.com/mrcorp_ca");
                        },
                        child: Image.asset('assets/icons/twitter.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.066,
                  ),



                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void launchTwitter({String urlDef=""}) async {
  String url = "$urlDef";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}