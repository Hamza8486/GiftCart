import 'dart:io';

import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/auth/component.dart';
import 'package:giftcart/app/bottom_tabs/component/component.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/all_data.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';
import 'package:giftcart/services/api_manager.dart';
import 'package:giftcart/util/constant.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/util/toast.dart';
import 'package:giftcart/util/translation_keys.dart';
import 'package:giftcart/widgets/app_button.dart';
import 'package:giftcart/widgets/app_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class EarnRefrence extends StatefulWidget {
  const EarnRefrence({Key? key}) : super(key: key);

  @override
  State<EarnRefrence> createState() => _EarnRefrenceState();
}

class _EarnRefrenceState extends State<EarnRefrence> {
  late List<Contact> contacts = [];
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchContacts();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // When user reaches the end of the list, load more contacts
      fetchContacts();
    }
  }

  Future<void> fetchContacts() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      List<Contact> fetchedContacts = await getContacts();
      setState(() {
        contacts.addAll(fetchedContacts);
        isLoading = false;
      });
    }
  }

  _textMe(String phone) async {
    if (Platform.isAndroid) {
      var uri = "sms:+" +
          phone +
          "?body=Here%20is%20referal%20code" +
          Get.put(HomeController()).referCode.value.toString().toString();
      await launch(uri);
    } else if (Platform.isIOS) {
      // iOS
      const uri = 'sms:0039-222-060-888&body=hello%20there';
      await launch(uri);
    }
  }

  whatsapp(String phone, String message) async {
    var contact = "" + phone;
    var androidUrl = "whatsapp://send?phone=$contact&text=" + message;
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse(message)}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      flutterToast(msg: "Whatsapp not installed");
    }
  }
  openWhatsapp() async {
    await launchUrl(
      Uri.parse(
        AppConstants.wa_url(),
      ),
    );
  }

  // Future<void> share() async {
  //   await WhatsappShare.share(
  //     text: heyFriendsCheckAppText.tr +
  //         "\n# ${Get.put(HomeController()).referCode.value.toString()}    Use this",
  //     linkUrl: 'https://flutter.dev/',
  //     phone: '911234567890',
  //   );
  // }

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
                    controller: _scrollController,
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
                                          "\$${Get.put(HomeController()).totalEarning.value.toString()} ",
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
                              onTap: Get.put(HomeController())
                                  .referCode
                                  .value
                                  .isEmpty
                                  ? () {
                                flutterToastSuccess(msg: copied.tr);
                                Clipboard.setData(ClipboardData(
                                    text: Get.put(HomeController())
                                        .referCode
                                        .value
                                        .toString()));
                              }
                                  : () {
                                flutterToastSuccess(msg: copied.tr);
                                Clipboard.setData(ClipboardData(
                                    text: Get.put(HomeController())
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
                                        title: Get.put(HomeController())
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
                            title: copyOrShareRefCodeWithFriends.tr,
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
                              openWhatsapp();
                            },
                            child: Image.asset(
                              "assets/icons/whats.png",
                              height: Get.height * 0.05,
                            ),
                          ),
                        ),
                        Obx(() {
                          return Get.put(HomeController()).refCodeHave.value
                              ? SizedBox.shrink()
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Get.height * 0.035,
                              ),
                              textAuth(
                                text: referralCode.tr,
                                color: Colors.transparent,
                              ),
                              SizedBox(
                                height: Get.height * 0.013,
                              ),
                              betField(
                                  hint: pasteCodehere.tr,
                                  textInputAction: TextInputAction.done,
                                  onChange: (val) {
                                    setState(() {});
                                  },
                                  controller: Get.put(HomeController())
                                      .referrelController),
                              SizedBox(
                                height: Get.height * 0.013,
                              ),
                              Obx(() {
                                return Get.put(HomeController())
                                    .applyRef
                                    .value
                                    ? Center(
                                    child: SpinKitThreeBounce(
                                        size: 22,
                                        color: AppColor.primaryColor))
                                    : AppButton(
                                  buttonName: "Apply",
                                  buttonColor:
                                  AppColor.primaryColor,
                                  textColor: AppColor.whiteColor,
                                  onTap: () {
                                    if (Get.put(HomeController())
                                        .referrelController
                                        .text
                                        .isEmpty) {
                                      flutterToast(
                                          msg:
                                          "Please enter referrel code");
                                    } else {
                                      Get.put(HomeController())
                                          .updateApplyRef(true);
                                      ApiManger().useReferrelCode(
                                          context: context,
                                          code: Get.put(
                                              HomeController())
                                              .referrelController
                                              .text);
                                    }
                                  },
                                  buttonRadius:
                                  BorderRadius.circular(10),
                                  buttonWidth: Get.width,
                                  buttonHeight: 50,
                                );
                              })
                            ],
                          );
                        }),
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
                                  title: copyTheRefCodeNShare.tr,
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
                                  title: askYourFriendToRegisterUsingRefCode.tr,
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
                          height: Get.height * 0.04,
                        ),
                        AppText(
                          title: "Refer your Contact",
                          size: 14,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        if (contacts.isEmpty)
                          Center(
                            child: SpinKitThreeBounce(
                              size: 25,
                              color: AppColor.primaryColor,
                            ),
                          )
                        else
                          ListView.builder(
                            itemCount: contacts.length,
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              Contact contact = contacts[index];
                              return
                                contact.phones.first.number.length<6?SizedBox.shrink():
                                Padding(
                                padding: const EdgeInsets.symmetric(vertical: 0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: AppColor.lightBlue,
                                                borderRadius: BorderRadius.circular(100)),
                                            child: Center(
                                              child: AppText(
                                                title:
                                                contact.displayName.isEmpty?"U":
                                                contact.displayName[0],
                                                size: 14,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.whiteColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  contact.displayName.isEmpty ? "Username" : contact.displayName,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: AppColor.blackColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  contact.phones.first.number.toString(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: AppColor.blackColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              InkResponse(
                                                onTap: () {
                                                  whatsapp(contact.phones.first.number, "Hi this is your referral code ${Get.put(HomeController()).referCode.value.toString()} ");


                                                },
                                                child: Image.asset(
                                                  "assets/images/wh.png",
                                                  height: 25,
                                                  width: 25,
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              InkResponse(
                                                onTap: () {
                                                  _textMe(contact.phones.first.number);
                                                },
                                                child: Image.asset(
                                                  "assets/images/mess.png",
                                                  height: 25,
                                                  width: 25,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Divider(
                                      color: AppColor.greyLightColor2.withOpacity(0.5),
                                    ),
                                    SizedBox(height: 6),
                                  ],
                                ),
                              );
                            },
                          ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        if (isLoading)
                          Center(
                            child: CircularProgressIndicator(
                              color: AppColor.primaryColor,
                            ), // Or any loading indicator
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
                  Get.to(AllData(
                    name: "Earn and reference",
                    link: "https://admin.mr-corp.ca/help/Earn%20and%20refrence",
                  ));
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

  Future<List<Contact>> getContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }
    if (isGranted) {
      return await FastContacts.getAllContacts();
    }
    return [];
  }

}
