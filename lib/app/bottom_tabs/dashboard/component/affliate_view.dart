import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/bottom_tabs/wallet/view/wallet_view.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';

class AffliateView extends StatefulWidget {
  const AffliateView({super.key});

  @override
  State<AffliateView> createState() => _AffliateViewState();
}

class _AffliateViewState extends State<AffliateView> {
  List<String> bannerList = [
    'assets/images/mans.png',
    'assets/images/mans.png',
    'assets/images/mans.png',

    // Add more image paths as needed
  ];
  int _current = 0;

  final CarouselController _controller = CarouselController();
  String wallet = "wallet";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/backs.png',
                height: 280,
                width: Get.width,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 270,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.06,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Image.asset(
                                  "assets/icons/backs.png",
                                  height: 30,
                                  color: Colors.white,
                                  width: 30,
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.04,
                              ),
                              AppText(
                                title: "Affiliate",
                                color: AppColor.whiteColor,
                                size: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) => redeemInfo());
                                },
                                child: Image.asset(
                                  "assets/icons/info.png",
                                  color: Colors.white,
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Obx(() {
                                return Container(
                                  height: 36,
                                  width: Get.put(HomeController())
                                          .name
                                          .value
                                          .isEmpty
                                      ? 36
                                      : 36,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1000),
                                      border: Border.all(
                                          color: AppColor.whiteColor,
                                          width: 1.5)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(1000),
                                      child: CachedNetworkImage(
                                        imageUrl: Get.put(HomeController())
                                            .image
                                            .value,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          child: Image.asset(
                                            "assets/images/person.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                title: "Rewards",
                                size: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.whiteColor.withOpacity(0.9),
                              ),
                              AppText(
                                title: "\$200",
                                size: 28,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Container(
                            height: 74,
                            width: 64,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white.withOpacity(0.3)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  title: "12",
                                  color: AppColor.whiteColor,
                                  size: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                AppText(
                                  title: "Friends\nreferred",
                                  color: AppColor.whiteColor,
                                  size: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  context: context,
                                  builder: (context) => RedeemNow());
                            },
                            child: Container(
                              width: 154,
                              height: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColor.whiteColor),
                              ),
                              child: Center(
                                child: AppText(
                                  title: "Redeem rewards",
                                  color: AppColor.whiteColor,
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          AppText(
                            title: "Transactions",
                            color: AppColor.whiteColor,
                            size: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      CarouselSlider(
                        carouselController: _controller,
                        options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          pageSnapping: false,
                          height: 145,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          pauseAutoPlayInFiniteScroll: false,
                          reverse: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 400),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                        ),
                        items: bannerList
                            .map((item) => GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, left: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.asset(
                                                      "assets/images/logo_man.png",
                                                      width: 31,
                                                      height: 22,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  Text(
                                                    "Special offer",
                                                    style: GoogleFonts.italianno(
                                                        textStyle: TextStyle(
                                                            color: AppColor
                                                                .blackColor,
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColor
                                                            .primaryColor
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 13,
                                                          vertical: 5),
                                                      child: AppText(
                                                        title: "50% Off",
                                                        size: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColor
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  AppText(
                                                    title: onAllOrders.tr,
                                                    size: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColor.blackColor,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 14,
                                              ),
                                              Image.asset(
                                                "assets/images/chat.png",
                                                width: 104,
                                                height: 32,
                                              )
                                            ],
                                          ),
                                        ),
                                        Stack(
                                          children: [
                                            Image.asset(
                                              item.toString(),
                                            ),
                                            Positioned(
                                                top: 12,
                                                right: 12,
                                                child: Image.asset(
                                                  "assets/images/spoo.png",
                                                  width: 92,
                                                  height: 20,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      Positioned(
                          right: 0,
                          left: 0,
                          bottom: 15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: bannerList.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _current == entry.key
                                          ? AppColor.primaryColor
                                          : Colors.white.withOpacity(0.6)),
                                ),
                              );
                            }).toList(),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  textAuth(text: referId.tr),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  betField(
                      hint: "LSUbaske188343666655",
                      isSuffix: true,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/icons/copy.png",
                          scale: 3,
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  AppButton(
                      buttonWidth: Get.width,
                      buttonRadius: BorderRadius.circular(10),
                      buttonName: shareWithFriends.tr,
                      fontWeight: FontWeight.w500,
                      gard: true,
                      buttonColor: AppColor.primaryColor,
                      buttonHeight: Get.height * 0.054,
                      textSize: AppSizes.size_15,
                      borderWidth: 1.1,
                      borderColor: AppColor.primaryColor,
                      textColor: AppColor.whiteColor,
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            isDismissible: true,
                            context: context,
                            builder: (context) => UploadReceiipt());
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        title: "Refer your Contact",
                        color: AppColor.greyLightColor2,
                        size: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      AppText(
                        title: "View all",
                        color: AppColor.whiteColor,
                        size: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 9),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: Get.height * 0.05,
                                      width: Get.height * 0.05,
                                      decoration: BoxDecoration(
                                          color: AppColor.lightBlue,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Center(
                                        child: AppText(
                                          title: "JS",
                                          size: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.04,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          title: "Jack Smith",
                                          size: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.blackColor,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        AppText(
                                          title: "+1 666 443 2323",
                                          size: 12,
                                          fontFamily: AppFont.regular,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.greyLightColor2,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/wh.png",
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Image.asset(
                                      "assets/images/mess.png",
                                      height: 25,
                                      width: 25,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  SizedBox(
                    height: Get.height * 0.06,
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

Widget redeemInfo() {
  return DraggableScrollableSheet(
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
            SizedBox(
              height: Get.height * 0.03,
            ),
            const AppText(
                title: "How does it work",
                size: 20,
                fontWeight: FontWeight.w600,
                color: AppColor.blackColor),
            SizedBox(
              height: Get.height * 0.025,
            ),
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
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  AppText(
                      title:
                          "1 - Refer your friends to earn \$2 for each successful login(users limit 100).",
                      size: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackColor),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  AppText(
                      title:
                          "2 - After 100 users you will earn \$0.10 per referral.",
                      size: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackColor),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  AppText(
                      title:
                          "3 - You can earn 1% if your referral advertise with us.",
                      size: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackColor),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  AppText(
                      title: "4 - no invite limit per day",
                      size: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackColor),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  AppText(
                      title: "5 - easy withdrawals of reward money",
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

class RedeemNow extends StatelessWidget {
  const RedeemNow({super.key});

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
              SizedBox(
                height: 38,
              ),
              const AppText(
                  title: "Redeem ",
                  size: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackColor),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 38,
                    ),
                    textAuth(text: "Amount", color: Colors.transparent),
                    SizedBox(
                      height: Get.height * 0.013,
                    ),
                    betField(
                        hint: typeAmountHere.tr,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.phone),
                    SizedBox(
                      height: 20,
                    ),
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
                            SizedBox(
                              width: 15,
                            ),
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
                                SizedBox(
                                  height: 6,
                                ),
                                AppText(
                                    title: "Royal bank of canada",
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
                                SizedBox(
                                  width: 25,
                                ),
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
