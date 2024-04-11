import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/bottom_tabs/component/drawer.dart';
import 'package:giftcart/app/bottom_tabs/component/message.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/view/dashboard_view.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/util/translation_keys.dart';
import 'package:giftcart/widgets/app_button.dart';
import 'package:giftcart/widgets/app_text.dart';
import 'package:giftcart/widgets/helper_function.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class Winners extends StatefulWidget {
  const Winners({Key? key}) : super(key: key);

  @override
  State<Winners> createState() => _WinnersState();
}

class _WinnersState extends State<Winners> {
  final homeController = Get.put(HomeController());
  final GlobalKey item = GlobalKey();
  String nameValue = "";
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> target = [];
  void show_tutorialcochmark() {
    _inittaget();
    tutorialCoachMark = TutorialCoachMark(targets: target, hideSkip: true)
      ..show(context: context);
  }

  void _inittaget() {
    target = [
      TargetFocus(identify: "item", keyTarget: item, contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return Cochmarkdesc(
              text:
                  "Discover the recipients of complimentary groceries with Gift Cart! Be inspired by their stories and see if you could be next in line for this exclusive reward!",
              onnext: () {
                controller.next();
                homeController.currentTab.value = 4;
              },
              onskip: () {
                controller.skip();
              },
            );
          },
        )
      ]),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(HomeController()).winnerList.clear();
    Get.put(HomeController()).getWinnerData();
    HelperFunctions.getFromPreference("winners").then((value) {
      nameValue = value;
      print(nameValue.toString());
      if (value == "value2") {
      } else {
        HelperFunctions.saveInPreference("winners", "value2");
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          show_tutorialcochmark();
        });
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Column(
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
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Image.asset(
                          "assets/images/menu.png",
                          height: 38,
                          key: item,
                          width: 38,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: AppText(
                          title: winner.tr,
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return Get.put(HomeController()).winnerList.isEmpty
                              ? SizedBox.shrink()
                              : SizedBox(
                                  height: Get.height * 0.17,
                                  width: Get.width,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Image.asset(
                                          "assets/images/tag9.png",
                                          height: 120,
                                          width: 105,
                                        ),
                                      ),
                                      Positioned(
                                          left: Get.width * 0.39,
                                          top: Get.height * 0.047,
                                          child: Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColor.primaryColor,
                                                    width: 1.9),
                                                shape: BoxShape.circle,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.network(
                                                    Get.put(HomeController())
                                                                .winnerList
                                                                .last
                                                                .user
                                                                ?.logo ==
                                                            null
                                                        ? ""
                                                        : Get.put(
                                                                HomeController())
                                                            .winnerList
                                                            .last
                                                            .user
                                                            ?.logo,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        exception, stackTrace) {
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Image.asset(
                                                      "assets/images/persons.jpg",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                }),
                                              )))
                                    ],
                                  ),
                                );
                        }),
                        SizedBox(
                          height: Get.height * 0.1,
                        ),
                        Obx(() {
                          return Get.put(HomeController()).winnerValue.value
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: Get.height * 0.27),
                                    Center(
                                      child: Container(
                                        height: 57,
                                        width: 57,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: AppColor.primaryColor,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                              backgroundColor: Colors.white,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      AppColor.primaryColor
                                                          .withOpacity(
                                                              0.5) //<-- SEE HERE

                                                      ),
                                              // strokeWidth: 5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Get.put(HomeController()).winnerList.isNotEmpty
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xffF65356)
                                                .withOpacity(0.1),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        child: ListView.builder(
                                            itemCount: Get.put(HomeController())
                                                .winnerList
                                                .length,
                                            shrinkWrap: true,
                                            reverse: true,
                                            padding: EdgeInsets.only(top: 10),
                                            primary: false,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              int indexNumber = index + 1;
                                              String indexString = indexNumber
                                                  .toString()
                                                  .padLeft(2, '0');
                                              return GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          backgroundColor:
                                                              AppColor
                                                                  .whiteColor,
                                                          surfaceTintColor:
                                                              AppColor
                                                                  .whiteColor,
                                                          shadowColor: AppColor
                                                              .whiteColor,
                                                          titlePadding:
                                                              EdgeInsets.zero,
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            left: Get.width *
                                                                0.05,
                                                            right: Get.width *
                                                                0.05,
                                                            top: Get.height *
                                                                0.01,
                                                            bottom: Get.height *
                                                                0.01,
                                                          ),
                                                          content: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: AppColor
                                                                  .whiteColor,
                                                            ),
                                                            height: Get.height *
                                                                0.4,
                                                            width:
                                                                Get.width * 0.5,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.015,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                        height: Get.height *
                                                                            0.08,
                                                                        width: Get.height *
                                                                            0.08,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border: Border.all(
                                                                              color: AppColor.primaryColor,
                                                                              width: 1.9),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(100),
                                                                          child: Image.network(Get.put(HomeController()).winnerList[index].user.logo == null ? "" : Get.put(HomeController()).winnerList[index].user.logo, fit: BoxFit.cover, errorBuilder: (context,
                                                                              exception,
                                                                              stackTrace) {
                                                                            return ClipRRect(
                                                                              borderRadius: BorderRadius.circular(100),
                                                                              child: Image.asset(
                                                                                "assets/images/persons.jpg",
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            );
                                                                          }),
                                                                        )),
                                                                    SizedBox(
                                                                      width: Get
                                                                              .width *
                                                                          0.03,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        AppText(
                                                                          title: Get.put(HomeController())
                                                                              .winnerList[index]
                                                                              .user
                                                                              .fullName,
                                                                          size:
                                                                              AppSizes.size_15,
                                                                          fontFamily:
                                                                              AppFont.medium,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color:
                                                                              AppColor.boldBlackColor,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              Get.height * 0.005,
                                                                        ),
                                                                        AppText(
                                                                          title:
                                                                              "00${indexString.toString()}",
                                                                          size:
                                                                              AppSizes.size_12,
                                                                          fontFamily:
                                                                              AppFont.medium,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              AppColor.boldBlackColor,
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.025,
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40),
                                                                    border: Border.all(
                                                                        color: AppColor
                                                                            .primaryColor),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            30),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              AppText(
                                                                                title: province.tr,
                                                                                size: AppSizes.size_11,
                                                                                fontFamily: AppFont.medium,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.black,
                                                                              ),
                                                                              SizedBox(
                                                                                height: 3,
                                                                              ),
                                                                              AppText(
                                                                                title: Get.put(HomeController()).winnerList[index].province.name.toString(),
                                                                                size: AppSizes.size_11,
                                                                                fontFamily: AppFont.medium,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.grey,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              Get.height * 0.06,
                                                                          width:
                                                                              Get.width * 0.003,
                                                                          decoration: BoxDecoration(
                                                                              color: AppColor.primaryColor,
                                                                              borderRadius: BorderRadius.circular(20)),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              AppText(
                                                                                title: purchaseSlots.tr,
                                                                                size: AppSizes.size_11,
                                                                                fontFamily: AppFont.medium,
                                                                                textAlign: TextAlign.center,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.black,
                                                                              ),
                                                                              SizedBox(
                                                                                height: 3,
                                                                              ),
                                                                              AppText(
                                                                                title: Get.put(HomeController()).winnerList[index].province.slot.toString(),
                                                                                size: AppSizes.size_11,
                                                                                fontFamily: AppFont.medium,
                                                                                textAlign: TextAlign.center,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.grey,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.015,
                                                                ),
                                                                AppText(
                                                                  title:
                                                                      price.tr,
                                                                  size: AppSizes
                                                                      .size_13,
                                                                  fontFamily:
                                                                      AppFont
                                                                          .semi,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColor
                                                                      .primaryColor,
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.005,
                                                                ),
                                                                AppText(
                                                                  title:
                                                                      "One year grocery gift from MR.",
                                                                  size: AppSizes
                                                                      .size_11,
                                                                  fontFamily:
                                                                      AppFont
                                                                          .medium,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColor
                                                                      .grey2Color,
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.025,
                                                                ),
                                                                AppButton(
                                                                  buttonColor: AppColor
                                                                      .grey2Color
                                                                      .withOpacity(
                                                                          0.6),
                                                                  textColor:
                                                                      AppColor
                                                                          .whiteColor,
                                                                  onTap: () {
                                                                    Get.put(HomeController()).getWinnerChar(
                                                                        id: Get.put(HomeController())
                                                                            .winnerList[index]
                                                                            .id
                                                                            .toString());
                                                                    Get.to(
                                                                        ChatDetail(
                                                                      data: Get.put(
                                                                              HomeController())
                                                                          .winnerList[index],
                                                                    ));
                                                                  },
                                                                  buttonName:
                                                                      message
                                                                          .tr,
                                                                  buttonHeight:
                                                                      Get.height *
                                                                          0.04,
                                                                  buttonWidth:
                                                                      Get.width,
                                                                  buttonRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.025,
                                                                ),
                                                                AppButton(
                                                                  gard: false,
                                                                  buttonColor:
                                                                      Color(
                                                                          0xffC4C4C4),
                                                                  textColor:
                                                                      AppColor
                                                                          .whiteColor,
                                                                  onTap: () {
                                                                    print(Get.put(
                                                                            HomeController())
                                                                        .winnerList[
                                                                            index]
                                                                        .user
                                                                        .id
                                                                        .toString());
                                                                    Get.back();
                                                                  },
                                                                  buttonName:
                                                                      cancel.tr,
                                                                  buttonHeight:
                                                                      Get.height *
                                                                          0.04,
                                                                  buttonWidth:
                                                                      Get.width,
                                                                  buttonRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                )
                                                              ],
                                                            ),
                                                          ));
                                                    },
                                                  );
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              AppText(
                                                                title: indexString
                                                                    .toString(),
                                                                size: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.02,
                                                              ),
                                                              Container(
                                                                  height:
                                                                      Get.height *
                                                                          0.053,
                                                                  width:
                                                                      Get.height *
                                                                          0.053,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient:
                                                                        AppColor
                                                                            .Home_GRADIENT,
                                                                    border: Border.all(
                                                                        color: AppColor
                                                                            .primaryColor
                                                                            .withOpacity(
                                                                                0.6),
                                                                        width:
                                                                            1.9),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                    child: Image.network(
                                                                        Get.put(HomeController()).winnerList[index].user.logo ==
                                                                                null
                                                                            ? ""
                                                                            : Get.put(HomeController())
                                                                                .winnerList[
                                                                                    index]
                                                                                .user
                                                                                .logo,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        errorBuilder: (context,
                                                                            exception,
                                                                            stackTrace) {
                                                                      return ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(100),
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/images/persons.jpg",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      );
                                                                    }),
                                                                  )),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.02,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.32,
                                                                child: AppText(
                                                                  title: Get.put(
                                                                          HomeController())
                                                                      .winnerList[
                                                                          index]
                                                                      .user
                                                                      .fullName
                                                                      .toString(),
                                                                  size: 16,
                                                                  maxLines: 2,
                                                                  fontFamily:
                                                                      AppFont
                                                                          .medium,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: AppColor
                                                                    .primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          17,
                                                                      vertical:
                                                                          6),
                                                              child: AppText(
                                                                title:
                                                                    // Get.put(HomeController()).profileAllData?.data?.id.toString()==
                                                                    // Get.put(HomeController()).winnerList[index].user.id.toString()?
                                                                    // view.tr:
                                                                    //                   Get.put(HomeController()).winnerList[index].isMessage==false?
                                                                    //                   view.tr:
                                                                    message.tr,
                                                                size: AppSizes
                                                                    .size_12,
                                                                fontFamily:
                                                                    AppFont
                                                                        .medium,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Get.put(HomeController())
                                                                  .winnerList
                                                                  .length ==
                                                              1
                                                          ? SizedBox.shrink()
                                                          : Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Divider(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.7),
                                                                ),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                              ],
                                                            )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    )
                                  : Column(children: [
                                      SizedBox(height: Get.height * 0.025),
                                      Image.asset(
                                        "assets/icons/cloud.png",
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(height: Get.height * 0.01),
                                      Center(
                                          child: AppText(
                                        title:
                                            "No luckiest this time. Stay tuned for\nupcoming opportunities",
                                        size: 14,
                                        color: AppColor.greyLightColor2,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w500,
                                      )),
                                      SizedBox(height: Get.height * 0.01),
                                    ]);
                        }),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                      ],
                    ),
                    Positioned(
                      top: Get.height * 0.16,
                      left:
                          0, // Adjust this value as needed to control the horizontal position
                      right: 0,
                      child: Obx(() {
                        return Get.put(HomeController()).winnerList.isEmpty
                            ? SizedBox.shrink()
                            : Center(
                                child: AppText(
                                  title: Get.put(HomeController())
                                      .winnerList
                                      .last
                                      .user
                                      .fullName
                                      .toString(),
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.blackColor,
                                ),
                              );
                      }),
                    ),
                    Positioned(
                      top: Get.height * 0.21,
                      left: Get.width *
                          0.67, // Adjust this value as needed to control the horizontal position
                      right: 0,

                      child: Obx(() {
                        return Get.put(HomeController()).winnerList.isEmpty
                            ? SizedBox.shrink()
                            : Center(
                                child: AppText(
                                  title: Get.put(HomeController())
                                      .winnerList
                                      .first
                                      .user
                                      .fullName
                                      .toString(),
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.blackColor,
                                ),
                              );
                      }),
                    ),
                    Positioned(
                      top: Get.height * 0.21,
                      right: Get.width *
                          0.72, // Adjust this value as needed to control the horizontal position

                      child: Obx(() {
                        return Get.put(HomeController()).winnerList.isEmpty
                            ? SizedBox.shrink()
                            : Center(
                                child: AppText(
                                  title: Get.put(HomeController())
                                              .winnerList[0]
                                              .user
                                              .fullName ==
                                          null
                                      ? ""
                                      : Get.put(HomeController())
                                          .winnerList[0]
                                          .user
                                          .fullName,
                                  size: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.blackColor,
                                ),
                              );
                      }),
                    ),
                    Positioned(
                        right: Get.width * 0.01,
                        top: Get.height * 0.08,
                        child: Obx(() {
                          return Get.put(HomeController()).winnerList.isEmpty
                              ? SizedBox.shrink()
                              : SizedBox(
                                  height: 105,
                                  width: 96,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Image.asset(
                                          "assets/images/tag6.png",
                                          height: Get.height * 0.15,
                                        ),
                                      ),
                                      Positioned(
                                          right: 20,
                                          top: 27,
                                          child: Container(
                                              height: 55,
                                              width: 55,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColor.primaryColor,
                                                    width: 1.9),
                                                shape: BoxShape.circle,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.network(
                                                    Get.put(HomeController())
                                                                .winnerList[0]
                                                                .user
                                                                .logo ==
                                                            null
                                                        ? ""
                                                        : Get.put(
                                                                HomeController())
                                                            .winnerList[0]
                                                            .user
                                                            .logo,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        exception, stackTrace) {
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Image.asset(
                                                      "assets/images/persons.jpg",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                }),
                                              )))
                                    ],
                                  ),
                                );
                        })),
                    Positioned(
                        left: Get.width * 0.01,
                        top: Get.height * 0.08,
                        child: Obx(() {
                          return Get.put(HomeController()).winnerList.isEmpty
                              ? SizedBox.shrink()
                              : SizedBox(
                                  height: 105,
                                  width: 96,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Image.asset(
                                          "assets/images/tag7.png",
                                          height: Get.height * 0.15,
                                        ),
                                      ),
                                      Positioned(
                                          right: 20,
                                          top: 28,
                                          child: Container(
                                              height: 55,
                                              width: 55,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColor.primaryColor,
                                                    width: 1.9),
                                                shape: BoxShape.circle,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.network(
                                                    Get.put(HomeController())
                                                                .winnerList
                                                                .first
                                                                .user
                                                                .logo ==
                                                            null
                                                        ? ""
                                                        : Get.put(
                                                                HomeController())
                                                            .winnerList
                                                            .first
                                                            .user
                                                            .logo,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        exception, stackTrace) {
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Image.asset(
                                                      "assets/images/persons.jpg",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                }),
                                              )))
                                    ],
                                  ),
                                );
                        }))
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
