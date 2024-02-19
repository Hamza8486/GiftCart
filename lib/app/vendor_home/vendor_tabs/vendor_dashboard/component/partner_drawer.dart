import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/login.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/component/promote_business.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/earn_refrence.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/faq_view.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/help.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/store_list.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/profile/vendor_profile.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/component/add_Ads_business.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/component/orders.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/component/refer_vendor.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/helper_function.dart';

class PartnerDrawer extends StatelessWidget {
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
              padding:  EdgeInsets.only(left: 15,top: 20),
              child: Obx(
                () {
                  return
                    Get.put(VendorController()).loaderProfile.value? Center(
                        child: SpinKitThreeBounce(
                            size: 16, color: AppColor.whiteColor)):

                    Row(
                    children: [
                      Container(
                          height:
                          Get.put(VendorController()).name.value.isNotEmpty
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
                                    imageUrl:(Get.put(VendorController()).profileAllData?.data?.logo).toString(),
                                    fit: Get.put(VendorController()).name.value.isEmpty
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
                      SizedBox(width: Get.width*0.025,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 35,),
                          Obx(
                                  () {
                                return AppText(
                                  title:(Get.put(VendorController()).profileAllData?.data?.fullName).toString(),
                                  size:
                                  Get.put(VendorController()).name.value.isEmpty?16:16,

                                  fontWeight: FontWeight.w600,
                                  color: AppColor.whiteColor,
                                );
                              }
                          ),
                          Obx(
                                  () {
                                return AppText(
                                  title: (Get.put(VendorController()).profileAllData?.data?.email).toString(),
                                  size:
                                  Get.put(VendorController()).email.value.isEmpty?11:11,

                                  fontWeight: FontWeight.w400,
                                  color: AppColor.whiteColor,
                                );
                              }
                          ),
                          SizedBox(height: 3,),
                          Obx(
                                  () {
                                return AppText(
                                  title:(Get.put(VendorController()).profileAllData?.data?.store?.contact).toString(),
                                  size:
                                  Get.put(VendorController()).email.value.isEmpty?11:11,

                                  fontWeight: FontWeight.w400,
                                  color: AppColor.whiteColor,
                                );
                              }
                          ),
                        ],
                      )
                    ],
                  );
                }
              ),
            ),
          ),

          Container(
            width: 303,
            height: Get.height*0.85,
            color: AppColor.whiteColor,
            child: Padding(
              padding: EdgeInsets.only(left: Get.width * 0.05,right: Get.width*0.05),
              child: Column(
                children: [
                  SizedBox(height: 25,),
                  GestureDetector(
                    onTap: () {
                      Get.to(VendorProfile(),
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
                                color: AppColor.primaryColor,
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              AppText(
                                title: profileSetting.tr,
                                size: 15,
                                fontWeight: FontWeight.w500,
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
                  GestureDetector(
                    onTap: () {
                      Get.put(VendorController()).getPayHisData();
                     Get.to(OrdersView());
                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/frame5.svg",
                            height: Get.height * 0.025,
                            color: AppColor.primaryColor,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          AppText(
                            title: orders.tr,
                            size: 15,
                            fontWeight: FontWeight.w500,
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
                      Get.to(StoreList(type: "part",),
                          transition: Transition.rightToLeft
                      );
                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/frame6.svg",
                            height: Get.height * 0.025,
                            color: AppColor.primaryColor,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          AppText(
                            title: partners.tr,
                            size: 15,
                            fontWeight: FontWeight.w500,
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
                      Get.to(const EarnRefrenceVendor(),
                          transition: Transition.rightToLeft);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/frame4.svg",
                            height: Get.height * 0.025,
                            color: AppColor.primaryColor,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          AppText(
                            title: referAndEarnRewards.tr,
                            size: 15,
                            fontWeight: FontWeight.w500,
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
                      Get.to(PromoteBusinessAdsNew(),
                          transition: Transition.rightToLeft
                      );
                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/frame7.svg",
                            height: Get.height * 0.025,
                            color: AppColor.primaryColor,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          AppText(
                            title:promoteYourBusiness.tr,
                            size: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColor.boldBlackColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey.withOpacity(0.6),),
                  SizedBox(height: 10,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      GestureDetector(
                        onTap: () {

                          Get.to(FaqView(),
                              transition: Transition.rightToLeft);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/frame8.svg",
                                height: Get.height * 0.028,
                                color: AppColor.primaryColor,
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              AppText(
                                title: faqs.tr,
                                size: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColor.boldBlackColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey.withOpacity(0.6),),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      Get.to(HelpCenter(),
                          transition: Transition.rightToLeft
                      );
                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/frame9.svg",
                            height: Get.height * 0.028,
                            color: AppColor.primaryColor,
                          ),
                          SizedBox(
                            width: Get.width * 0.027,
                          ),
                          AppText(
                            title: helpAndSupport.tr,
                            size: 15,
                            fontWeight: FontWeight.w500,
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
                      showExit(
                          context: context,
                          onTap: () async {

                            await  Get.delete<VendorController>();
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
                            color: AppColor.primaryColor,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          AppText(
                            title: logout.tr,

                            size: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColor.boldBlackColor,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: Get.height * 0.02,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
