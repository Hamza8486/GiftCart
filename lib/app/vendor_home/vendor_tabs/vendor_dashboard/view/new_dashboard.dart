import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/component/partner_drawer.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/component/payments.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorNewDashboard extends StatefulWidget {
  @override
  State<VendorNewDashboard> createState() => _VendorNewDashboardState();
}

class _VendorNewDashboardState extends State<VendorNewDashboard> {
  int _current = 0;
  List<String> bannerList = [
    'assets/images/mans.png',
    'assets/images/mans.png',
    'assets/images/mans.png',

    // Add more image paths as needed
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: PartnerDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 102,
                width: Get.width,
                decoration: BoxDecoration(color: AppColor.whiteColor),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 52,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.put(VendorController())
                                  .getBusinessProfileData();
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: Image.asset(
                              "assets/images/menu.png",
                              height: 38,
                              width: 38,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: AppText(
                              title: myStore.tr,
                              size: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColor.boldBlackColor,
                            ),
                          ),
                          AppText(
                            title: testimonimals.tr,
                            size: 0,
                            fontWeight: FontWeight.w500,
                            color: AppColor.whiteColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(gradient: AppColor.Home_GRADIENT),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: (Get.put(VendorController())
                                      .profileAllData
                                      ?.data
                                      ?.store
                                      ?.logo)
                                  .toString(),
                              fit: BoxFit.cover,
                              width: Get.width,
                              height: 200,
                              errorWidget: (context, url, error) => ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/images/real.webp",
                                  fit: BoxFit.cover,
                                  width: Get.width,
                                  height: 200,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(gradient: AppColor.Home_GRADIENT),
                height: Get.height,
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/coup.jpeg",
                        width: Get.width,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
          NewDraggableSheet(),
        ],
      ),
    );
  }
}

class NewDraggableSheet extends StatefulWidget {
  @override
  State<NewDraggableSheet> createState() => _NewDraggableSheetState();
}

class _NewDraggableSheetState extends State<NewDraggableSheet> {
  int _current = 0;
  List<String> bannerList = [
    'assets/images/mans.png',
    'assets/images/mans.png',
    'assets/images/mans.png',

    // Add more image paths as needed
  ];

  void openWhatsApp({String phoneNumber = "", String message = ""}) async {
    String url = "https://wa.me/$phoneNumber?text=${Uri.parse(message)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      // Initial percentage of the screen height
      maxChildSize: 0.87, // Maximum percentage of the screen height
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(color: AppColor.greyLightColor2),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Obx(() {
                          return Get.put(AuthController()).allAdsLoader.value
                              ? Center(
                                  child: SpinKitThreeBounce(
                                      size: 25, color: AppColor.primaryColor))
                              : Get.put(AuthController())
                                      .getAllAdsList
                                      .isNotEmpty
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
                                                const Duration(seconds: 4),
                                            autoPlayAnimationDuration:
                                                const Duration(
                                                    milliseconds: 600),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: true,
                                            scrollDirection: Axis.horizontal,
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                _current = index;
                                              });
                                            },
                                            enlargeStrategy:
                                                CenterPageEnlargeStrategy
                                                    .height,
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
                                                              BorderRadius
                                                                  .circular(
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
                                                                      height:
                                                                          44,
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(1000),
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/images/logo_man.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          width:
                                                                              62,
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
                                                                              color: AppColor.blackColor,
                                                                              fontSize: 24,
                                                                              fontWeight: FontWeight.w500)),
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
                                                                          color: AppColor.primaryColor.withOpacity(
                                                                              0.2),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8)),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                13,
                                                                            vertical:
                                                                                5),
                                                                        child:
                                                                            AppText(
                                                                          title: item.offerTypeValue == null
                                                                              ? "0% Off"
                                                                              : "${item.offerTypeValue.toString()}% Off",
                                                                          size:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color:
                                                                              AppColor.primaryColor,
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
                                                                        onTap:
                                                                            () {
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
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              border: Border.all(color: AppColor.primaryColor)),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                AppText(
                                                                              title: visitWebsite.tr,
                                                                              size: 14,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColor.primaryColor,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          openWhatsApp(
                                                                              phoneNumber: item.whatsapp.toString(),
                                                                              message: welcomeToMyGrocery.tr);
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
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width: 150,
                                                                  height: 140,
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/images/mans.png",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      width:
                                                                          210,
                                                                      height:
                                                                          140,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                  top: 12,
                                                                  right: 12,
                                                                  child: Image
                                                                      .asset(
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
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4.0),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: _current ==
                                                                entry.key
                                                            ? AppColor
                                                                .primaryColor
                                                            : Colors.white
                                                                .withOpacity(
                                                                    0.6)),
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
                                                const Duration(
                                                    milliseconds: 400),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: true,
                                            scrollDirection: Axis.horizontal,
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                _current = index;
                                              });
                                            },
                                            enlargeStrategy:
                                                CenterPageEnlargeStrategy
                                                    .height,
                                          ),
                                          items: bannerList
                                              .map((item) => GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.red
                                                              .withOpacity(0.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
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
                                                                      height:
                                                                          22,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 6,
                                                                    ),
                                                                    Text(
                                                                      specialOffer
                                                                          .tr,
                                                                      style: GoogleFonts.italianno(
                                                                          textStyle: TextStyle(
                                                                              color: AppColor.blackColor,
                                                                              fontSize: 24,
                                                                              fontWeight: FontWeight.w500)),
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
                                                                          color: AppColor.primaryColor.withOpacity(
                                                                              0.2),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8)),
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
                                                                          size:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color:
                                                                              AppColor.primaryColor,
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
                                                                  child: Image
                                                                      .asset(
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
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4.0),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: _current ==
                                                                entry.key
                                                            ? AppColor
                                                                .primaryColor
                                                            : Colors.white
                                                                .withOpacity(
                                                                    0.6)),
                                                  ),
                                                );
                                              }).toList(),
                                            )),
                                      ],
                                    );
                        }),

                        SizedBox(
                          height: Get.height * 0.023,
                        ),
                        AppText(
                          title: storeHours.tr,
                          size: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Obx(() {
                          return Get.put(VendorController()).loaderProfile.value
                              ? Center(
                                  child: SpinKitThreeBounce(
                                      size: 25, color: AppColor.primaryColor))
                              : Container(
                                  width: Get.width,
                                  height: 88,
                                  decoration: BoxDecoration(
                                      color: Color(0xffEBEBEB).withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Get.put(VendorController())
                                                        .profileAllData
                                                        ?.data
                                                        ?.store
                                                        ?.openTime ==
                                                    null
                                                ? SizedBox.shrink()
                                                : AppText(
                                                    title: today.tr,
                                                    size: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColor.boldBlackColor,
                                                  ),
                                            AppText(
                                              title: Get.put(VendorController())
                                                          .profileAllData
                                                          ?.data
                                                          ?.store
                                                          ?.openTime ==
                                                      null
                                                  ? noTimeUpdate.tr
                                                  : "${DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse((Get.put(VendorController()).profileAllData?.data?.store?.openTime).toString()))} - ${DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse((Get.put(VendorController()).profileAllData?.data?.store?.endTime).toString()))}",
                                              size: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.greyLightColor2,
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                isScrollControlled: true,
                                                isDismissible: true,
                                                context: context,
                                                builder: (context) =>
                                                    TimeWidget());
                                          },
                                          child: Container(
                                            height: 32,
                                            width: 84,
                                            decoration: BoxDecoration(
                                                gradient:
                                                    AppColor.Home_GRADIENT,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: AppText(
                                                title: update.tr,
                                                size: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.whiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        }),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(PaymentsView(
                                    type: "true",
                                  ));
                                },
                                child: Container(
                                  height: 130,
                                  decoration: BoxDecoration(
                                      gradient: AppColor.Home_GRADIENT,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Get.height * 0.015,
                                        horizontal: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/icons/orders.png",
                                              height: 42,
                                              width: 42,
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.03,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(() {
                                                  return Get.put(
                                                              VendorController())
                                                          .loaderProfile
                                                          .value
                                                      ? AppText(
                                                          title: "\$0",
                                                          size: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColor
                                                              .whiteColor,
                                                        )
                                                      : AppText(
                                                          title:
                                                              "\$${(Get.put(VendorController()).profileAllData?.data?.store == null ? "0" : Get.put(VendorController()).profileAllData?.data?.store?.balance).toString()}",
                                                          size: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColor
                                                              .whiteColor,
                                                        );
                                                }),
                                                AppText(
                                                  title: payments.tr,
                                                  size: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.whiteColor,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        Center(
                                          child: AppText(
                                            title: tapToView.tr,
                                            size: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.05,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(PaymentsView(
                                    type: "true",
                                  ));
                                },
                                child: Container(
                                  height: 130,
                                  decoration: BoxDecoration(
                                      color: Color(0xffEBEBEB),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Get.height * 0.015,
                                        horizontal: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/icons/payment.png",
                                              height: 42,
                                              width: 42,
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.03,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(() {
                                                  return AppText(
                                                    title: Get.put(
                                                                VendorController())
                                                            .getProofList
                                                            .isEmpty
                                                        ? "0"
                                                        : Get.put(
                                                                VendorController())
                                                            .getProofList
                                                            .length
                                                            .toString(),
                                                    size: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.blackColor,
                                                  );
                                                }),
                                                AppText(
                                                  title: todayOrders.tr,
                                                  size: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.blackColor,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        Center(
                                          child: AppText(
                                            title: tapToView.tr,
                                            size: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: Get.height*0.025,),
                        //
                        //
                        //
                        //
                        // Image.asset("assets/images/chart1.png",
                        //
                        // ),

                        SizedBox(
                          height: Get.height * 0.023,
                        ),
                        AppText(
                          title: orderOverview.tr,
                          size: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        Obx(() {
                          return Get.put(VendorController())
                                  .allPaymentLoader
                                  .value
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                    ),
                                    Center(
                                        child: SpinKitThreeBounce(
                                            size: 25,
                                            color: AppColor.primaryColor)),
                                  ],
                                )
                              : Get.put(VendorController()).getProofList.isEmpty
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.2,
                                        ),
                                        Center(
                                            child: AppText(
                                          title: noOrderData.tr,
                                          color: AppColor.blackColor
                                              .withOpacity(0.7),
                                          size: 16,
                                          fontWeight: FontWeight.w500,
                                        ))
                                      ],
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: Get.put(VendorController())
                                          .getProofList
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        DateTime time = DateTime.parse(
                                          Get.put(VendorController())
                                              .getProofList[index]
                                              .createdAt
                                              .toString(),
                                        );
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xffF65356)
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                              color: Colors.white,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 13),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  Get.width *
                                                                      0.03),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            "assets/icons/grocery.png",
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                          SizedBox(
                                                            width: Get.width *
                                                                0.01,
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          Get.width *
                                                                              0.017),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      AppText(
                                                                        title: grocery
                                                                            .tr,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        size:
                                                                            16,
                                                                        color: AppColor
                                                                            .blackColor,
                                                                      ),
                                                                      SizedBox(
                                                                        height: Get.height *
                                                                            0.001,
                                                                      ),
                                                                      AppText(
                                                                        title:
                                                                            "${Get.put(VendorController()).getProofList.length.toString()} items",
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        size:
                                                                            12,
                                                                        color: AppColor
                                                                            .greyLightColor2,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      AppText(
                                                                        title:
                                                                            "\$${Get.put(VendorController()).getProofList[index].amount.toString()}",
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        size:
                                                                            16,
                                                                        color: AppColor
                                                                            .blackColor,
                                                                      ),
                                                                      SizedBox(
                                                                        height: Get.height *
                                                                            0.001,
                                                                      ),
                                                                      AppText(
                                                                        title: invoice
                                                                            .tr,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        size:
                                                                            14,
                                                                        color: AppColor
                                                                            .primaryColor,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      height: 31,
                                                      width: Get.width,
                                                      decoration: BoxDecoration(
                                                          color: AppColor
                                                              .primaryColor
                                                              .withOpacity(
                                                                  0.1)),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            AppText(
                                                              title: DateFormat(
                                                                      'MMM dd, yyyy')
                                                                  .format(time),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              size: 14,
                                                              color: AppColor
                                                                  .blackColor,
                                                            ),
                                                            Container()
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                        }),
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TimeWidget extends StatefulWidget {
  TimeWidget({super.key});

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  var startTime = TextEditingController();
  var endTime = TextEditingController();

  bool monday = true;
  bool tued = true;
  bool wedd = true;
  bool thurd = true;
  bool frid = true;
  bool satd = true;
  bool sund = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime.text = Get.put(VendorController())
                .profileAllData
                ?.data
                ?.store
                ?.openTime ==
            null
        ? ""
        : (Get.put(VendorController()).profileAllData?.data?.store?.openTime)
            .toString();
    endTime.text =
        Get.put(VendorController()).profileAllData?.data?.store?.endTime == null
            ? ''
            : (Get.put(VendorController()).profileAllData?.data?.store?.endTime)
                .toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.75,
      maxChildSize: 0.75,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.0, horizontal: Get.width * 0.05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Image.asset(
                    "assets/images/slide.png",
                    scale: 3,
                  )
                ],
              ),
              AppText(
                  title: storeHours.tr,
                  size: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackColor),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                    title: opening.tr,
                                    size: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.blackColor),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                betField(
                                    hint: openingTime.tr,
                                    max: 1,
                                    controller: startTime,
                                    isRead: true,
                                    isCur: false,
                                    onTap: () async {
                                      final TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          return MediaQuery(
                                            data: MediaQuery.of(context)
                                                .copyWith(
                                                    alwaysUse24HourFormat:
                                                        true),
                                            child: child!,
                                          );
                                        },
                                      );

                                      if (pickedTime != null) {
                                        final String formattedTime =
                                            '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                            '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                        setState(() {
                                          startTime.text =
                                              '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                              '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                          print(thisIsTime.tr +
                                              "  ${startTime.text}");
                                        });
                                      }
                                    },
                                    textInputType: TextInputType.phone,
                                    textInputAction: TextInputAction.done),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                    title: closing.tr,
                                    size: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.blackColor),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                betField(
                                    hint: closingTime.tr,
                                    max: 1,
                                    isRead: true,
                                    isCur: false,
                                    onTap: () async {
                                      final TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          return MediaQuery(
                                            data: MediaQuery.of(context)
                                                .copyWith(
                                                    alwaysUse24HourFormat:
                                                        true),
                                            child: child!,
                                          );
                                        },
                                      );

                                      if (pickedTime != null) {
                                        final String formattedTime =
                                            '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                            '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                        setState(() {
                                          endTime.text =
                                              '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                              '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                          print(thisIsTime.tr +
                                              "  ${endTime.text}");
                                        });
                                      }
                                    },
                                    controller: endTime,
                                    textInputType: TextInputType.phone,
                                    textInputAction: TextInputAction.done),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                    title: mon.tr,
                                    size: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor),
                                AppText(
                                    title: "1",
                                    size: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    monday = true;
                                  });
                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.blackColor),
                                      shape: BoxShape.circle),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            color: monday == true
                                                ? AppColor.blackColor
                                                : AppColor.whiteColor,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.015,
                              ),
                              AppText(
                                  title: opened.tr,
                                  size: 14,
                                  fontWeight: monday == true
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    monday = false;
                                  });
                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.blackColor),
                                      shape: BoxShape.circle),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            color: monday == false
                                                ? AppColor.blackColor
                                                : AppColor.whiteColor,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.015,
                              ),
                              AppText(
                                  title: closed.tr,
                                  size: 14,
                                  fontWeight: monday == false
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                    title: tue.tr,
                                    size: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor),
                                AppText(
                                    title: "1",
                                    size: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    tued = true;
                                  });
                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.blackColor),
                                      shape: BoxShape.circle),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            color: tued == true
                                                ? AppColor.blackColor
                                                : AppColor.whiteColor,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.015,
                              ),
                              AppText(
                                  title: opened.tr,
                                  size: 14,
                                  fontWeight: tued == true
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    tued = false;
                                  });
                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.blackColor),
                                      shape: BoxShape.circle),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            color: tued == false
                                                ? AppColor.blackColor
                                                : AppColor.whiteColor,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.015,
                              ),
                              AppText(
                                  title: closed.tr,
                                  size: 14,
                                  fontWeight: tued == false
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                    title: wed.tr,
                                    size: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor),
                                AppText(
                                    title: "1",
                                    size: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    wedd = true;
                                  });
                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.blackColor),
                                      shape: BoxShape.circle),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            color: wedd == true
                                                ? AppColor.blackColor
                                                : AppColor.whiteColor,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.015,
                              ),
                              AppText(
                                  title: opened.tr,
                                  size: 14,
                                  fontWeight: wedd == true
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    wedd = false;
                                  });
                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.blackColor),
                                      shape: BoxShape.circle),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            color: wedd == false
                                                ? AppColor.blackColor
                                                : AppColor.whiteColor,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.015,
                              ),
                              AppText(
                                  title: closed.tr,
                                  size: 14,
                                  fontWeight: wedd == false
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                    title: thu.tr,
                                    size: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor),
                                AppText(
                                    title: "1",
                                    size: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    thurd = true;
                                  });
                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.blackColor),
                                      shape: BoxShape.circle),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            color: thurd == true
                                                ? AppColor.blackColor
                                                : AppColor.whiteColor,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.015,
                              ),
                              AppText(
                                  title: opened.tr,
                                  size: 14,
                                  fontWeight: thurd == true
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    thurd = false;
                                  });
                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.blackColor),
                                      shape: BoxShape.circle),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            color: thurd == false
                                                ? AppColor.blackColor
                                                : AppColor.whiteColor,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.015,
                              ),
                              AppText(
                                  title: closed.tr,
                                  size: 14,
                                  fontWeight: thurd == false
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                    title: fri.tr,
                                    size: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor),
                                AppText(
                                    title: "1",
                                    size: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    frid = true;
                                  });
                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.blackColor),
                                      shape: BoxShape.circle),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            color: frid == true
                                                ? AppColor.blackColor
                                                : AppColor.whiteColor,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.015,
                              ),
                              AppText(
                                  title: opened.tr,
                                  size: 14,
                                  fontWeight: frid == true
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    frid = false;
                                  });
                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.blackColor),
                                      shape: BoxShape.circle),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            color: frid == false
                                                ? AppColor.blackColor
                                                : AppColor.whiteColor,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.015,
                              ),
                              AppText(
                                  title: closed.tr,
                                  size: 14,
                                  fontWeight: frid == false
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                    title: sat.tr,
                                    size: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor),
                                AppText(
                                    title: "1",
                                    size: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    satd = true;
                                  });
                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.blackColor),
                                      shape: BoxShape.circle),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            color: satd == true
                                                ? AppColor.blackColor
                                                : AppColor.whiteColor,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.015,
                              ),
                              AppText(
                                  title: opened.tr,
                                  size: 14,
                                  fontWeight: satd == true
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    satd = false;
                                  });
                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.blackColor),
                                      shape: BoxShape.circle),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            color: satd == false
                                                ? AppColor.blackColor
                                                : AppColor.whiteColor,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.015,
                              ),
                              AppText(
                                  title: closed.tr,
                                  size: 14,
                                  fontWeight: satd == false
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Obx(() {
                return Get.put(VendorController()).timeLoader.value
                    ? Center(
                        child: SpinKitThreeBounce(
                            size: 25, color: AppColor.primaryColor))
                    : AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(10),
                        buttonName: update.tr,
                        fontWeight: FontWeight.w500,
                        textSize: 16,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          if (startTime.text.isEmpty) {
                            flutterToast(msg: pleaseSelectStartTime.tr);
                          } else if (endTime.text.isEmpty) {
                            flutterToast(msg: pleaseSelectEndTime.tr);
                          } else {
                            Get.put(VendorController()).updateTimeLoader(true);
                            ApiManger().updateTime(
                                start: startTime.text, end: endTime.text);
                          }
                        });
              }),
              SizedBox(
                height: Get.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
