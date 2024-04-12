import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/view/dashboard_view.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/claim_view.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/testmonials.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/winners.dart';
import 'package:giftcart/app/bottom_tabs/profile/view/profile_view.dart';
import 'package:giftcart/app/bottom_tabs/scanner.dart';
import 'package:giftcart/app/bottom_tabs/statastic/view/stats_view.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/widgets/app_button.dart';
import 'package:giftcart/widgets/app_text.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../util/translation_keys.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeController = Get.put(HomeController());

  // Properties & Variables needed

  // to keep track of active tab index
  final List<Widget> screens = [
    MyHomePage(),
    Testimonials(),
    StatsView(),
    Winners(),
    ScanQrPage(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();

  // Widget currentScreen = ShowCaseWidget(
  //   builder: Builder(
  //     builder: (context) => MyHomePage(),
  //   ),
  // );

  void showWinSlotDataBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) => WinSlotData(),
    );
  }

  void showWinSlotOtherDataBottomSheet(
      {required BuildContext context, String user = ""}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) => OtherUserWin(
        user: user,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Check if the notification flag is true

    // Handle Firebase messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Received... ${message.data.toString()}");
      // Check if the notification type is "Claim"
      // if (message.data["notification_type"] == "Claim") {
      //   // Update the flag in the controller
      //   Get.put(HomeController()).updatePopup(true);
      //   // Show the bottom sheet
      //   showWinSlotDataBottomSheet(context);
      // }
      // if (message.data["notification_type"] == "Reward") {
      //   // Update the flag in the controller
      //   Get.put(HomeController()).updatePopup(true);
      //   // Show the bottom sheet
      //   showWinSlotOtherDataBottomSheet(context: context,user:message.data["text"].toString().split(' ').first );
      // }

      // Call methods or update UI based on the message
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: PageStorage(
            child: ShowCaseWidget(
              builder: Builder(
                builder: (context) => screens[homeController.currentTab.value],
              ),
            ),
            bucket: bucket,
          ),
          floatingActionButton: Container(
            width: 80,
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     color: AppColor.whiteColor),
            child:InkWell(
              onTap: () {
                homeController.currentTab.value = 4;
                // setState(() {
                //   currentScreen = ShowCaseWidget(
                //     builder: Builder(
                //       builder: (context) => ScanQrPage(),
                //     ),
                //   );
                //   // if user taps on this dashboard tab will be active
                //   widget.currentTab = 4;
                // });
              },
              child: Image.asset(
                "assets/icons/ic_scanner.png",

              ),
            ),
            // child: FloatingActionButton(
            //   // backgroundColor: AppColor.primaryColor,
            //   child: Image.asset(
            //     "assets/icons/ic_scanner.png",
            //     height: Get.height * 0.03,
            //   ),
            //   onPressed: () {
            //     homeController.currentTab.value = 4;
            //     // setState(() {
            //     //   currentScreen = ShowCaseWidget(
            //     //     builder: Builder(
            //     //       builder: (context) => ScanQrPage(),
            //     //     ),
            //     //   );
            //     //   // if user taps on this dashboard tab will be active
            //     //   widget.currentTab = 4;
            //     // });
            //   },
            // ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: AppColor.whiteColor,
            shadowColor: AppColor.whiteColor,
            surfaceTintColor: AppColor.whiteColor,
            shape: CircularNotchedRectangle(),
            notchMargin: 2,
            child: Container(
              height: Get.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MaterialButton(
                        minWidth: 70,
                        onPressed: () {
                          homeController.currentTab.value = 0;
                          // setState(() {
                          //   currentScreen = ShowCaseWidget(
                          //     builder: Builder(
                          //       builder: (context) => MyHomePage(),
                          //     ),
                          //   ); // if user taps on this dashboard tab will be active
                          //   widget.currentTab = 0;
                          //   homeController.getProvDataData();
                          // });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/home.png",
                              height: Get.height * 0.027,
                              color: homeController.currentTab.value == 0
                                  ? AppColor.primaryColor
                                  : AppColor.tabColor,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            AppText(
                              title: home.tr,
                              size: AppSizes.size_11,
                              fontFamily: AppFont.medium,
                              fontWeight: FontWeight.w400,
                              color: homeController.currentTab.value == 0
                                  ? AppColor.primaryColor
                                  : AppColor.tabColor,
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 85,
                        onPressed: () {
                          homeController.currentTab.value = 1;
                          // setState(() {
                          //   currentScreen = ShowCaseWidget(
                          //     builder: Builder(
                          //       builder: (context) => Testimonials(),
                          //     ),
                          //   );
                          //   // if user taps on this dashboard tab will be active
                          //   widget.currentTab = 1;
                          // });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/test.png",
                              height: Get.height * 0.027,
                              color: homeController.currentTab.value == 1
                                  ? AppColor.primaryColor
                                  : AppColor.tabColor,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            AppText(
                              title: testimonimals.tr,
                              size: AppSizes.size_11,
                              fontFamily: AppFont.medium,
                              fontWeight: FontWeight.w400,
                              color: homeController.currentTab.value == 1
                                  ? AppColor.primaryColor
                                  : AppColor.tabColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MaterialButton(
                        minWidth: 70,
                        onPressed: () {
                          homeController.currentTab.value = 2;
                          // setState(() {
                          //   currentScreen = ShowCaseWidget(
                          //     builder: Builder(
                          //       builder: (context) => StatsView(),
                          //     ),
                          //   );
                          //   // if user taps on this dashboard tab will be active
                          //   widget.currentTab = 2;
                          // });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/stat.png",
                              height: Get.height * 0.027,
                              color: homeController.currentTab.value == 2
                                  ? AppColor.primaryColor
                                  : AppColor.tabColor,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            AppText(
                              title: stats.tr,
                              size: AppSizes.size_11,
                              fontFamily: AppFont.medium,
                              fontWeight: FontWeight.w400,
                              color: homeController.currentTab.value == 2
                                  ? AppColor.primaryColor
                                  : AppColor.tabColor,
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 85,
                        onPressed: () {
                          homeController.currentTab.value = 3;
                          // setState(() {
                          //   currentScreen = ShowCaseWidget(
                          //     builder: Builder(
                          //       builder: (context) => Winners(),
                          //     ),
                          //   ); // if user taps on this dashboard tab will be active
                          //   widget.currentTab = 3;
                          //   print("dskgvbdhbhjdc");
                          // });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/winner.png",
                              height: Get.height * 0.027,
                              color: homeController.currentTab.value == 3
                                  ? AppColor.primaryColor
                                  : AppColor.tabColor,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            AppText(
                              title: winner.tr,
                              size: AppSizes.size_11,
                              fontFamily: AppFont.medium,
                              fontWeight: FontWeight.w400,
                              color: homeController.currentTab.value == 3
                                  ? AppColor.primaryColor
                                  : AppColor.tabColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class WinSlotData extends StatefulWidget {
  WinSlotData({super.key});

  @override
  State<WinSlotData> createState() => _WinSlotDataState();
}

class _WinSlotDataState extends State<WinSlotData> {
  bool isVisible = false;
  bool isShowButton = false;

  @override
  void initState() {
    super.initState();
    // Start a delayed timer to show the widget after 10 seconds
    Future.delayed(Duration(seconds: 6), () {
      // Set the visibility to true after 10 seconds
      setState(() {
        isVisible = true;
      });

      // Start another delayed timer to hide the widget after 3 more seconds (totaling 13 seconds)
      Future.delayed(Duration(seconds: 2), () {
        // Set the visibility to false after 3 more seconds
        setState(() {
          isVisible = false;
        });
      });
    });
    Future.delayed(Duration(seconds: 5), () {
      // Set the visibility to false after 3 more seconds
      setState(() {
        isShowButton = true;
      });
    });
    Future.delayed(Duration(seconds: 30), () {
      // Close the bottom sheet after 20 seconds
      Get.back();
      Get.put(HomeController()).updatePopup(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.95,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.transParent,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColor.primaryColor, width: 2)),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/fonts/1.gif",
                      height: Get.height * 0.69,
                      fit: BoxFit.cover,
                      width: Get.width,
                    ),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.33, top: Get.height * 0.018),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.01,
                                ),
                                child: Obx(() {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => Center(
                                          child: SpinKitThreeBounce(
                                              size: 16,
                                              color: AppColor.primaryColor)),
                                      imageUrl:
                                          Get.put(HomeController()).image.value,
                                      fit: Get.put(HomeController())
                                              .image
                                              .value
                                              .isEmpty
                                          ? BoxFit.cover
                                          : BoxFit.cover,
                                      height: 82,
                                      width: 82,
                                      errorWidget: (context, url, error) =>
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.asset(
                                          "assets/images/persons.jpg",
                                          fit: BoxFit.cover,
                                          height: 82,
                                          width: 82,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Obx(() {
                                return AppText(
                                  title: Get.put(HomeController()).name.value,
                                  size: Get.put(HomeController())
                                          .image
                                          .value
                                          .isEmpty
                                      ? 15
                                      : 15,
                                  fontFamily: AppFont.medium,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.blackColor,
                                );
                              }),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              isShowButton
                  ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppButton(
                                buttonWidth: Get.width,
                                buttonRadius: BorderRadius.circular(10),
                                buttonName: 'Claim Now',
                                gard: true,
                                fontWeight: FontWeight.w600,
                                textSize: 16,
                                buttonColor: AppColor.primaryColor,
                                textColor: AppColor.whiteColor,
                                onTap: () {
                                  Get.back();
                                  Get.put(HomeController()).updatePopup(false);
                                  Get.to(ClaimView(),
                                      transition: Transition.rightToLeft);
                                }),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class OtherUserWin extends StatefulWidget {
  OtherUserWin({super.key, this.user = ""});

  String user;

  @override
  State<OtherUserWin> createState() => _OtherUserWinState();
}

class _OtherUserWinState extends State<OtherUserWin> {
  bool isVisible = false;
  bool isShowButton = false;

  @override
  void initState() {
    super.initState();
    // Start a delayed timer to show the widget after 10 seconds
    Future.delayed(Duration(seconds: 6), () {
      // Set the visibility to true after 10 seconds
      setState(() {
        isVisible = true;
      });

      // Start another delayed timer to hide the widget after 3 more seconds (totaling 13 seconds)
      Future.delayed(Duration(seconds: 2), () {
        // Set the visibility to false after 3 more seconds
        setState(() {
          isVisible = false;
        });
      });
    });
    Future.delayed(Duration(seconds: 5), () {
      // Set the visibility to false after 3 more seconds
      setState(() {
        isShowButton = true;
      });
    });
    Future.delayed(Duration(seconds: 30), () {
      // Close the bottom sheet after 20 seconds
      Get.back();
      Get.put(HomeController()).updatePopup(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.95,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.transParent,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColor.primaryColor, width: 2)),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/fonts/1.gif",
                      height: Get.height * 0.69,
                      fit: BoxFit.cover,
                      width: Get.width,
                    ),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.33, top: Get.height * 0.018),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.01,
                                ),
                                child: Obx(() {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => Center(
                                          child: SpinKitThreeBounce(
                                              size: 16,
                                              color: AppColor.primaryColor)),
                                      imageUrl:
                                          Get.put(HomeController()).image.value,
                                      fit: Get.put(HomeController())
                                              .image
                                              .value
                                              .isEmpty
                                          ? BoxFit.cover
                                          : BoxFit.cover,
                                      height: 82,
                                      width: 82,
                                      errorWidget: (context, url, error) =>
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.asset(
                                          "assets/images/persons.jpg",
                                          fit: BoxFit.cover,
                                          height: 82,
                                          width: 82,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Obx(() {
                                return AppText(
                                  title: widget.user,
                                  size: Get.put(HomeController())
                                          .image
                                          .value
                                          .isEmpty
                                      ? 15
                                      : 15,
                                  fontFamily: AppFont.medium,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.blackColor,
                                );
                              }),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
