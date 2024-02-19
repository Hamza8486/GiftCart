
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/view/dashboard_view.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/claim_view.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/game_mannual.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/testmonials.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/winners.dart';
import 'package:mr_bet/app/bottom_tabs/profile/view/profile_view.dart';
import 'package:mr_bet/app/bottom_tabs/scanner.dart';
import 'package:mr_bet/app/bottom_tabs/statastic/view/stats_view.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/component/dragable_sheet.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';

import '../../util/translation_keys.dart';


class Home extends StatefulWidget {
   Home({super.key,this.currentTab=0});
  int currentTab ;


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 final homeController = Get.put(HomeController());
  // Properties & Variables needed

   // to keep track of active tab index
  final List<Widget> screens = [
    MyHomePage(),
    Winners(),
    StatsView(),

    ProfileView(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = MyHomePage();
 void showWinSlotDataBottomSheet(BuildContext context) {
   showModalBottomSheet(
     backgroundColor: Colors.transparent,
     isScrollControlled: true,
     isDismissible: true,
     context: context,
     builder: (context) => WinSlotData(),
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
     if (message.data["notification_type"] == "Claim") {
       // Update the flag in the controller
       Get.put(HomeController()).updatePopup(true);
       // Show the bottom sheet
       showWinSlotDataBottomSheet(context);
     }

     // Call methods or update UI based on the message
   });
 }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
        color: AppColor.primaryColor.withOpacity(0.25)
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: FloatingActionButton(
            backgroundColor: AppColor.primaryColor,
            child: Image.asset("assets/images/scans.png",height: Get.height*0.03,),
            onPressed: () {
              setState(() {
                currentScreen =
                    ScanQrPage(); // if user taps on this dashboard tab will be active
                widget.currentTab  = 4;
              });

            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 2,
        child: Container(
          height: Get.height*0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 70,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            MyHomePage(); // if user taps on this dashboard tab will be active
                       widget.currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/home.png",height: Get.height*0.027,
                          color:
                          widget.currentTab  == 0 ?AppColor.primaryColor:
                          AppColor.tabColor,),
                        SizedBox(height: 5,),
                        AppText(
                          title: home.tr,
                          size: AppSizes.size_11,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w400,
                          color:
                          widget.currentTab  == 0 ?AppColor.primaryColor:
                          AppColor.tabColor,
                        ),

                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 85,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Testimonials(); // if user taps on this dashboard tab will be active
                        widget.currentTab  = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/test.png",height: Get.height*0.027,
                          color:
                          widget.currentTab  == 1 ?AppColor.primaryColor:
                          AppColor.tabColor,
                        ),
                        SizedBox(height: 5,),
                        AppText(
                          title: testimonimals.tr,
                          size: AppSizes.size_11,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w400,
                          color:
                          widget.currentTab  == 1 ?AppColor.primaryColor:
                          AppColor.tabColor,
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
                      setState(() {
                        currentScreen =
                            StatsView(); // if user taps on this dashboard tab will be active
                        widget.currentTab  = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/stat.png",height: Get.height*0.027,
                          color:
                          widget.currentTab  == 2 ?AppColor.primaryColor:
                          AppColor.tabColor,
                        ),
                        SizedBox(height: 5,),
                        AppText(
                          title: stats.tr,
                          size: AppSizes.size_11,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w400,
                          color:
                          widget.currentTab  == 2 ?AppColor.primaryColor:
                          AppColor.tabColor,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 85,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Winners(); // if user taps on this dashboard tab will be active
                        widget.currentTab  = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/winner.png",height: Get.height*0.027,
                          color:
                          widget.currentTab  == 3 ?AppColor.primaryColor:
                          AppColor.tabColor,
                        ),
                        SizedBox(height: 5,),
                        AppText(
                          title: winner.tr,
                          size: AppSizes.size_11,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w400,
                          color:
                          widget.currentTab  == 3 ?AppColor.primaryColor:
                          AppColor.tabColor,
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
    );
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
    Future.delayed(Duration(seconds:6), () {
      // Set the visibility to true after 10 seconds
      setState(() {
        isVisible = true;
      });

      // Start another delayed timer to hide the widget after 3 more seconds (totaling 13 seconds)
      Future.delayed(Duration(seconds: 3), () {
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
    Future.delayed(Duration(seconds: 18), () {
      // Close the bottom sheet after 20 seconds
      Get.back();
      Get.put(HomeController()).updatePopup(false);
    });

  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.9,
      maxChildSize: 0.9,
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


              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(10
                    ),
                    child
                        : Image.asset(
                      "assets/fonts/4.gif",
                      height: 600,
                      fit: BoxFit.cover
                      ,
                      width: Get.width,

                    ),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:
                          130,
                          top: 18
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Obx(
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
                                          height: 82,
                                          width: 82,
                                          errorWidget: (context, url, error) => ClipRRect(
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
                                    }
                                ),
                              ),
                              SizedBox(height: 35,),
                              Obx(
                                () {
                                  return

                                    AppText(
                                    title:Get.put(HomeController()).name.value,
                                    size:
                                    Get.put(HomeController()).image.value.isEmpty?15:
                                    15,
                                    fontFamily: AppFont.medium,
                                    fontWeight: FontWeight.w600,
                                    color:AppColor.blackColor,
                                  );
                                }
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              isShowButton?
              AppButton(
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
                    Get.to(ClaimView(), transition: Transition.rightToLeft);
                  }):SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}