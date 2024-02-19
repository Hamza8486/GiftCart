import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/bottom_tabs/wallet/view/wallet_view.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/component/drawer.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/slot_model.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:scratcher/scratcher.dart';

import '../../../../util/translation_keys.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
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
    final tomorrowMidnight = DateTime(now.year, now.month, now.day + 1, 0, 0, 0);
    return tomorrowMidnight.isBefore(now) ? const Duration(seconds: 0) : tomorrowMidnight.difference(now);
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
  List<String> bannerList = [
    'assets/images/banner1.png',

    // Add more image paths as needed
  ];

  String? provinceName;

  @override
  Widget build(BuildContext context) {
    final isTimerComplete = _hours == 0 && _minutes == 0 && _seconds == 0;
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              dashboardTopBar(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                    print("object");
                  },
                  onTap1: () {

                  },
                  text: "0${homeController.profileId.value}"),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.035),
                      child: Stack(
                        children: [
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
                              autoPlayAnimationDuration: const Duration(milliseconds: 400),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {

                              },
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                            ),
                            items: bannerList
                                .map((item) => GestureDetector(
                              onTap:
                                  (){

                              },
                              child: Container(

                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:  Image.asset(
                                    item.toString(),
                                    width: Get.width,
                                    fit: BoxFit.cover,

                                  ),
                                ),
                              ),
                            ))
                                .toList(),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
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

                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Center(
                                      child: AppText(
                                        title: grocery.tr,
                                        size: 15,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            homeController.selectOption.value ==
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
                      height: Get.height * 0.03,
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
                                    child1:  SvgPicture.asset("assets/icons/layer.svg",height: Get.height*0.018,
                                      color: AppColor.boldBlackColor,

                                    ),
                                    width:  Get.put(AuthController())
                                        .provinceList.isEmpty?Get.width * 0.36:Get.width * 0.36,
                                    height: Get.height * 0.3,
                                    items:Get.put(AuthController()).provinceAllList,
                                    color: AppColor.primaryColor,
                                    value: provinceName,
                                    onChange: (value) {
                                      setState(() {

                                        provinceName = value;

                                        for (int i = 0;
                                        i <
                                            Get.put(AuthController())
                                                .provinceList.length;
                                        i++) {
                                          if (value == Get.put(AuthController())
                                              .provinceList[i].name){
                                            homeController.provinceId =
                                                Get.put(AuthController())
                                                    .provinceList[i].id;
                                            homeController.updateProvincesName(
                                                Get.put(AuthController()).provinceList[i].name);
                                            homeController.updateSlotName("");
                                                       homeController.updateIsSelectProvince(
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
                                    hint:selectSlot.tr,
                                    child1:  SvgPicture.asset("assets/images/slot.svg",height: Get.height*0.018,
                                      color: AppColor.boldBlackColor,

                                    ),
                                    width: Get.width * 0.36,
                                    height: Get.height * 0.3,
                                    items:types,
                                    color: AppColor.primaryColor,
                                    value: homeController.slot.value.isEmpty
                                        ? null
                                        : homeController.slot.value,
                                      onChange: (value) {
                                        setState(() {
                                          if (homeController.isSelectProvince.value != "") {
                                            homeController.updateSlotName(value.toString());

                                            // Check if an item with the same provinceId already exists in the list
                                            final existingSlotIndex = homeController.slotAddList.indexWhere(
                                                  (slot) => slot.id == homeController.provinceId.toString(),
                                            );

                                            if (existingSlotIndex != -1) {
                                              // Update the existing slot with the new value
                                              homeController.slotAddList[existingSlotIndex].slot = value.toString();
                                            } else {
                                              // Add a new item to the list
                                              homeController.slotAddList.add(
                                                AddSlotModel(
                                                  name: homeController.selectProvince.value.toString(),
                                                  id: homeController.provinceId.toString(),
                                                  slot: value.toString(),
                                                  total: "",
                                                ),
                                              );
                                            }

                                            homeController.updateSlotName("");
                                            totalSlots = 0;

                                            for (var slots in homeController.slotAddList) {
                                              totalSlots += int.parse(slots.slot ?? "");
                                            }

                                            homeController.provinceId = null;
                                            provinceName = null;
                                            homeController.updateSlotName("");
                                            homeController.updateIsSelectProvince("");
                                            homeController.updateProvincesName("");
                                          } else {
                                            homeController.provinceId = null;
                                            homeController.updateIsSelectProvince("");
                                            homeController.updateSlotName("");
                                            homeController.updateProvincesName("");
                                            flutterToast(msg: selectProvince.tr);
                                          }
                                        });
                                      }
                                  );
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
                        ),),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          itemCount:
                                              homeController.slotAddList.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                homeController.slotAddList
                                                    .removeAt(index);
                                                totalSlots = 0;

                                                for (var slots in homeController
                                                    .slotAddList) {
                                                  totalSlots += int.parse(
                                                      slots.slot ?? "");
                                                }
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: index == 0 ? 0 : 7,
                                                    right: homeController
                                                            .slotAddList.isEmpty
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
                                                      padding: const EdgeInsets.only(
                                                          left: 20,
                                                          top: 3,
                                                          right: 3),
                                                      child: Icon(
                                                        Icons.cancel_outlined,
                                                        color:
                                                            AppColor.blackColor,
                                                        size: Get.height * 0.02,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  Get.width *
                                                                      0.025),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: Get.height *
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
                                                                AppFont.medium,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.black,
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
                                                                AppFont.medium,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.black,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      title: balance.tr+ ": ",
                                      size: 13,
                                      fontFamily: AppFont.medium,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.009,
                                    ),
                                    Obx(
                                      () {
                                        return
                                          homeController.transactionLoadingValue.value?
                                           const Center(
                                              child: SpinKitThreeBounce(
                                                  size: 12, color: AppColor.whiteColor)):
                                        homeController.totalAmountWallet.value=="0"?

                                          AppText(
                                          title: "\$0",
                                          size:17,
                                          fontFamily: AppFont.semi,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ):AppText(
                                          title: "\$${homeController.totalAmountWallet.value.toString()}",
                                          size: 17,
                                          fontFamily: AppFont.semi,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        );
                                      }
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _hours == 0 && _minutes == 0 && _seconds == 0?

                                    Center(
                                      child: AppText(
                                        title: timeClose.tr,
                                        size: 13,
                                        fontFamily: AppFont.semi,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ):
                                    Center(
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
                                          borderRadius: BorderRadius.circular(1000),
                                          child
                                              : CircularPercentIndicator(
                                            radius: Get.height * 0.025,
                                            lineWidth: 2,
                                            percent: (_hours / 24).clamp(0.0, 1.0), // Assuming 12 hours in total
                                            center: Center(
                                              child: AppText(
                                                title: _hours.toString().padLeft(2, '0'),
                                                size: 13,
                                                fontFamily: AppFont.medium,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            backgroundColor: AppColor.primaryColor.withOpacity(0.4),
                                            progressColor: AppColor.primaryColor,
                                            fillColor: Colors.white,

                                          ),
                                        ),

                                        const SizedBox(width: 5),

                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(1000),
                                          child
                                              : CircularPercentIndicator(
                                            radius: Get.height * 0.025,
                                            lineWidth: 2,
                                            percent: (_minutes / 60).clamp(0.0, 1.0), // Assuming 12 hours in total
                                            center: Center(
                                              child: AppText(
                                                title:_minutes.toString().padLeft(2, '0'),
                                                size:13,
                                                fontFamily: AppFont.medium,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            backgroundColor: AppColor.primaryColor.withOpacity(0.4),
                                            progressColor: AppColor.primaryColor,
                                            fillColor: Colors.white,

                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(1000),
                                          child
                                              : CircularPercentIndicator(
                                            radius: Get.height * 0.025,
                                            lineWidth: 2,
                                            percent: (_seconds / 60).clamp(0.0, 1.0),// Assuming 12 hours in total
                                            center: Center(
                                              child: AppText(
                                                title: _seconds.toString().padLeft(2, '0'),
                                                size: 13,
                                                fontFamily: AppFont.medium,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            backgroundColor: AppColor.primaryColor.withOpacity(0.4),
                                            progressColor: AppColor.primaryColor,
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
                          EdgeInsets.symmetric(horizontal: Get.width * 0.2),
                      child: Obx(() {
                        return homeController.slotAdd.value
                            ?  const Center(
                                child: SpinKitThreeBounce(
                                    size: 25, color: AppColor.primaryColor))
                            : AppButton(
                                buttonWidth: Get.width,
                                buttonHeight: Get.height * 0.051,
                                buttonRadius: BorderRadius.circular(30),
                                buttonName: confirmSlots.tr,
                                fontWeight: FontWeight.w500,
                                textSize: 16,
                                buttonColor: homeController
                                        .slotAddList.isNotEmpty
                                    ? AppColor.primaryColor
                                    : AppColor.primaryColor,
                                textColor: AppColor.whiteColor,
                                onTap:
                                homeController.totalAmountWallet.value=="0"?(){
                                  flutterToast(msg:pleaseAddAmount.tr);
                                }:

                                homeController.slotAddList.isEmpty
                                    ? () {
                                        flutterToast(
                                            msg:
                                            wallet.tr);

                                      }
                                    : () {
                                        homeController.updateAddSlot(true);

                                        ApiManger().AddSLots(
                                          prodQuantity: List<dynamic>.from(
                                              homeController.slotAddList),
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
                            padding:  EdgeInsets.only(right:Get.width * 0.02 ),
                            child: SizedBox(
                              height: Get.put(AuthController()).provinceList.isEmpty
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
                                    maxHeight: Get.height*0.25),
                                itemBuilder: (BuildContext bc) {
                                  return List.generate(
                                      Get.put(AuthController()).provinceList.length, (index ) {
                                    return  PopupMenuItem(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 12),
                                        value:  Get.put(AuthController()).provinceList[index]
                                            .id
                                            .toString(),
                                        child: AppText(
                                          title: Get.put(AuthController()).provinceList[index]
                                              .name
                                              .toString(),

                                          size: AppSizes.size_13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: AppFont.medium,
                                          color: AppColor.blackColor,
                                        ));
                                  });
                                },
                                child:Center(
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
                                        onTap:

                                        homeController.getSlot[index].isScratch==true?(){
                                          print(homeController.getSlot[index].id
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
                                              backgroundColor: Colors.transparent,
                                              isScrollControlled: true,
                                              isDismissible: true,
                                              context: context,
                                              builder: (context) =>   SlotTrue(
                                                id:homeController.getSlot[index].id
                                                    .toString() ,
                                                code:homeController.getSlot[index].code
                                                    .toString()  ,

                                              ));
                                        }:
                                            () {
                                          print(homeController.getSlot[index].id
                                              .toString());
                                          ApiManger().slotVView(id: homeController.getSlot[index].id.toString());

                                          showModalBottomSheet(
                                              backgroundColor: Colors.transparent,
                                              isScrollControlled: true,
                                              isDismissible: true,
                                              context: context,
                                              builder: (context) =>   SlotView(
                                                id:homeController.getSlot[index].id
                                                    .toString() ,
                                                code:homeController.getSlot[index].code
                                                    .toString()  ,


                                              ));

                                        },
                                        child:



                                     Container(
                                                decoration:  BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColor.primaryColor.withOpacity(0.25),),
                                                child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(
                                                            18.0),
                                                    child: Icon(
                                                      Icons.shopping_cart,
                                                      color:


                                                          AppColor.grey3Color,
                                                      size: 25,
                                                    )),
                                              )

                                      );
                                    })
                                : noData(height: Get.height * 0));
                      }),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                  ],
                ),
              ))
            ],
          ),
          // Positioned(child: child)
          Positioned(
              top: Get.height * 0.048,
              right: 6,
              child: GestureDetector(
                onTap: (){
                  homeController.getTransData();
                  homeController.getSlotHis();
                  Get.to(const WalletView(),
                      transition: Transition.rightToLeft
                  );
                },
                child: Image.asset(
                  "assets/images/add.png",


                  
                  height: 56,
                  width: 56,

                ),
              ))
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

  List<DropdownMenuItem<int>> countryDataList1({var dataList}) {
    List<DropdownMenuItem<int>> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(DropdownMenuItem<int>(
          value: dataList[i].id,
          child: AppText(
            title: dataList[i].name,
            size: AppSizes.size_15,
            color: AppColor.blackColor,
            fontFamily: AppFont.medium,
            fontWeight: FontWeight.w500,
          )));
    }
    return outputList;
  }




}


class SlotView extends StatefulWidget {
   SlotView({super.key,this.id ="",this.code =""});
   String id ;
   String code ;


  @override
  State<SlotView> createState() => _SlotViewState();
}

class _SlotViewState extends State<SlotView> {
  bool isScratched=false;
  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;



    return DraggableScrollableSheet(
      initialChildSize: isKeyBoard ? 0.99 : 0.99,
      minChildSize: isKeyBoard? 0.99 : 0.99,
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
              SizedBox(height: Get.height*0.2,),

              Container(
                height: 320,
                width: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    SizedBox(height:
                    isScratched?
                    Get.height*0.06:Get.height*0.04,),
                    AppText(
                      title:
                      isScratched?
                      "Congratulations!":"Scratch Coupon!",
                      size: 15,
                      color:
                      isScratched?
                      AppColor.primaryColor:AppColor.blackColor,

                      fontWeight:
                      isScratched?
                      FontWeight.w700:FontWeight.w600,
                    ),
                    isScratched?SizedBox.shrink():
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 65),
                      child: Divider(color: Colors.black.withOpacity(0.2),
                      thickness: 1.5,
                      ),
                    ),
                    SizedBox(height:
                    isScratched?
                    Get.height*0.01:Get.height*0.02,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.17),
                      child: Scratcher(
                        brushSize: 50, // Adjust the brush size as needed
                        threshold: 40, // Adjust the threshold as needed
                        color: isScratched ? Colors.transparent : Colors.grey, // Initial scratch card color
                        image: Image.asset('assets/images/scratch.png',
                          height: 131,
                          width: 200,
                        ), // Custom brush image
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

                          height:
                          isScratched?
                          161:141,
                          width: 218,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isScratched ? Colors.white : Colors.transparent, // Content revealed
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: isScratched
                                ? [] // No shadow when content is revealed
                                : [const BoxShadow(blurRadius: 10, color: Colors.grey)], // Add a blurred effect
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
                                  Image.asset("assets/images/sca.png",
                                  height: 120,
                                    width: 120,
                                  )
                                ],
                              )
                              : const Text(
                            'Scratch Me!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height*0.02,),
                    AppText(
                      title: "Scratch it to get your\n coupon number",
                      size: 12,
                      color: AppColor.greyLightColor2,
                      textAlign: TextAlign.center,

                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.13,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                child: AppButton(
                  buttonName:
                  isScratched?"Ok":
                  "Cancel",
                  gard:false,
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
  SlotTrue({super.key,this.id ="",this.code =""});
  String id ;
  String code ;


  @override
  State<SlotTrue> createState() => _SlotTrueState();
}

class _SlotTrueState extends State<SlotTrue> {
  bool isScratched=true;
  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;



    return DraggableScrollableSheet(
      initialChildSize: isKeyBoard ? 0.99 : 0.99,
      minChildSize: isKeyBoard? 0.99 : 0.99,
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
              SizedBox(height: Get.height*0.2,),

              Container(
                height: 330,
                width: 330,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    SizedBox(height:
                    isScratched?
                    Get.height*0.05:Get.height*0.04,),
                    AppText(
                      title:
                      isScratched?
                      "Congratulations!":"Scratch Coupon!",
                      size: 15,
                      color:
                      isScratched?
                      AppColor.primaryColor:AppColor.blackColor,

                      fontWeight:
                      isScratched?
                      FontWeight.w700:FontWeight.w600,
                    ),
                    isScratched?SizedBox.shrink():
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 65),
                      child: Divider(color: Colors.black.withOpacity(0.2),
                        thickness: 1.5,
                      ),
                    ),
                    SizedBox(height:
                    isScratched?
                    Get.height*0.01:Get.height*0.02,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.17),
                      child: Scratcher(
                        brushSize: 50, // Adjust the brush size as needed
                        threshold: 40, // Adjust the threshold as needed
                        color: isScratched ? Colors.transparent : Colors.grey, // Initial scratch card color
                        image: null, // Custom brush image
                        onChange: (value) {
                          if (value >= 1.0 && !isScratched) {
                            setState(() {


                            });
                          }
                          print("Scratch progress: ${value * 100}%");
                        },
                        child: Container(

                          height:
                          isScratched?
                          141:141,
                          width: 218,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isScratched ? Colors.white : Colors.transparent, // Content revealed
                            borderRadius: BorderRadius.circular(10),
                            boxShadow:isScratched
                                ? [] // No shadow when content is revealed
                                : [const BoxShadow(blurRadius: 10, color: Colors.grey)], // Add a blurred effect
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
                              Image.asset("assets/images/sca.png",
                                height: 105,
                                width: 105,
                              )
                            ],
                          )
                              : const Text(
                            'Scratch Me!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height*0.02,),
                    Padding(
                      padding:  EdgeInsets.only(left: 50),
                      child: Row(

                        children: [
                          AppText(
                            title: "Sr. Number : ",
                            size: 12,
                            color: AppColor.greyLightColor2,
                            textAlign: TextAlign.center,

                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(width: Get.width*0.03,),
                          Row(
                            children: [
                              Text(
                                "00${widget.id.toString()}",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  color: AppColor.whiteColor,
                                  decorationStyle: TextDecorationStyle.solid,
                                  wordSpacing: 2,
                                  decorationColor: AppColor.blackColor,

                                ),

                              ),
                              Text(
                                "00${widget.id.toString()}",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,decorationColor: AppColor.blackColor,
                                  fontSize: 14,
                                  color: AppColor.greyLightColor2,

                                ),

                              ),
                              Text(
                                "00${widget.id.toString()}",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  color: AppColor.whiteColor,
                                  decorationColor: AppColor.blackColor,

                                ),

                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height*0.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppText(
                          title: "Validity : ",
                          size: 12,
                          color: AppColor.greyLightColor2,
                          textAlign: TextAlign.center,

                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(width: Get.width*0.03,),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "00${widget.id.toString()}",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    color: AppColor.whiteColor,
                                    decorationStyle: TextDecorationStyle.solid,
                                    wordSpacing: 2,
                                    decorationColor: AppColor.blackColor,

                                  )),
                                Text(
                                  "7 Days",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    color: AppColor.greyLightColor2,
                                    decorationColor: AppColor.blackColor,

                                  ),

                                ),
                                Text(
                                  "00${widget.id.toString()}",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    color: AppColor.whiteColor,
                                    decorationColor: AppColor.blackColor,

                                  )),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
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
                  gard:false,
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
