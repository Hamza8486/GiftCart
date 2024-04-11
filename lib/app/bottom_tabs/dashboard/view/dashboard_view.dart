import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/auth/component.dart';
import 'package:giftcart/app/auth/controller.dart';
import 'package:giftcart/app/bottom_tabs/component/drawer.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/component/wallet.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/model/slot_model.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/notification_view.dart';
import 'package:giftcart/app/bottom_tabs/wallet/view/wallet_view.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';
import 'package:giftcart/services/api_manager.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/util/toast.dart';
import 'package:giftcart/util/translation_keys.dart';
import 'package:giftcart/widgets/app_button.dart';
import 'package:giftcart/widgets/app_text.dart';
import 'package:giftcart/widgets/helper_function.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scratcher/scratcher.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current = 1;
  List<String> bannerList = [
    'assets/images/banner9.png',
    'assets/images/banner10.png',
    'assets/images/banner11.png',
  ];
  String nameValue = "";

  final CarouselController _controller = CarouselController();

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
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> target = [];

  void show_tutorialcochmark() {
    _inittaget();
    tutorialCoachMark = TutorialCoachMark(targets: target, hideSkip: true)
      ..show(context: context);
  }

  void _inittaget() {
    target = [
      TargetFocus(identify: "wallet-key", keyTarget: walletKey, contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return Cochmarkdesc(
              text: "Monitor your app balance or any gift card\nbalance here.",
              onnext: () {
                controller.next();
              },
              onskip: () {
                controller.skip();
              },
            );
          },
        )
      ]),
      TargetFocus(identify: "languageKey", keyTarget: languageKey, contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return Cochmarkdesc(
              onskip: () {
                controller.skip();
              },
              text:
                  "Customize your app experience by choosing your preferred language.",
              onnext: () {
                controller.next();
              },
            );
          },
        )
      ]),
      TargetFocus(
          identify: "notificationKey",
          keyTarget: notificationKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return Cochmarkdesc(
                  onskip: () {
                    controller.skip();
                  },
                  text:
                      "Stay informed with notifications about slot selections.",
                  onnext: () {
                    controller.next();
                  },
                );
              },
            )
          ]),
      TargetFocus(
          identify: "widget.provinceKey",
          keyTarget: provinceKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return Cochmarkdesc(
                  onskip: () {
                    controller.skip();
                  },
                  text:
                      "Select your province to join in the slot selection process.",
                  onnext: () {
                    controller.next();
                  },
                );
              },
            )
          ]),
      TargetFocus(identify: "slotKey", keyTarget: slotKey, contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return Cochmarkdesc(
              onskip: () {
                controller.skip();
              },
              text: "Select a slot from the available options.",
              onnext: () {
                controller.next();
              },
            );
          },
        )
      ]),
      TargetFocus(identify: "timer", keyTarget: timerKey, contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return Cochmarkdesc(
              onskip: () {
                controller.skip();
              },
              text:
                  "A countdown timer displays the time remaining until the slot selection.",
              onnext: () {
                controller.next();
                homeController.currentTab.value = 1;
                // Navigator.pushReplacement(context, MaterialPageRoute(
                //   builder: (context) {
                //     return Home(currentTab: 4);
                //   },
                // ));
              },
            );
          },
        )
      ])
    ];
  }

  @override
  void initState() {
    super.initState();

    HelperFunctions.getFromPreference("home").then((value) {
      nameValue = value;
      print(nameValue.toString());
      if (value == "value4") {
      } else {
        HelperFunctions.saveInPreference("home", "value4");
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          show_tutorialcochmark();
        });
      }
    });

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

  String? provinceName;

  final GlobalKey walletKey = GlobalKey();
  final GlobalKey languageKey = GlobalKey();
  final GlobalKey notificationKey = GlobalKey();
  final GlobalKey provinceKey = GlobalKey();
  final GlobalKey slotKey = GlobalKey();
  final GlobalKey timerKey = GlobalKey();

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
                                  homeController.getProfileData();
                                  homeController.getSlotHis();
                                  Get.to(const NewWalletView(),
                                      transition: Transition.rightToLeft);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset(
                                    key: walletKey,
                                    "assets/images/wallets.png",
                                    height: 26,
                                    width: 26,
                                  ),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset(
                                    key: languageKey,
                                    "assets/images/lang.png",
                                    height: 26,
                                    width: 26,
                                  ),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Image.asset(
                                    key: notificationKey,
                                    "assets/icons/not.png",
                                    height: 28,
                                    width: 28,
                                  ),
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
                            reverse: false,
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
          DraggableSheet(
            provinceKey: provinceKey,
            slotKey: slotKey,
            timerKey: timerKey,
          ),
        ],
      ),
    );
  }
}

class DraggableSheet extends StatefulWidget {
  GlobalKey provinceKey = GlobalKey();
  GlobalKey slotKey = GlobalKey();
  GlobalKey timerKey = GlobalKey();

  DraggableSheet({
    super.key,
    required this.provinceKey,
    required this.slotKey,
    required this.timerKey,
  });

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
                                                    onTap: () {
                                                      print("object");
                                                      print("object");
                                                      print("object");
                                                      print("object");
                                                      print(item.website
                                                          .toString());
                                                    },
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
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              1000),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl: item
                                                                            .image
                                                                            .toString(),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        width:
                                                                            62,
                                                                        height:
                                                                            44,
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(1000),
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/logo_man.png",
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            width:
                                                                                62,
                                                                            height:
                                                                                44,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 6,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          125,
                                                                      child:
                                                                          Text(
                                                                        item.title
                                                                            .toString(),
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: GoogleFonts.italianno(
                                                                            textStyle: TextStyle(
                                                                                color: AppColor.blackColor,
                                                                                fontSize: 24,
                                                                                fontWeight: FontWeight.w500)),
                                                                      ),
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
                                                                    // SizedBox(
                                                                    //   width: 5,
                                                                    // ),
                                                                    // AppText(
                                                                    //   title:
                                                                    //       onAllOrders
                                                                    //           .tr,
                                                                    //   size: 11,
                                                                    //   fontWeight:
                                                                    //       FontWeight
                                                                    //           .w400,
                                                                    //   color: AppColor
                                                                    //       .blackColor,
                                                                    // ),
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
                                                                          launch(
                                                                              "http://${item.website.toString()}");
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              32,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              border: Border.all(color: AppColor.primaryColor)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 10),
                                                                            child:
                                                                                Center(
                                                                              child: AppText(
                                                                                title: visitWebsite.tr,
                                                                                size: 14,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: AppColor.primaryColor,
                                                                              ),
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
                                  : SizedBox.shrink();
                        }),
                      ),
                      Obx(() {
                        return Get.put(AuthController())
                                .getAllAdsList
                                .isNotEmpty
                            ? SizedBox(
                                height: 20,
                              )
                            : SizedBox.shrink();
                      }),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Obx(() {
                          return homeController.listLoader.value
                              ? Center(
                                  child: SpinKitThreeBounce(
                                      size: 25, color: AppColor.primaryColor))
                              : homeController.getProvUserList.isEmpty
                                  ? SizedBox.shrink()
                                  : SizedBox(
                                      height: 20,
                                      child: ListView.builder(
                                          itemCount: homeController
                                              .getProvUserList.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          primary: false,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return SizedBox(
                                              height: 20,
                                              width: 259,
                                              child: AppText(
                                                title:
                                                    "${homeController.getProvUserList[index].user.toString()} just bought ${homeController.getProvUserList[index].slotCount.toString()} Coupons(${homeController.getProvUserList[index].provinceName.toString()})",
                                                size: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff45A843),
                                              ),
                                            );
                                          }),
                                    );
                        }),
                      ),
                      Obx(() {
                        return homeController.getProvUserList.isEmpty
                            ? SizedBox.shrink()
                            : SizedBox(
                                height: 20,
                              );
                      }),
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
                                  key: widget.provinceKey,
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
                                  key: widget.slotKey,
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
                                                  msg: pleaseSelectProvince.tr);
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
                                    title: couponDetails.tr,
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
                                        title: balance.tr,
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
                                    key: widget.timerKey,
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
                                                title: remainingTime.tr,
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
                            EdgeInsets.symmetric(horizontal: Get.width * 0.1),
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
                                  onTap: homeController
                                              .totalAmountWallet.value ==
                                          "0"
                                      ? () {
                                          flutterToast(msg: pleaseAddAmount.tr);
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
                                  fontWeight: FontWeight.w500,
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

                                                    showModalBottomSheet(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        isScrollControlled:
                                                            true,
                                                        isDismissible: true,
                                                        context: context,
                                                        builder: (context) => SlotTrue(
                                                            id: homeController
                                                                .getSlot[index]
                                                                .id
                                                                .toString(),
                                                            code: homeController
                                                                .getSlot[index]
                                                                .code
                                                                .toString(),
                                                            name: (homeController
                                                                    .getSlot[
                                                                        index]
                                                                    .province
                                                                    ?.name)
                                                                .toString()));
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
                                                        builder: (context) => SlotView(
                                                            id: homeController
                                                                .getSlot[index]
                                                                .id
                                                                .toString(),
                                                            code: homeController
                                                                .getSlot[index]
                                                                .code
                                                                .toString(),
                                                            name: (homeController
                                                                    .getSlot[
                                                                        index]
                                                                    .province
                                                                    ?.name)
                                                                .toString()));
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
                                  : Column(children: [
                                      SizedBox(height: 0),
                                      Image.asset(
                                        "assets/icons/cloud.png",
                                        height: 40,
                                        width: 40,
                                      ),
                                      SizedBox(height: Get.height * 0.01),
                                      Center(
                                          child: AppText(
                                        title:
                                            "No coupons available.\nTime to grab.",
                                        size: 14,
                                        color: AppColor.greyLightColor2,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w500,
                                      )),
                                      SizedBox(height: Get.height * 0.01),
                                    ]));
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

class SlotView extends StatefulWidget {
  SlotView({super.key, this.id = "", this.code = "", this.name = ""});

  String id;

  String code;
  String name;

  @override
  State<SlotView> createState() => _SlotViewState();
}

class _SlotViewState extends State<SlotView> {
  bool isScratched = false;

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return DraggableScrollableSheet(
      initialChildSize: isKeyBoard ? 0.99 : 0.99,
      minChildSize: isKeyBoard ? 0.99 : 0.99,
      maxChildSize: 0.99,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.2,
              ),
              Container(
                height: 320,
                width: 320,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height:
                          isScratched ? Get.height * 0.045 : Get.height * 0.04,
                    ),
                    AppText(
                      title: scratchCoupon.tr,
                      size: 15,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                    isScratched
                        ? SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 65),
                            child: Divider(
                              color: Colors.black.withOpacity(0.2),
                              thickness: 1.5,
                            ),
                          ),
                    SizedBox(
                      height:
                          isScratched ? Get.height * 0.01 : Get.height * 0.02,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.17),
                      child: Scratcher(
                        brushSize: 50,
                        // Adjust the brush size as needed
                        threshold: 40,
                        // Adjust the threshold as needed
                        color: isScratched ? Colors.transparent : Colors.grey,
                        // Initial scratch card color
                        image: Image.asset(
                          'assets/images/scratch.png',
                          height: 131,
                          width: 200,
                        ),
                        // Custom brush image
                        onChange: (value) {
                          print("This is id ${widget.id.toString()}");

                          if (value >= 1.0 && !isScratched) {
                            setState(() {
                              isScratched = true;
                            });
                          }
                          print("Scratch progress: ${value * 100}%");
                        },
                        child: Container(
                          height: isScratched ? 135 : 141,
                          width: 218,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isScratched
                                ? Colors.white
                                : Colors.transparent, // Content revealed
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: isScratched
                                ? [] // No shadow when content is revealed
                                : [
                                    const BoxShadow(
                                        blurRadius: 10, color: Colors.grey)
                                  ], // Add a blurred effect
                          ),
                          child: isScratched
                              ? Column(
                                  children: [
                                    AppText(
                                      title: widget.code.toString(),
                                      size: 22,
                                      color: AppColor.blackColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Image.asset(
                                      "assets/images/sca.png",
                                      height: 100,
                                      width: 110,
                                    )
                                  ],
                                )
                              : Text(
                                  scratchMe.tr,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: AppText(
                        title: ScratchItToGetCouponNumber.tr,
                        size: 12,
                        color: AppColor.greyLightColor2,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    isScratched
                        ? Image.asset(
                            "assets/images/sign.jpg",
                            height: 55,
                            width: 80,
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.13,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                child: AppButton(
                  buttonName: isScratched ? ok.tr : cancel.tr,
                  gard: false,
                  buttonColor: AppColor.whiteColor,
                  textColor: AppColor.blackColor.withOpacity(0.6),
                  onTap: () {
                    Get.back();
                  },
                  buttonHeight: 43,
                  buttonWidth: 331,
                  fontFamily: AppFont.medium,
                  textSize: 16,
                  buttonRadius: BorderRadius.circular(30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SlotTrue extends StatefulWidget {
  SlotTrue({super.key, this.id = "", this.code = "", this.name = ""});

  String id;
  String name;

  String code;

  @override
  State<SlotTrue> createState() => _SlotTrueState();
}

class _SlotTrueState extends State<SlotTrue> {
  bool isScratched = true;

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return DraggableScrollableSheet(
      initialChildSize: isKeyBoard ? 0.99 : 0.99,
      minChildSize: isKeyBoard ? 0.99 : 0.99,
      maxChildSize: 0.99,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.15,
              ),
              Container(
                height: 360,
                width: 330,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height:
                          isScratched ? Get.height * 0.03 : Get.height * 0.04,
                    ),
                    isScratched == true
                        ? Image.asset(
                            "assets/images/logo1.png",
                            height: 60,
                            width: 60,
                          )
                        : AppText(
                            title: "Scratch Coupon!",
                            size: 15,
                            color: isScratched
                                ? AppColor.primaryColor
                                : AppColor.blackColor,
                            fontWeight:
                                isScratched ? FontWeight.w700 : FontWeight.w600,
                          ),
                    isScratched
                        ? SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 65),
                            child: Divider(
                              color: Colors.black.withOpacity(0.2),
                              thickness: 1.5,
                            ),
                          ),
                    SizedBox(
                      height: isScratched ? 0 : Get.height * 0.02,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                      child: Scratcher(
                        brushSize: 50,
                        // Adjust the brush size as needed
                        threshold: 40,
                        // Adjust the threshold as needed
                        color: isScratched ? Colors.transparent : Colors.grey,
                        // Initial scratch card color
                        image: null,
                        // Custom brush image
                        onChange: (value) {
                          if (value >= 1.0 && !isScratched) {
                            setState(() {});
                          }
                          print("Scratch progress: ${value * 100}%");
                        },
                        child: Container(
                          height: isScratched ? 130 : 130,
                          width: isScratched ? 210 : 210,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isScratched
                                ? Colors.white
                                : Colors.transparent, // Content revealed
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: isScratched
                                ? [] // No shadow when content is revealed
                                : [
                                    const BoxShadow(
                                        blurRadius: 10, color: Colors.grey)
                                  ], // Add a blurred effect
                          ),
                          child: isScratched
                              ? Column(
                                  children: [
                                    AppText(
                                      title: widget.code.toString(),
                                      size: 22,
                                      color: AppColor.blackColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/sca.png",
                                          height: 95,
                                          width: 95,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: [
                                            AppText(
                                              title: "Province",
                                              size: 16,
                                              color: AppColor.blackColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            AppText(
                                              title: widget.name.toString(),
                                              size: 20,
                                              color: AppColor.blackColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : Text(
                                  scratchMe.tr,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 80),
                      child: Row(
                        children: [
                          AppText(
                            title: "Sr. Number : ",
                            size: 12,
                            color: AppColor.greyLightColor2,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          Row(
                            children: [
                              Text(
                                "00${widget.id.toString()}",
                                style: TextStyle(
                                  decorationColor: AppColor.blackColor,
                                  fontSize: 14,
                                  color: AppColor.greyLightColor2,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 90),
                      child: Row(
                        children: [
                          const AppText(
                            title: "Validity : ",
                            size: 12,
                            color: AppColor.greyLightColor2,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "1 Days",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.greyLightColor2,
                                      decorationColor: AppColor.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    Image.asset(
                      "assets/images/sign.jpg",
                      height: 45,
                      width: 70,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.13,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                child: AppButton(
                  buttonName: "Ok",
                  gard: false,
                  buttonColor: AppColor.whiteColor,
                  textColor: AppColor.blackColor.withOpacity(0.6),
                  onTap: () {
                    Get.back();
                  },
                  buttonHeight: 43,
                  buttonWidth: 331,
                  fontFamily: AppFont.medium,
                  textSize: 16,
                  buttonRadius: BorderRadius.circular(30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cochmarkdesc extends StatefulWidget {
  Cochmarkdesc(
      {super.key,
      required this.text,
      this.skip = "Skip",
      this.next = "Next",
      this.onnext,
      this.onskip});

  String text = "";
  String skip;
  String next;
  final void Function()? onnext;
  final void Function()? onskip;

  @override
  State<Cochmarkdesc> createState() => _CochmarkdescState();
}

class _CochmarkdescState extends State<Cochmarkdesc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Row(children: [
            Spacer(),
            // GestureDetector(
            //   onTap: widget.onskip,
            //   child: Text(
            //     'Skip',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.w500,
            //       fontSize: 14,
            //     ),
            //   ),
            // ),
            // SizedBox(width: 17),
            GestureDetector(
              onTap: widget.onnext,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
