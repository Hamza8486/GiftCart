import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/comman_widget/refer_contact_item.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/constant.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class EarnRefrence extends StatefulWidget {
  const EarnRefrence({Key? key}) : super(key: key);

  @override
  State<EarnRefrence> createState() => _EarnRefrenceState();
}

class _EarnRefrenceState extends State<EarnRefrence> {
  List<Contact> contacts = [];

  @override
  void initState() {
    fetchContacts();
  }

  Future<void> share() async {
    await WhatsappShare.share(
      text:
      "📢 Hey friends! Check out our amazing MR App - it's mind-blowing! 😎 Sign up using my referral code  and get rewarded with \$1! 💸 Don't miss out on this awesome opportunity, share the love on WhatsApp now.\n# ${Get
          .put(HomeController())
          .referCode
          .value
          .toString()}    Use this",
      linkUrl: 'https://flutter.dev/',
      phone: '911234567890',
    );
  }

  void fetchContacts() async {
    if (await FlutterContacts.requestPermission()) {
      showLoading(context: context);
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      Get.back();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              TopBar(
                  onTap1: () {},
                  onTap: () {
                    Get.back();
                  },
                  text: earnNRef.tr,
                  image: "assets/icons/share.svg",
                  color: AppColor.whiteColor),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  title: referYourFriends.tr,
                                  size: AppSizes.size_12,
                                  fontFamily: AppFont.medium,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.greyColors,
                                ),
                                SizedBox(height: 3),
                                AppText(
                                  title: earn1Each.tr,
                                  size: AppSizes.size_22,
                                  fontFamily: AppFont.semi,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.primaryColor,
                                ),
                              ],
                            ),
                            SvgPicture.asset("assets/icons/coin.svg"),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.primaryColor)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      AppText(
                                        title: totalReward.tr,
                                        size: AppSizes.size_13,
                                        color: AppColor.boldBlackColor,
                                        fontFamily: AppFont.medium,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.05,
                                      ),
                                      Obx(() {
                                        return AppText(
                                          title:
                                          "\$${Get
                                              .put(HomeController())
                                              .totalEarning
                                              .value
                                              .toString()} ",
                                          size: AppSizes.size_24,
                                          color: AppColor.boldBlackColor,
                                          fontFamily: AppFont.medium,
                                        );
                                      }),
                                    ],
                                  ),
                                  Container()
                                ],
                              )),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Center(
                          child: AppText(
                            title: referralCode.tr,
                            size: AppSizes.size_13,
                            fontFamily: AppFont.medium,
                            fontWeight: FontWeight.w500,
                            color: AppColor.blackColor,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Center(
                          child: Obx(() {
                            return GestureDetector(
                              onTap: Get
                                  .put(HomeController())
                                  .referCode
                                  .value
                                  .isEmpty
                                  ? () {
                                flutterToastSuccess(msg: copied.tr);
                                Clipboard.setData(ClipboardData(
                                    text: Get
                                        .put(HomeController())
                                        .referCode
                                        .value
                                        .toString()));
                              }
                                  : () {
                                flutterToastSuccess(msg: copied.tr);
                                Clipboard.setData(ClipboardData(
                                    text: Get
                                        .put(HomeController())
                                        .referCode
                                        .value
                                        .toString()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10),
                                    child: Obx(() {
                                      return AppText(
                                        title: Get
                                            .put(HomeController())
                                            .referCode
                                            .value
                                            .toString(),
                                        size: AppSizes.size_17,
                                        color: AppColor.greyColors,
                                        fontFamily: AppFont.semi,
                                      );
                                    })),
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Center(
                          child: AppText(
                            title:
                            copyOrShareRefCodeWithFriends.tr,
                            size: AppSizes.size_10,
                            fontFamily: AppFont.medium,
                            fontWeight: FontWeight.w500,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              share();
                            },
                            child: Image.asset(
                              "assets/icons/whats.png",
                              height: Get.height * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.035,
                        ),
                        textAuth(
                            text: referralCode.tr, color: Colors.transparent),
                        SizedBox(
                          height: Get.height * 0.013,
                        ),
                        betField(
                          hint: pasteCodehere.tr,
                        ),
                        SizedBox(
                          height: Get.height * 0.035,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.04),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/hand.svg"),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              AppText(
                                title: howToReferAFriend.tr,
                                size: AppSizes.size_13,
                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w500,
                                color: AppColor.primaryColor,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.04),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                  AppColor.primaryColor.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      "assets/icons/copy.svg",
                                      color: AppColor.grey3Color,
                                    )),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Expanded(
                                child: AppText(
                                  title:
                                  copyTheRefCodeNShare.tr,
                                  size: AppSizes.size_11,
                                  fontFamily: AppFont.medium,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.04),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                  AppColor.primaryColor.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      "assets/icons/line2.svg",
                                      color: AppColor.grey3Color,
                                    )),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Expanded(
                                child: AppText(
                                  title:
                                  askYourFriendToRegisterUsingRefCode.tr,
                                  size: AppSizes.size_11,
                                  fontFamily: AppFont.medium,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: contacts.map((strone) {
                              return ReferContactItem(
                                  strone, AppConstants.referrlCode.toString());
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
              top: Get.height * 0.058,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context,
                      builder: (context) => earnWidget());
                },
                child: Image.asset(
                  "assets/icons/info.png",
                  height: 25,
                  width: 25,
                ),
              )),
        ],
      ),
    );
  }
}

Widget earnWidget() {
  return DraggableScrollableSheet(
    initialChildSize: 0.7,
    minChildSize: 0.7,
    maxChildSize: 0.7,
    builder: (_, controller) =>
        Container(
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
                SizedBox(
                  height: Get.height * 0.03,
                ),
                AppText(
                    title: infoAboutEarnings.tr,
                    size: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColor.blackColor),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              AppText(
                                  title: "${index + 1} - ",
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackColor),
                              AppText(
                                  title: clearExpDateForeachCoupon.tr,
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
  );
}
