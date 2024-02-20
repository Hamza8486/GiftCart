import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/component.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

class GameManual extends StatefulWidget {
  GameManual({Key? key}) : super(key: key);

  @override
  State<GameManual> createState() => _GameManualState();
}

class _GameManualState extends State<GameManual> {
  void openWhatsApp({String phoneNumber = "", String message = ""}) async {
    String url = "https://wa.me/$phoneNumber?text=${Uri.parse(message)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final homeController = Get.put(HomeController());

  //final auth = Get.put(AuthController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current = 0;

  final CarouselController _controller = CarouselController();
  List<String> bannerList = [
    'assets/images/mans.png',
    'assets/images/mans.png',
    'assets/images/mans.png',

    // Add more image paths as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(
              onTap1: () {},
              onTap: () {
                Get.back();
              },
              text: userManual.tr,
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
                      height: Get.height * 0.02,
                    ),
                    Obx(() {
                      return Get.put(AuthController()).allAdsLoader.value
                          ? Center(
                              child: SpinKitThreeBounce(
                                  size: 25, color: AppColor.primaryColor))
                          : Get.put(AuthController()).getAllAdsList.isNotEmpty
                              ? Stack(
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
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
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
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.height,
                                      ),
                                      items: Get.put(AuthController())
                                          .getAllAdsList
                                          .map((item) => GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 0,
                                                                left: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                CachedNetworkImage(
                                                                  imageUrl: item
                                                                      .image
                                                                      .toString(),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width: 62,
                                                                  height: 44,
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            1000),
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/images/logo_man.png",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      width: 62,
                                                                      height:
                                                                          44,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Text(
                                                                  specialOffer
                                                                      .tr,
                                                                  style: GoogleFonts.italianno(
                                                                      textStyle: TextStyle(
                                                                          color: AppColor
                                                                              .blackColor,
                                                                          fontSize:
                                                                              24,
                                                                          fontWeight:
                                                                              FontWeight.w500)),
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
                                                                          .withOpacity(
                                                                              0.2),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            13,
                                                                        vertical:
                                                                            5),
                                                                    child:
                                                                        AppText(
                                                                      title: item.offerTypeValue ==
                                                                              null
                                                                          ? "0% Off"
                                                                          : "${item.offerTypeValue.toString()}% Off",
                                                                      size: 12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: AppColor
                                                                          .primaryColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                AppText(
                                                                  title:
                                                                      onAllOrders
                                                                          .tr,
                                                                  size: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColor
                                                                      .blackColor,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 14,
                                                            ),
                                                            item.isWebsite ==
                                                                    true
                                                                ? GestureDetector(
                                                                    onTap: () {
                                                                      launch(item
                                                                          .website
                                                                          .toString());
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          120,
                                                                      height:
                                                                          32,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          border:
                                                                              Border.all(color: AppColor.primaryColor)),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            AppText(
                                                                          title:
                                                                              visitWebsite.tr,
                                                                          size:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              AppColor.primaryColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : GestureDetector(
                                                                    onTap: () {
                                                                      openWhatsApp(
                                                                          phoneNumber: item
                                                                              .whatsapp
                                                                              .toString(),
                                                                          message:
                                                                              welcomeToMyGrocery.tr);
                                                                    },
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/images/chat.png",
                                                                      width:
                                                                          104,
                                                                      height:
                                                                          32,
                                                                    ),
                                                                  )
                                                          ],
                                                        ),
                                                      ),
                                                      Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: item
                                                                  .image
                                                                  .toString(),
                                                              fit: BoxFit.cover,
                                                              width: 150,
                                                              height: 140,
                                                              errorWidget:
                                                                  (context, url,
                                                                          error) =>
                                                                      ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    Image.asset(
                                                                  "assets/images/mans.png",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width: 210,
                                                                  height: 140,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                              top: 12,
                                                              right: 12,
                                                              child:
                                                                  Image.asset(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: bannerList
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            return GestureDetector(
                                              onTap: () => _controller
                                                  .animateToPage(entry.key),
                                              child: Container(
                                                width: 8.0,
                                                height: 8.0,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _current == entry.key
                                                        ? AppColor.primaryColor
                                                        : Colors.white
                                                            .withOpacity(0.6)),
                                              ),
                                            );
                                          }).toList(),
                                        )),
                                  ],
                                )
                              : Stack(
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
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
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
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.height,
                                      ),
                                      items: bannerList
                                          .map((item) => GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 0,
                                                                left: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/logo_man.png",
                                                                  width: 31,
                                                                  height: 22,
                                                                ),
                                                                SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Text(
                                                                  specialOffer.tr,
                                                                  style: GoogleFonts.italianno(
                                                                      textStyle: TextStyle(
                                                                          color: AppColor
                                                                              .blackColor,
                                                                          fontSize:
                                                                              24,
                                                                          fontWeight:
                                                                              FontWeight.w500)),
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
                                                                          .withOpacity(
                                                                              0.2),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            13,
                                                                        vertical:
                                                                            5),
                                                                    child:
                                                                        AppText(
                                                                      title:
                                                                         fiftyOff.tr,
                                                                      size: 12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: AppColor
                                                                          .primaryColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                AppText(
                                                                  title:
                                                                      onAllOrders.tr,
                                                                  size: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColor
                                                                      .blackColor,
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
                                                              child:
                                                                  Image.asset(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: bannerList
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            return GestureDetector(
                                              onTap: () => _controller
                                                  .animateToPage(entry.key),
                                              child: Container(
                                                width: 8.0,
                                                height: 8.0,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _current == entry.key
                                                        ? AppColor.primaryColor
                                                        : Colors.white
                                                            .withOpacity(0.6)),
                                              ),
                                            );
                                          }).toList(),
                                        )),
                                  ],
                                );
                    }),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    AppText(
                      title: instructionToBuyCoupons.tr,
                      size: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColor.primaryColor,
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    textProfile(
                        text: oneSelectProvince.tr,
                        text1: oneSelectProvinceText.tr),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    textProfile(
                        text: twoChooseSlot.tr, text1: twoChooseSlotText.tr),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    textProfile(
                        text: threeConfirmSelection.tr,
                        text1: threeConfirmSelectionText.tr),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    textProfile(
                        text: fourPayment.tr, text1: fourPaymentText.tr),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    textProfile(
                        text: fiveCouponScratching.tr,
                        text1: fiveCouponScratchingText.tr),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    textProfile(
                        text: sixScratchCoupons.tr,
                        text1: sixScratchCouponsText.tr),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    AppText(
                      title: youCanBuyUpTo20Slots.tr,
                      size: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColor.greyLightColor,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    textProfile(
                        text: importantTimingInfo.tr,
                        text1: slotPurchaseAvailable7to6_30.tr,
                        textColor: AppColor.blackColor,
                        color: AppColor.primaryColor),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    textProfile(
                        text: giftReveal.tr,
                        text1: at7MrWillSendSpecialMsg.tr,
                        textColor: AppColor.blackColor,
                        color: AppColor.primaryColor),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    Image.asset("assets/images/manual.png"),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
