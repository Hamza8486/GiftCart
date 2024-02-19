import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/bottom_tabs/component/drawer.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/component/wallet.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/slot_model.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/view/dashboard_view.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/notification_view.dart';
import 'package:mr_bet/app/bottom_tabs/wallet/view/wallet_view.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/app/home/home_view.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _opacity = 0.0;
  final homeController = Get.put(HomeController());

  //final auth = Get.put(AuthController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current = 0;
  List<String> bannerList = [
    'assets/images/banner9.png',
    'assets/images/banner10.png',
    'assets/images/banner11.png',
  ];

  final CarouselController _controller = CarouselController();
  String? _selectedItem;
  var provinceId;
  String? isSelect;
  String? slots;
  int totalSlots = 0;

  List<String> types = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "16",
    "17",
    "18",
    "19",
    "20",
  ];
  bool isScratched = false;
  double opacity = 0.5;
  Timer? _timer;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  //List<String> provinceList = [];
  @override
  void initState() {
    super.initState();
    //homeController.getAllTest(id: "");
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Duration _getTimeUntil12am() {
    final now = DateTime.now();
    final tomorrowMidnight =
        DateTime(now.year, now.month, now.day + 1, 0, 0, 0);
    return tomorrowMidnight.isBefore(now)
        ? const Duration(seconds: 0)
        : tomorrowMidnight.difference(now);
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final remainingDuration = _getTimeUntil12am();
      if (remainingDuration.inSeconds <= 0) {
        timer.cancel();
        setState(() {
          _hours = 0;
          _minutes = 0;
          _seconds = 0;
        });
      } else {
        setState(() {
          _hours = remainingDuration.inHours;
          _minutes = remainingDuration.inMinutes.remainder(60);
          _seconds = remainingDuration.inSeconds.remainder(60);
        });
      }
    });
  }

  double _calculateProgress() {
    final totalTimeInSeconds = 12 * 3600; // 12 hours in seconds
    final remainingTimeInSeconds = _hours * 3600 + _minutes * 60 + _seconds;
    return (totalTimeInSeconds - remainingTimeInSeconds) / totalTimeInSeconds;
  }

  String? provinceName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
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
                        height: 45,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: Image.asset(
                              "assets/images/menu.png",
                              height: 38,
                              width: 38,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/logo1.png",
                                height: 53,
                                width: 70,
                              ),
                              SizedBox(
                                width: 38,
                              ),
                              GestureDetector(
                                onTap: () {
                                  homeController.getTransData();
                                  homeController.getSlotHis();
                                  Get.to(const NewWalletView(),
                                      transition: Transition.rightToLeft);
                                },
                                child: Image.asset(
                                  "assets/images/wallets.png",
                                  height: 26,
                                  width: 26,
                                ),
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              GestureDetector(
                                onTap: () {

                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) => LanguageWidget());
                                },
                                child: Image.asset(
                                  "assets/images/lang.png",
                                  height: 26,
                                  width: 26,
                                ),
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.put(HomeController()).getNotiHis();
                                  Get.to(NotificationView());
                                },
                                child: Image.asset(
                                  "assets/icons/not.png",
                                  height: 28,
                                  width: 28,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // dashboardTopBar(
              //     onTap: () {
              //       _scaffoldKey.currentState?.openDrawer();
              //       print("object");
              //     },
              //     onTap1: () {
              //
              //     },
              //     text: "0${homeController.profileId.value}"),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(gradient: AppColor.Home_GRADIENT),
                height: Get.height,
                width: Get.width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 25),
                    child: Column(
                      children: [
                        AppText(
                          title: hereAffordabilityMeetsConvenience.tr,
                          size: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        AppText(
                          title: becauseYouDeserveBest.tr,
                          size: 12,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        CarouselSlider(
                          carouselController: _controller,
                          options: CarouselOptions(
                            aspectRatio: 16 / 9,
                            pageSnapping: false,
                            height: 185,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            pauseAutoPlayInFiniteScroll: false,
                            reverse: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 2),
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
                                      child: Image.asset(
                                        item.toString(),
                                        width: 157,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: bannerList.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 20.0,
                                height: 2.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    color: _current == entry.key
                                        ? AppColor.primaryColor
                                        : AppColor.whiteColor),
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
          DraggableSheet(),
        ],
      ),
    );
  }
}

class DraggableSheet extends StatefulWidget {
  @override
  State<DraggableSheet> createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  double _opacity = 0.0;
  final homeController = Get.put(HomeController());

  //final auth = Get.put(AuthController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current = 0;

  final CarouselController _controller = CarouselController();
  String? _selectedItem;
  var provinceId;
  String? isSelect;
  String? slots;
  int totalSlots = 0;

  void openWhatsApp({String phoneNumber = "", String message = ""}) async {
    String url = "https://wa.me/$phoneNumber?text=${Uri.parse(message)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<String> types = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "16",
    "17",
    "18",
    "19",
    "20",
  ];
  bool isScratched = false;
  double opacity = 0.5;
  Timer? _timer;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  //List<String> provinceList = [];
  @override
  void initState() {
    super.initState();
    //homeController.getAllTest(id: "");
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Duration _getOneMinuteDuration() {
    return const Duration(minutes: 1);
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_seconds == 0) {
          if (_minutes == 0) {
            // If both minutes and seconds are zero, restart the timer
            _minutes = 1;
            _seconds = 0;
          } else {
            // If seconds are zero but there are remaining minutes, decrement minutes
            _minutes -= 1;
            _seconds = 59;
          }
        } else {
          // If there are remaining seconds, decrement seconds
          _seconds -= 1;
        }
      });
    });
  }

  // Duration _getTimeUntil12am() {
  //   final now = DateTime.now();
  //   final tomorrowMidnight = DateTime(now.year, now.month, now.day + 1, 0, 0, 0);
  //   return tomorrowMidnight.isBefore(now) ? const Duration(seconds: 0) : tomorrowMidnight.difference(now);
  // }
  //
  // void startTimer() {
  //   _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
  //     final remainingDuration = _getTimeUntil12am();
  //     if (remainingDuration.inSeconds <= 0) {
  //       timer.cancel();
  //       setState(() {
  //         _hours = 0;
  //         _minutes = 0;
  //         _seconds = 0;
  //       });
  //     } else {
  //       setState(() {
  //         _hours = remainingDuration.inHours;
  //         _minutes = remainingDuration.inMinutes.remainder(60);
  //         _seconds = remainingDuration.inSeconds.remainder(60);
  //       });
  //     }
  //   });
  // }
  double _calculateProgress() {
    final totalTimeInSeconds = 12 * 3600; // 12 hours in seconds
    final remainingTimeInSeconds = _hours * 3600 + _minutes * 60 + _seconds;
    return (totalTimeInSeconds - remainingTimeInSeconds) / totalTimeInSeconds;
  }

  List<String> bannerList = [
    'assets/images/mans.png',
    'assets/images/mans.png',
    'assets/images/mans.png',

    // Add more image paths as needed
  ];

  final authCcontroller = Get.put(AuthController());

  String? provinceName;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.76,
      minChildSize: 0.46,
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.035),
                        child: Obx(() {
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
                                                                              fiftyOff,
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
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: SizedBox(
                          height: 20,
                          child: ListView.builder(
                              itemCount: 3,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: 20,
                                  width: 259,
                                  child: AppText(
                                    title: index == 0
                                        ? "Hamza just bought 4 Coupons(QC)"
                                        : index == 1
                                            ? "riddhi just bought 16 Coupons(AC)"
                                            : "riddhi just bought 20 Coupons(QC)",
                                    size: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff45A843),
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                        child: Row(
                          children: [
                            Expanded(
                              child: Obx(() {
                                return GestureDetector(
                                  onTap: () {
                                    homeController.getProfileData();

                                    homeController.updateSelectOption("3");
                                    homeController.updateSelectName("grocery");
                                    setState(() {
                                      _selectedItem = null;
                                      homeController.slotAddList.clear();
                                    });
                                    homeController.getSlotData();
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        gradient: new LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            AppColor.primaryColor1,
                                            AppColor.primaryColor,
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Center(
                                        child: AppText(
                                          title: "Grocery",
                                          size: 15,
                                          fontWeight: FontWeight.w600,
                                          color: homeController
                                                      .selectOption.value ==
                                                  "3"
                                              ? AppColor.whiteColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: Get.width * 0.13,
                          right: Get.width * 0.1,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                  width: Get.width,
                                  child: Obx(() {
                                    return dropDownAppAddAll(
                                      hint: selectProvince.tr,
                                      child1: SvgPicture.asset(
                                        "assets/icons/layer.svg",
                                        height: Get.height * 0.018,
                                        color: AppColor.boldBlackColor,
                                      ),
                                      width: Get.put(AuthController())
                                              .provinceList
                                              .isEmpty
                                          ? Get.width * 0.36
                                          : Get.width * 0.36,
                                      height: Get.height * 0.3,
                                      items: Get.put(AuthController())
                                          .provinceAllList,
                                      color: AppColor.primaryColor,
                                      value: provinceName,
                                      onChange: (value) {
                                        setState(() {
                                          provinceName = value;

                                          for (int i = 0;
                                              i <
                                                  Get.put(AuthController())
                                                      .provinceList
                                                      .length;
                                              i++) {
                                            if (value ==
                                                Get.put(AuthController())
                                                    .provinceList[i]
                                                    .name) {
                                              homeController.provinceId =
                                                  Get.put(AuthController())
                                                      .provinceList[i]
                                                      .id;
                                              homeController
                                                  .updateProvincesName(
                                                      Get.put(AuthController())
                                                          .provinceList[i]
                                                          .name);
                                              homeController.updateSlotName("");
                                              homeController
                                                  .updateIsSelectProvince(
                                                      value.toString());
                                            }
                                          }
                                        });
                                      },
                                    );
                                  })),
                            ),
                            SizedBox(
                              width: Get.width * 0.04,
                            ),
                            Expanded(
                              child: SizedBox(
                                  width: Get.width,
                                  child: Obx(() {
                                    return dropDownAppAddAll(
                                        hint: selectSlot.tr,
                                        child1: SvgPicture.asset(
                                          "assets/images/slot.svg",
                                          height: Get.height * 0.018,
                                          color: AppColor.boldBlackColor,
                                        ),
                                        width: Get.width * 0.36,
                                        height: Get.height * 0.3,
                                        items: types,
                                        color: AppColor.primaryColor,
                                        value: homeController.slot.value.isEmpty
                                            ? null
                                            : homeController.slot.value,
                                        onChange: (value) {
                                          setState(() {
                                            if (homeController
                                                    .isSelectProvince.value !=
                                                "") {
                                              homeController.updateSlotName(
                                                  value.toString());

                                              // Check if an item with the same provinceId already exists in the list
                                              final existingSlotIndex =
                                                  homeController.slotAddList
                                                      .indexWhere(
                                                (slot) =>
                                                    slot.id ==
                                                    homeController.provinceId
                                                        .toString(),
                                              );

                                              if (existingSlotIndex != -1) {
                                                // Update the existing slot with the new value
                                                homeController
                                                    .slotAddList[
                                                        existingSlotIndex]
                                                    .slot = value.toString();
                                              } else {
                                                // Add a new item to the list
                                                homeController.slotAddList.add(
                                                  AddSlotModel(
                                                    name: homeController
                                                        .selectProvince.value
                                                        .toString(),
                                                    id: homeController
                                                        .provinceId
                                                        .toString(),
                                                    slot: value.toString(),
                                                    total: "",
                                                  ),
                                                );
                                              }

                                              homeController.updateSlotName("");
                                              totalSlots = 0;

                                              for (var slots in homeController
                                                  .slotAddList) {
                                                totalSlots +=
                                                    int.parse(slots.slot ?? "");
                                              }

                                              homeController.provinceId = null;
                                              provinceName = null;
                                              homeController.updateSlotName("");
                                              homeController
                                                  .updateIsSelectProvince("");
                                              homeController
                                                  .updateProvincesName("");
                                            } else {
                                              homeController.provinceId = null;
                                              homeController
                                                  .updateIsSelectProvince("");
                                              homeController.updateSlotName("");
                                              homeController
                                                  .updateProvincesName("");
                                              flutterToast(
                                                  msg:pleaseSelectProvince.tr);
                                            }
                                          });
                                        });
                                  })),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: new LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColor.primaryColor1,
                              AppColor.primaryColor,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    title:couponDetails.tr,
                                    size: 13,
                                    fontFamily: AppFont.medium,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  AppText(
                                    title: pricePerSlot.tr,
                                    size: 13,
                                    fontFamily: AppFont.medium,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.013,
                              ),
                              Obx(() {
                                return homeController.slotAddList.isNotEmpty
                                    ? SizedBox(
                                        height: Get.height * 0.1,
                                        child: ListView.builder(
                                            itemCount: homeController
                                                .slotAddList.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  homeController.slotAddList
                                                      .removeAt(index);
                                                  totalSlots = 0;

                                                  for (var slots
                                                      in homeController
                                                          .slotAddList) {
                                                    totalSlots += int.parse(
                                                        slots.slot ?? "");
                                                  }
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: index == 0 ? 0 : 7,
                                                      right: homeController
                                                              .slotAddList
                                                              .isEmpty
                                                          ? 7
                                                          : 7),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          AppColor.whiteColor),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20,
                                                                top: 3,
                                                                right: 3),
                                                        child: Icon(
                                                          Icons.cancel_outlined,
                                                          color: AppColor
                                                              .blackColor,
                                                          size:
                                                              Get.height * 0.02,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    Get.width *
                                                                        0.025),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.008,
                                                            ),
                                                            AppText(
                                                              title: homeController
                                                                  .slotAddList[
                                                                      index]
                                                                  .name
                                                                  .toString(),
                                                              size: 12,
                                                              fontFamily:
                                                                  AppFont
                                                                      .medium,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            const SizedBox(
                                                              height: 7,
                                                            ),
                                                            AppText(
                                                              title: homeController
                                                                  .slotAddList[
                                                                      index]
                                                                  .slot
                                                                  .toString(),
                                                              size: AppSizes
                                                                  .size_11,
                                                              fontFamily:
                                                                  AppFont
                                                                      .medium,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                                    : AppText(
                                        title: addProvinceSlot.tr,
                                        size: 18,
                                        fontFamily: AppFont.medium,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.whiteColor,
                                      );
                              }),
                              SizedBox(
                                height: Get.height * 0.013,
                              ),
                              Divider(
                                color: AppColor.primaryColor.withOpacity(0.5),
                                thickness: 2,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        title:balance.tr,
                                        size: 13,
                                        fontFamily: AppFont.medium,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.009,
                                      ),
                                      Obx(() {
                                        return homeController
                                                .transactionLoadingValue.value
                                            ? Center(
                                                child: SpinKitThreeBounce(
                                                    size: 12,
                                                    color: AppColor.whiteColor))
                                            : homeController.totalAmountWallet
                                                        .value ==
                                                    "0"
                                                ? AppText(
                                                    title: "\$0",
                                                    size: 17,
                                                    fontFamily: AppFont.semi,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  )
                                                : AppText(
                                                    title:
                                                        "\$${homeController.totalAmountWallet.value.toString()}",
                                                    size: 17,
                                                    fontFamily: AppFont.semi,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  );
                                      }),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      _minutes == 0 && _seconds == 0
                                          ? Center(
                                              child: AppText(
                                                title: timeClose.tr,
                                                size: 13,
                                                fontFamily: AppFont.semi,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Center(
                                              child: AppText(
                                                title:remainingTime.tr,
                                                size: 13,
                                                fontFamily: AppFont.medium,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                      SizedBox(
                                        height: Get.height * 0.009,
                                      ),
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                            child: CircularPercentIndicator(
                                              radius: Get.height * 0.025,
                                              lineWidth: 2,
                                              percent: (_minutes / 1)
                                                  .clamp(0.0, 1.0),
                                              // One minute in total
                                              center: Center(
                                                child: AppText(
                                                  title: "00",
                                                  size: 13,
                                                  fontFamily: AppFont.medium,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              backgroundColor: AppColor
                                                  .primaryColor
                                                  .withOpacity(0.4),
                                              progressColor:
                                                  AppColor.primaryColor,
                                              fillColor: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                            child: CircularPercentIndicator(
                                              radius: Get.height * 0.025,
                                              lineWidth: 2,
                                              percent: (_minutes / 1)
                                                  .clamp(0.0, 1.0),
                                              // One minute in total
                                              center: Center(
                                                child: AppText(
                                                  title: _minutes
                                                      .toString()
                                                      .padLeft(2, '0'),
                                                  size: 13,
                                                  fontFamily: AppFont.medium,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              backgroundColor: AppColor
                                                  .primaryColor
                                                  .withOpacity(0.4),
                                              progressColor:
                                                  AppColor.primaryColor,
                                              fillColor: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                            child: CircularPercentIndicator(
                                              radius: Get.height * 0.025,
                                              lineWidth: 2,
                                              percent: (_seconds / 60)
                                                  .clamp(0.0, 1.0),
                                              center: Center(
                                                child: AppText(
                                                  title: _seconds
                                                      .toString()
                                                      .padLeft(2, '0'),
                                                  size: 13,
                                                  fontFamily: AppFont.medium,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              backgroundColor: AppColor
                                                  .primaryColor
                                                  .withOpacity(0.4),
                                              progressColor:
                                                  AppColor.primaryColor,
                                              fillColor: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )

                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.center,
                                  //   children: [
                                  //     _hours == 0 && _minutes == 0 && _seconds == 0?
                                  //
                                  //     Center(
                                  //       child: AppText(
                                  //         title: "Time Close",
                                  //         size: 13,
                                  //         fontFamily: AppFont.semi,
                                  //         fontWeight: FontWeight.w600,
                                  //         color: Colors.white,
                                  //       ),
                                  //     ):
                                  //     Center(
                                  //       child: AppText(
                                  //         title: "Remaining Time",
                                  //         size: 13,
                                  //         fontFamily: AppFont.medium,
                                  //         fontWeight: FontWeight.w600,
                                  //         color: Colors.white,
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       height: Get.height * 0.009,
                                  //     ),
                                  //     Row(
                                  //       children: [
                                  //         ClipRRect(
                                  //           borderRadius: BorderRadius.circular(1000),
                                  //           child
                                  //               : CircularPercentIndicator(
                                  //             radius: Get.height * 0.025,
                                  //             lineWidth: 2,
                                  //             percent: (_hours / 24).clamp(0.0, 1.0), // Assuming 12 hours in total
                                  //             center: Center(
                                  //               child: AppText(
                                  //                 title: _hours.toString().padLeft(2, '0'),
                                  //                 size: 13,
                                  //                 fontFamily: AppFont.medium,
                                  //                 fontWeight: FontWeight.w600,
                                  //                 color: Colors.black,
                                  //               ),
                                  //             ),
                                  //             backgroundColor: AppColor.primaryColor.withOpacity(0.4),
                                  //             progressColor: AppColor.primaryColor,
                                  //             fillColor: Colors.white,
                                  //
                                  //           ),
                                  //         ),
                                  //
                                  //         const SizedBox(width: 5),
                                  //
                                  //         ClipRRect(
                                  //           borderRadius: BorderRadius.circular(1000),
                                  //           child
                                  //               : CircularPercentIndicator(
                                  //             radius: Get.height * 0.025,
                                  //             lineWidth: 2,
                                  //             percent: (_minutes / 60).clamp(0.0, 1.0), // Assuming 12 hours in total
                                  //             center: Center(
                                  //               child: AppText(
                                  //                 title:_minutes.toString().padLeft(2, '0'),
                                  //                 size:13,
                                  //                 fontFamily: AppFont.medium,
                                  //                 fontWeight: FontWeight.w600,
                                  //                 color: Colors.black,
                                  //               ),
                                  //             ),
                                  //             backgroundColor: AppColor.primaryColor.withOpacity(0.4),
                                  //             progressColor: AppColor.primaryColor,
                                  //             fillColor: Colors.white,
                                  //
                                  //           ),
                                  //         ),
                                  //         const SizedBox(width: 5),
                                  //         ClipRRect(
                                  //           borderRadius: BorderRadius.circular(1000),
                                  //           child
                                  //               : CircularPercentIndicator(
                                  //             radius: Get.height * 0.025,
                                  //             lineWidth: 2,
                                  //             percent: (_seconds / 60).clamp(0.0, 1.0),// Assuming 12 hours in total
                                  //             center: Center(
                                  //               child: AppText(
                                  //                 title: _seconds.toString().padLeft(2, '0'),
                                  //                 size: 13,
                                  //                 fontFamily: AppFont.medium,
                                  //                 fontWeight: FontWeight.w600,
                                  //                 color: Colors.black,
                                  //               ),
                                  //             ),
                                  //             backgroundColor: AppColor.primaryColor.withOpacity(0.4),
                                  //             progressColor: AppColor.primaryColor,
                                  //             fillColor: Colors.white,
                                  //
                                  //           ),
                                  //         ),
                                  //
                                  //       ],
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      AppText(
                        title: totalPrice.tr,
                        size: 14,
                        fontFamily: AppFont.medium,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Obx(() {
                        return AppText(
                          title: homeController.slotAddList.isEmpty
                              ? "\$0"
                              : "${totalSlots.toString()}*10 = \$${totalSlots * 10}",
                          size: 16,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        );
                      }),
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.2),
                        child: Obx(() {
                          return homeController.slotAdd.value
                              ? const Center(
                                  child: SpinKitThreeBounce(
                                      size: 25, color: AppColor.primaryColor))
                              : AppButton(
                                  buttonWidth: Get.width,
                                  buttonHeight: Get.height * 0.051,
                                  buttonRadius: BorderRadius.circular(30),
                                  buttonName: confirmSlots.tr,
                                  fontWeight: FontWeight.w500,
                                  textSize: 16,
                                  buttonColor:
                                      homeController.slotAddList.isNotEmpty
                                          ? AppColor.primaryColor
                                          : AppColor.primaryColor,
                                  textColor: AppColor.whiteColor,
                                  onTap:
                                      homeController.totalAmountWallet.value ==
                                              "0"
                                          ? () {
                                              flutterToast(
                                                  msg: pleaseAddAmount.tr);
                                            }
                                          : homeController.slotAddList.isEmpty
                                              ? () {
                                                  flutterToast(
                                                      msg:
                                                          selectProvinceAndSlot.tr);
                                                }
                                              : () {
                                                  homeController
                                                      .updateAddSlot(true);

                                                  ApiManger().AddSLots(
                                                    prodQuantity:
                                                        List<dynamic>.from(
                                                            homeController
                                                                .slotAddList),
                                                    context: context,
                                                  );
                                                });
                        }),
                      ),
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/layer.svg",
                                  height: Get.height * 0.028,
                                  color: AppColor.primaryColor,
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                AppText(
                                  title: _selectedItem == null
                                      ? province.tr
                                      : _selectedItem.toString(),
                                  size: 16,
                                  fontFamily: AppFont.medium,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.only(right: Get.width * 0.0),
                              child: SizedBox(
                                height: Get.put(AuthController())
                                        .provinceList
                                        .isEmpty
                                    ? Get.height * 0.055
                                    : Get.height * 0.055,
                                child: PopupMenuButton(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  offset: const Offset(0, 55),
                                  onSelected: (value) async {
                                    setState(() {
                                      homeController.getSlotData(
                                        id: value.toString(),
                                      );
                                    });
                                  },
                                  constraints: BoxConstraints(
                                      minWidth: Get.height * 0.08,
                                      maxWidth: Get.height * 0.08,
                                      maxHeight: Get.height * 0.25),
                                  itemBuilder: (BuildContext bc) {
                                    return List.generate(
                                        Get.put(AuthController())
                                            .provinceList
                                            .length, (index) {
                                      return PopupMenuItem(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          value: Get.put(AuthController())
                                              .provinceList[index]
                                              .id
                                              .toString(),
                                          child: AppText(
                                            title: Get.put(AuthController())
                                                .provinceList[index]
                                                .name
                                                .toString(),
                                            size: AppSizes.size_13,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: AppFont.medium,
                                            color: AppColor.blackColor,
                                          ));
                                    });
                                  },
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/filter.png",
                                    ),
                                  ),
                                ),
                              ),
                            )
                            // Padding(
                            //   padding: EdgeInsets.only(right: Get.width * 0.02),
                            //   child: SizedBox(
                            //     height: Get.height * 0.045,
                            //     width: Get.height * 0.07,
                            //     child: ButtonTheme(
                            //         alignedDropdown: true,
                            //         materialTapTargetSize:
                            //             MaterialTapTargetSize.padded,
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(10)),
                            //         child: Obx(() {
                            //           return DropdownButton(
                            //             value: provinceId,
                            //             menuMaxHeight: Get.height * 0.3,
                            //             isExpanded: true,
                            //             isDense: true,
                            //             icon: SvgPicture.asset(
                            //               "assets/icons/fil.svg",
                            //               height: Get.height * 0.023,
                            //               color: AppColor.grey3Color,
                            //             ), // Specify the icon here
                            //             iconSize: Get.height * 0.05,
                            //             elevation:
                            //             Get.put(AuthController()).provinceList.isEmpty ? 16 : 16,
                            //             underline: Container(),
                            //             style: const TextStyle(color: Colors.black),
                            //             onChanged: (value) async {
                            //               setState(() {
                            //                 homeController.getSlotData(
                            //                   id: value.toString(),
                            //                 );
                            //
                            //                 for (int i = 0;
                            //                     i < Get.put(AuthController()).provinceList.length;
                            //                     i++) {
                            //                   setState(() {
                            //                     if (Get.put(AuthController()).provinceList[i].id ==
                            //                         value) {
                            //                       _selectedItem =
                            //                           Get.put(AuthController()).provinceList[i].name;
                            //                     }
                            //                   });
                            //                 }
                            //               });
                            //             },
                            //
                            //             items: countryDataList1(
                            //                 dataList: Get.put(AuthController()).provinceList),
                            //           );
                            //         })),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                        child: Obx(() {
                          return (homeController.isLoading.value
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.03,
                                    ),
                                    const Center(
                                        child: SpinKitThreeBounce(
                                            size: 25,
                                            color: AppColor.primaryColor)),
                                  ],
                                )
                              : homeController.getSlot.isNotEmpty
                                  ? GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      primary: false,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  homeController.getSlot.isEmpty
                                                      ? 5
                                                      : 5,
                                              childAspectRatio:
                                                  Get.width / Get.width * 1.2,
                                              crossAxisSpacing: 6,
                                              mainAxisSpacing: 16),
                                      itemCount: homeController.getSlot.length,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return GestureDetector(
                                            onTap: homeController.getSlot[index]
                                                        .isScratch ==
                                                    true
                                                ? () {
                                                    print(homeController
                                                        .getSlot[index].id
                                                        .toString());

                                                    // Get.generalDialog(
                                                    //     pageBuilder: (context, __, ___) =>
                                                    //         AlertDialog(
                                                    //           shape: RoundedRectangleBorder(
                                                    //             borderRadius: BorderRadius.circular(40), // Customize the border radius
                                                    //           ),
                                                    //
                                                    //
                                                    //           content: SizedBox(
                                                    //             height: Get.height*0.35,
                                                    //             width: Get.width*0.55,
                                                    //             child: Column(
                                                    //               crossAxisAlignment: CrossAxisAlignment.start,
                                                    //               children: [
                                                    //
                                                    //                 Center(
                                                    //                   child: AppText(
                                                    //                     title:"Scratch Coupon!",
                                                    //                     size: 16,
                                                    //                     fontFamily:
                                                    //                     AppFont.semi,
                                                    //                     fontWeight:
                                                    //                     FontWeight.w600,
                                                    //                     color: Colors.black,
                                                    //                   ),
                                                    //                 ),
                                                    //                 SizedBox(height: Get.height*0.03,),
                                                    //                 SizedBox(
                                                    //                   height: Get.height * 0.2,
                                                    //                   child: Center(
                                                    //                     child: Scratcher(
                                                    //                       brushSize: 50, // Adjust the brush size as needed
                                                    //                       threshold: 40, // Adjust the threshold as needed
                                                    //                       color: AppColor.primaryColor, // Initial scratch card color
                                                    //                       image: Image.asset('assets/images/scratch.png'), // Custom brush image
                                                    //                       onChange: (value) {
                                                    //                         if (value >= 1.0 && !isScratched) {
                                                    //                           setState(() {
                                                    //                             isScratched = true; // Scratch threshold reached
                                                    //                           });
                                                    //                         }
                                                    //                         print("Scratch progress: ${value * 100}%");
                                                    //                       },
                                                    //                       child: Container(
                                                    //                           width: 300,
                                                    //                           height: 200,
                                                    //                           alignment: Alignment.center,
                                                    //                           decoration: BoxDecoration(
                                                    //                             color: AppColor.primaryColor, // Content revealed
                                                    //                             borderRadius: BorderRadius.circular(10),
                                                    //                             // boxShadow: isScratched
                                                    //                             //     ? [] // No shadow when content is revealed
                                                    //                             //     : [BoxShadow(blurRadius: 10, color: Colors.grey)], // Add a blurred effect
                                                    //                           ),
                                                    //                           child: Column(
                                                    //                             crossAxisAlignment: CrossAxisAlignment.center,
                                                    //                             mainAxisAlignment: MainAxisAlignment.center,
                                                    //                             children: [
                                                    //
                                                    //                               AppText(
                                                    //                                 title:homeController.getSlot[index].code.toString(),
                                                    //                                 size: 17,
                                                    //                                 fontFamily:
                                                    //                                 AppFont.bold,
                                                    //                                 fontWeight:
                                                    //                                 FontWeight.w800,
                                                    //                                 color: Colors.white,
                                                    //                               ),
                                                    //                               SizedBox(height: Get.height*0.015,),
                                                    //                               Image.asset("assets/images/sca.png",
                                                    //                                 height: Get.height*0.1,
                                                    //                               )
                                                    //                             ],
                                                    //                           )
                                                    //                       ),
                                                    //                     ),
                                                    //                   ),
                                                    //                 ),
                                                    //                 SizedBox(height: Get.height*0.03,),
                                                    //                 Padding(
                                                    //                   padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                                                    //                   child: AppButton(
                                                    //                     buttonName: "Cancel",
                                                    //                     buttonColor: AppColor.primaryColor,
                                                    //                     textColor: AppColor.whiteColor,
                                                    //                     onTap: () {
                                                    //                       Get.back();
                                                    //                     },
                                                    //                     buttonHeight: Get.height * 0.055,
                                                    //                     buttonWidth: Get.width,
                                                    //                     fontFamily: AppFont.medium,
                                                    //                     textSize: 17,
                                                    //                     buttonRadius: BorderRadius.circular(30),
                                                    //                   ),
                                                    //                 ),
                                                    //               ],
                                                    //             ),
                                                    //           ),
                                                    //
                                                    //         ));
                                                    showModalBottomSheet(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        isScrollControlled:
                                                            true,
                                                        isDismissible: true,
                                                        context: context,
                                                        builder: (context) =>
                                                            SlotTrue(
                                                              id: homeController
                                                                  .getSlot[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              code: homeController
                                                                  .getSlot[
                                                                      index]
                                                                  .code
                                                                  .toString(),
                                                            ));
                                                  }
                                                : () {
                                                    print(homeController
                                                        .getSlot[index].id
                                                        .toString());
                                                    ApiManger().slotVView(
                                                        id: homeController
                                                            .getSlot[index].id
                                                            .toString());

                                                    showModalBottomSheet(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        isScrollControlled:
                                                            true,
                                                        isDismissible: true,
                                                        context: context,
                                                        builder: (context) =>
                                                            SlotView(
                                                              id: homeController
                                                                  .getSlot[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              code: homeController
                                                                  .getSlot[
                                                                      index]
                                                                  .code
                                                                  .toString(),
                                                            ));
                                                  },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: homeController
                                                            .getSlot[index]
                                                            .isScratch ==
                                                        true
                                                    ? AppColor.primaryColor
                                                        .withOpacity(0.25)
                                                    : Color(0xfffa7175),
                                              ),
                                              child: const Padding(
                                                  padding: EdgeInsets.all(18.0),
                                                  child: Icon(
                                                    Icons.shopping_cart,
                                                    color: AppColor.grey3Color,
                                                    size: 25,
                                                  )),
                                            ));
                                      })
                                  : noData(height: Get.height * 0));
                        }),
                      ),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                    ],
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
