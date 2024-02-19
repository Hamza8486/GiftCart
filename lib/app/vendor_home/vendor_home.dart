
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mr_bet/app/bottom_tabs/scanner.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_text.dart';

import '../../util/translation_keys.dart';
import 'vendor_tabs/vendor_dashboard/component/payments.dart';
import 'vendor_tabs/vendor_dashboard/view/new_dashboard.dart';
import 'vendor_tabs/vendor_dashboard/view/vend_dash.dart';


class VendorHome extends StatefulWidget {
  VendorHome({super.key,this.currentTab=0});
  int currentTab ;


  @override
  _VendorHomeState createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  final vendorController = Get.put(VendorController());
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = VendorNewDashboard(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        child: Image.asset("assets/images/sc.png",
        height: 94,
          width: 94,
        ),
        onPressed: () {
          setState(() {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                isDismissible: true,
                context: context,
                builder: (context) =>   MyCode());

            widget.currentTab  = 1;
          });

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        shape: CircularNotchedRectangle(),
        notchMargin: 2,
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(26),
            topRight: Radius.circular(26)
            ),
            gradient: AppColor.Home_GRADIENT
          ),
          height: Get.height*0.08,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MaterialButton(
                  minWidth: 70,
                  onPressed: () {
                    setState(() {
                      currentScreen =
                          VendorNewDashboard(); // if user taps on this dashboard tab will be active
                      widget.currentTab = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/icons/home1.png",height: Get.height*0.027,
                        color:
                        widget.currentTab  == 0 ?AppColor.whiteColor:
                        AppColor.whiteColor,),
                      SizedBox(height: 5,),
                      AppText(
                        title: home.tr,
                        size: 10,
                        fontFamily: AppFont.medium,
                        fontWeight: FontWeight.w400,
                        color:
                        widget.currentTab  == 0 ?AppColor.whiteColor:
                        AppColor.whiteColor,
                      ),

                    ],
                  ),
                ),



                MaterialButton(
                  minWidth: 70,
                  onPressed: () {
                    setState(() {
                      currentScreen =
                          PaymentsView(); // if user taps on this dashboard tab will be active
                      widget.currentTab  = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/icons/paymen1.png",height: Get.height*0.027,
                        color:
                        widget.currentTab  == 2 ?AppColor.whiteColor:
                        AppColor.whiteColor,
                      ),
                      SizedBox(height: 5,),
                      AppText(
                        title: payments.tr,
                        size:10,
                        fontFamily: AppFont.medium,
                        fontWeight: FontWeight.w400,
                        color:
                        widget.currentTab  == 2 ?AppColor.whiteColor:
                        AppColor.whiteColor,
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
