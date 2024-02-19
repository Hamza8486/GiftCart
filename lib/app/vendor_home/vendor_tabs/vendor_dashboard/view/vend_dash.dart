import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/component/orders.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/component/partner_drawer.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/component/payments.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class VendorDashboard extends StatefulWidget {
  VendorDashboard({Key? key}) : super(key: key);

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  List<String> bannerList = [
    'assets/images/banner1.png',

    // Add more image paths as needed
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: PartnerDrawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  navBar(onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  }),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: AppText(
                      title: myStore.tr,
                      size: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColor.boldBlackColor,
                    ),
                  ),
                  Container()

                  // Padding(
                  //   padding: const EdgeInsets.only(right: 10),
                  //   child: GestureDetector(
                  //     onTap: (){
                  //       showModalBottomSheet(
                  //           backgroundColor: Colors.transparent,
                  //           isScrollControlled: true,
                  //           isDismissible: true,
                  //           context: context,
                  //           builder: (context) =>   MyCode());
                  //     },
                  //     child: Image.asset("assets/icons/bar.png",
                  //     height: 25,
                  //       width: 25,
                  //     ),
                  //   ),
                  // )
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.008,
                      ),
                      CarouselSlider(
                        carouselController: _controller,
                        options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          pageSnapping: false,
                          height: 140,
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
                          onPageChanged: (index, reason) {},
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                        ),
                        items: bannerList
                            .map((item) => GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        item.toString(),
                                        width: Get.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
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
                      Container(
                        width: Get.width,
                        height: 88,
                        decoration: BoxDecoration(
                            color: Color(0xffEBEBEB).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(
                                    title: today.tr,
                                    size: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.boldBlackColor,
                                  ),
                                  AppText(
                                    title: "10:00 AM - 11:00 PM",
                                    size: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.greyLightColor2,
                                  ),
                                ],
                              ),
                              Container(
                                height: 32,
                                width: 84,
                                decoration: BoxDecoration(
                                    gradient: AppColor.Home_GRADIENT,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: AppText(
                                    title: update.tr,
                                    size: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                              AppText(
                                                title: "\$1200",
                                                size: 16,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.whiteColor,
                                              ),
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
                                Get.to(OrdersView());
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
                                              AppText(
                                                title: "27",
                                                size: 16,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.blackColor,
                                              ),
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
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      Image.asset(
                        "assets/images/chart1.png",
                      ),
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
                      ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xffF65356).withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 13),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.03),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/icons/grocery.png",
                                                width: 30,
                                                height: 30,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.01,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Get.width * 0.017),
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
                                                            title: "Grocery",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            size: 16,
                                                            color: AppColor
                                                                .blackColor,
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.001,
                                                          ),
                                                          AppText(
                                                            title: "17 items",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            size: 12,
                                                            color: AppColor
                                                                .greyLightColor2,
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          AppText(
                                                            title: "\$300.00",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            size: 16,
                                                            color: AppColor
                                                                .blackColor,
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.001,
                                                          ),
                                                          AppText(
                                                            title: invoice.tr,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            size: 14,
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
                                              color: AppColor.primaryColor
                                                  .withOpacity(0.1)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppText(
                                                  title: allItems.tr,
                                                  fontWeight: FontWeight.w500,
                                                  size: 14,
                                                  color: AppColor.blackColor,
                                                ),
                                                Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: Colors.black,
                                                  size: 25,
                                                )
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
                          }),
                      SizedBox(
                        height: Get.height * 0.06,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class MyCode extends StatefulWidget {
  const MyCode({super.key});

  @override
  State<MyCode> createState() => _MyCodeState();
}

class _MyCodeState extends State<MyCode> {
  bool stripe = false;

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return DraggableScrollableSheet(
      initialChildSize: isKeyBoard ? 0.9 : 0.65,
      minChildSize: isKeyBoard ? 0.9 : 0.65,
      maxChildSize: isKeyBoard ? 0.9 : 0.65,
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
                height: Get.height * 0.04,
              ),
              AppText(
                  title: myQRcode.tr,
                  size: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackColor),
              SizedBox(
                height: Get.height * 0.045,
              ),
              Center(
                child: QrImageView(
                  data: (Get.put(VendorController())
                          .profileAllData
                          ?.data
                          ?.store
                          ?.slug)
                      .toString(),
                  version: QrVersions.auto,
                  size: 140.0,
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              textAuth(text: "Bar code", color: Colors.transparent),
              SizedBox(
                height: Get.height * 0.01,
              ),
              betField(
                  hint: (Get.put(VendorController())
                          .profileAllData
                          ?.data
                          ?.store
                          ?.slug)
                      .toString(),
                  max: 1,
                  isSuffix: true,
                  isCur: false,
                  isRead: true,
                  child: GestureDetector(
                    onTap: () {
                      flutterToastSuccess(msg: "Copied");
                      Clipboard.setData(ClipboardData(
                          text: (Get.put(VendorController())
                                  .profileAllData
                                  ?.data
                                  ?.store
                                  ?.slug)
                              .toString()));
                    },
                    child: Icon(
                      Icons.copy,
                      color: AppColor.primaryColor,
                      size: 20,
                    ),
                  ),
                  textInputAction: TextInputAction.done),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Share.share(
                            (Get.put(VendorController())
                                    .profileAllData
                                    ?.data
                                    ?.store
                                    ?.slug)
                                .toString(),
                            subject: 'My Payment Code');
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Icon(
                              Icons.share,
                              color: AppColor.primaryColor,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            AppText(
                                title: "Share",
                                size: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.blackColor)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Share.share(
                            (Get.put(VendorController())
                                    .profileAllData
                                    ?.data
                                    ?.store
                                    ?.slug)
                                .toString(),
                            subject: 'My Payment Code');
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Icon(
                              Icons.file_download_outlined,
                              color: AppColor.primaryColor,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            AppText(
                                title: "Download",
                                size: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.blackColor)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              AppButton(
                buttonWidth: Get.width,
                buttonRadius: BorderRadius.circular(10),
                buttonName: "Back",
                fontWeight: FontWeight.w600,
                textSize: 16,
                textColor: AppColor.whiteColor,
                onTap: () {
                  Get.back();
                },
                buttonColor: AppColor.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
