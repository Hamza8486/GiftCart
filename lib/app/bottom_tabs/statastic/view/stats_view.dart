import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/auth/component.dart';
import 'package:giftcart/app/auth/controller.dart';
import 'package:giftcart/app/bottom_tabs/component/drawer.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/view/dashboard_view.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';
import 'package:giftcart/services/api_manager.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/util/translation_keys.dart';
import 'package:giftcart/widgets/app_button.dart';
import 'package:giftcart/widgets/app_text.dart';
import 'package:giftcart/widgets/helper_function.dart';
import 'package:scratcher/scratcher.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class StatsView extends StatefulWidget {
  StatsView({Key? key}) : super(key: key);

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  final homeController = Get.put(HomeController());
  final auth = Get.put(AuthController());
  String nameValue = "";
  String Slots = "";
  String? provinceName;
  double _opacity = 0.0;
  List names = ["day", "week", "month"];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _selectedItem;
  String? filter;
  var provinceId;
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
                  "Easily track grocery and manage spending with Gift Cart's Stats feature. Stay organized and in control of your budget effortlessly!",
              onnext: () {
                controller.next();
                homeController.currentTab.value = 3;
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
    HelperFunctions.getFromPreference("stats").then((value) {
      nameValue = value;
      print(nameValue.toString());
      if (value == "value1") {
      } else {
        HelperFunctions.saveInPreference("stats", "value1");
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          show_tutorialcochmark();
        });
      }
    });

    provinceId = null;
    filter = null;
    _selectedItem = null;
    homeController.updateTypeSelect("");
    homeController.getStatHis(id: "", day: "");
  }

  final GlobalKey item = GlobalKey();
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
                          key: item,
                          height: 38,
                          width: 38,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: AppText(
                          title: stats.tr,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                // border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.03, right: Get.width * 0.01),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: SizedBox(
                                width: Get.width * 0.36,
                                child: Obx(() {
                                  return dropDownAppAddAll(
                                    hint: province.tr,
                                    child1: SvgPicture.asset(
                                      "assets/icons/layer.svg",
                                      height: Get.height * 0.018,
                                      color: AppColor.boldBlackColor,
                                    ),
                                    width: Get.put(AuthController())
                                            .provinceList
                                            .isEmpty
                                        ? Get.width * 0.33
                                        : Get.width * 0.33,
                                    height: Get.height * 0.3,
                                    items: Get.put(AuthController())
                                        .provinceAllList,
                                    color: AppColor.primaryColor,
                                    value: provinceName,
                                    onChange: (value) {
                                      setState(() {
                                        print(value.toString());

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
                                            homeController.getStatHis(
                                                id: Get.put(AuthController())
                                                    .provinceList[i]
                                                    .id,
                                                day: filter == null
                                                    ? ""
                                                    : filter.toString());
                                            homeController.updateProvincesName(
                                                Get.put(AuthController())
                                                    .provinceList[i]
                                                    .name);
                                          }
                                        }
                                      });
                                    },
                                  );
                                })),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: SizedBox(
                                width: Get.width * 0.3,
                                child: Obx(() {
                                  return dropDownAppAddAll(
                                    hint: grocery.tr,
                                    colorIcon: Colors.transparent,
                                    child1: SizedBox.shrink(),
                                    width: Get.put(AuthController())
                                            .provinceList
                                            .isEmpty
                                        ? Get.width * 0.3
                                        : Get.width * 0.3,
                                    height: Get.height * 0.3,
                                    items: ["Grocery"],
                                    color: AppColor.primaryColor,
                                    value: null,
                                    onChange: (value) {},
                                  );
                                })),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 0, top: 5),
                            child: SizedBox(
                              height:
                                  Get.put(AuthController()).provinceList.isEmpty
                                      ? Get.height * 0.055
                                      : Get.height * 0.055,
                              child: PopupMenuButton(
                                shadowColor: Colors.white,
                                surfaceTintColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                offset: const Offset(0, 55),
                                onSelected: (value) async {
                                  setState(() {
                                    filter = value.toString();
                                    homeController.getStatHis(
                                        id: provinceId == null
                                            ? ""
                                            : provinceId.toString(),
                                        day: value.toString());
                                  });
                                },
                                constraints: BoxConstraints(
                                    minWidth: Get.height * 0.1,
                                    maxWidth: Get.height * 0.1,
                                    maxHeight: Get.height * 0.25),
                                itemBuilder: (BuildContext bc) {
                                  return List.generate(names.length, (index) {
                                    return PopupMenuItem(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        value: names[index].toString(),
                                        child: AppText(
                                          title: names[index].toString(),
                                          size: 13,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.blackColor,
                                        ));
                                  });
                                },
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/filter1.png",
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.greyColor.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 0.01),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Row(
                                children: [
                                  AppText(
                                    title: provinceName == null
                                        ? ""
                                        : provinceName.toString(),
                                    size: AppSizes.size_16,
                                    fontFamily: AppFont.semi,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  provinceName == null
                                      ? SizedBox.shrink()
                                      : SizedBox(
                                          width: Get.width * 0.023,
                                        ),
                                  provinceName == null
                                      ? SizedBox.shrink()
                                      : Image.asset(
                                          "assets/icons/line.png",
                                          height: Get.height * 0.03,
                                        ),
                                  provinceName == null
                                      ? SizedBox.shrink()
                                      : SizedBox(
                                          width: Get.width * 0.023,
                                        ),
                                  Obx(() {
                                    return Container(
                                      height:
                                          homeController.statHistList.isEmpty
                                              ? Get.height * 0.02
                                              : Get.height * 0.02,
                                      width: Get.width * 0.55,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColor.greys,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: LinearProgressIndicator(
                                          value: homeController
                                                  .statHistList.length /
                                              100, // The value should be between 0.0 and 1.0
                                          backgroundColor: AppColor.greys,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  AppColor.primaryColor),
                                        ),
                                      ),
                                    );
                                  }),
                                  SizedBox(
                                    width: 13,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        AppText(
                                          title: slots.tr,
                                          size: 10,
                                          textAlign: TextAlign.center,
                                          fontFamily: AppFont.regular,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Obx(() {
                                          return AppText(
                                            title: homeController
                                                .statHistList.length
                                                .toString(),
                                            size: AppSizes.size_15,
                                            fontFamily: AppFont.regular,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          title: totalPrice.tr,
                          size: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Obx(() {
                          return AppText(
                            title: homeController.totalPrice.value.isEmpty
                                ? "0"
                                : "\$${homeController.totalPrice.value}",
                            size: homeController.totalPrice.value.isNotEmpty
                                ? 18
                                : 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          );
                        }),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.012,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.012,
                    ),
                    Obx(() {
                      return homeController.statLoading.value
                          ? Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.13,
                                ),
                                Center(
                                  child: Container(
                                    height: 57,
                                    width: 57,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
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
                                                  AppColor
                                                      .primaryColor
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
                          : homeController.statHistList.isNotEmpty
                              ? GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  reverse: true,
                                  primary: false,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5,
                                          childAspectRatio:
                                              Get.width / Get.width * 1.2,
                                          crossAxisSpacing: 6,
                                          mainAxisSpacing: 16),
                                  itemCount: homeController.statHistList.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                        onTap: homeController
                                                    .statHistList[index]
                                                    .isScratch ==
                                                true
                                            ? () {
                                                print(homeController
                                                    .statHistList[index].id
                                                    .toString());
                                                print(homeController
                                                    .statHistList[index]
                                                    .province
                                                    .name
                                                    .toString());

                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    isScrollControlled: true,
                                                    isDismissible: true,
                                                    context: context,
                                                    builder: (context) =>
                                                        SlotTrue(
                                                          id: homeController
                                                              .statHistList[
                                                                  index]
                                                              .id
                                                              .toString(),
                                                          code: homeController
                                                              .statHistList[
                                                                  index]
                                                              .code
                                                              .toString(),
                                                          name: homeController
                                                              .statHistList[
                                                                  index]
                                                              .province
                                                              .name
                                                              .toString(),
                                                        ));
                                              }
                                            : () {
                                                print(homeController
                                                    .statHistList[index].id
                                                    .toString());
                                                ApiManger().slotVView(
                                                    id: homeController
                                                        .statHistList[index].id
                                                        .toString());

                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    isScrollControlled: true,
                                                    isDismissible: true,
                                                    context: context,
                                                    builder: (context) =>
                                                        SlotView(
                                                          id: homeController
                                                              .statHistList[
                                                                  index]
                                                              .id
                                                              .toString(),
                                                          code: homeController
                                                              .statHistList[
                                                                  index]
                                                              .code
                                                              .toString(),
                                                          name: homeController
                                                              .statHistList[
                                                                  index]
                                                              .province
                                                              .name
                                                              .toString(),
                                                        ));
                                              },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: homeController
                                                          .statHistList[index]
                                                          .isScratch ==
                                                      true
                                                  ? AppColor.primaryColor
                                                      .withOpacity(0.25)
                                                  : Color(0xfffa7175)),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Icon(
                                                Icons.shopping_cart,
                                                color:
                                                    // homeController
                                                    //     .getSlot1[index].isScratch=="true"?
                                                    // AppColor.primaryColor:
                                                    AppColor.grey3Color,
                                                size: AppSizes.size_25,
                                              )),
                                        ));
                                  })
                              : Column(children: [
                                  SizedBox(height: Get.height * 0.15),
                                  Image.asset(
                                    "assets/icons/cloud.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Center(
                                      child: AppText(
                                    title: "No stats available.\nTime to grab.",
                                    size: 14,
                                    color: AppColor.greyLightColor2,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w500,
                                  )),
                                  SizedBox(height: Get.height * 0.01),
                                ]);
                      ;
                    }),
                    SizedBox(
                      height: Get.height * 0.065,
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

  List<DropdownMenuItem<int>> countryDataList({var dataList}) {
    List<DropdownMenuItem<int>> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(DropdownMenuItem<int>(
          value: dataList[i].id,
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/layer.svg",
                height: Get.height * 0.026,
                color: AppColor.boldBlackColor,
              ),
              SizedBox(
                width: Get.width * 0.04,
              ),
              AppText(
                title: dataList[i].name,
                size: AppSizes.size_15,
                color: AppColor.blackColor,
                fontFamily: AppFont.medium,
                fontWeight: FontWeight.w500,
              ),
            ],
          )));
    }
    return outputList;
  }

  Future<void> scratchDialog(
      {required BuildContext context, text, id, String? value}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: CircleBorder(),
            title: SizedBox.shrink(),
            content: Container(
              height: Get.height * 0.83,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.28,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  StatefulBuilder(builder: (context, StateSetter setState) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: value == null
                            ? Scratcher(
                                accuracy: ScratchAccuracy.low,
                                color: Colors.blueGrey,
                                onChange: (value) {
                                  setState(() {
                                    if (value == 60.0) {
                                      ApiManger().claimScratch(
                                          context: context, id: id.toString());
                                    } else {
                                      print(value.toString());
                                    }
                                  });
                                },
                                onScratchStart: () {
                                  print("Scratching has started");
                                },
                                onScratchUpdate: () {
                                  print("Scratching in progress");
                                },
                                onScratchEnd: () {
                                  print("Scratching has finished");
                                },
                                image: Image.asset(
                                  'assets/images/scan1.png',
                                ),
                                brushSize: 15,
                                threshold: 60,
                                onThreshold: () {
                                  setState(() {
                                    _opacity = 1;
                                  });
                                },
                                child: AnimatedOpacity(
                                  duration: Duration(microseconds: 100),
                                  opacity: _opacity,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: MediaQuery.of(context).size.height *
                                        0.22,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        AppText(
                                          title: congratulations.tr,
                                          size: AppSizes.size_16,
                                          fontFamily: AppFont.semi,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.primaryColor,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        AppText(
                                          title: text.toString(),
                                          size: AppSizes.size_19,
                                          fontFamily: AppFont.semi,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.blackColor,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        Image.asset(
                                          "assets/images/sca.png",
                                          height: Get.height * 0.16,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.03,
                                    ),
                                    AppText(
                                      title: congratulations.tr,
                                      size: AppSizes.size_16,
                                      fontFamily: AppFont.semi,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.primaryColor,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    AppText(
                                      title: text.toString(),
                                      size: AppSizes.size_19,
                                      fontFamily: AppFont.semi,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.blackColor,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Image.asset(
                                      "assets/images/sca.png",
                                      height: Get.height * 0.09,
                                    )
                                  ],
                                ),
                              ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: Get.height * 0.13,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                    child: AppButton(
                      buttonName: ok.tr,
                      buttonColor: AppColor.primaryColor,
                      textColor: AppColor.whiteColor,
                      onTap: () {
                        Get.back();
                      },
                      buttonHeight: Get.height * 0.055,
                      buttonWidth: Get.width,
                      fontFamily: AppFont.medium,
                      textSize: AppSizes.size_16,
                      buttonRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
