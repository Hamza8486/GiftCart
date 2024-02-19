import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/component/detail.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/component/promote_business.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/helper_function.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../util/translation_keys.dart';
import '../../../../../widgets/bottom_sheet.dart';

class PromoteBusinessAdsNew extends StatefulWidget {
  const PromoteBusinessAdsNew({super.key});

  @override
  State<PromoteBusinessAdsNew> createState() => _PromoteBusinessAdsNewState();
}

class _PromoteBusinessAdsNewState extends State<PromoteBusinessAdsNew> {
  String selectTab = "wallet";
  String selectTabs = "earned";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(VendorController()).getAdsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/icons/home1.svg",
            width: Get.width,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(
                  onTap1: () {},
                  onTap: () {
                    Get.back();
                  },
                  text: promoteYourBusiness.tr,
                  image: "assets/icons/info.png",
                  color: AppColor.whiteColor),
              SizedBox(
                height: Get.height * 0.015,
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(CreateAddView());
                        },
                        child: Image.asset(
                          "assets/images/promote.png",
                          width: Get.width,
                          height: 156,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      AppText(
                        title: myAds.tr,
                        size: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackColor,
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectTabs = "earned";
                              });
                            },
                            child: Container(
                              height: 42,
                              width: 90,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: selectTabs == "earned"
                                        ? AppColor.primaryColor
                                        : AppColor.boldBlackColor),
                                color: selectTabs == "earned"
                                    ? AppColor.primaryColor
                                    : AppColor.whiteColor,
                                gradient: selectTabs == "earned"
                                    ? AppColor.Home_GRADIENT
                                    : null,
                                // border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: AppText(
                                  title: active.tr,
                                  size: 12,
                                  fontWeight: FontWeight.w500,
                                  color: selectTabs == "earned"
                                      ? AppColor.whiteColor
                                      : AppColor.blackColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.04,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectTabs = "redeem";
                              });
                            },
                            child: Container(
                              height: 42,
                              width: 90,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: selectTabs == "redeem"
                                        ? AppColor.primaryColor
                                        : AppColor.boldBlackColor),
                                color: selectTabs == "redeem"
                                    ? AppColor.primaryColor
                                    : AppColor.whiteColor,
                                gradient: selectTabs == "redeem"
                                    ? AppColor.Home_GRADIENT
                                    : null,
                                // border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: AppText(
                                  title: history.tr,
                                  size: 12,
                                  fontWeight: FontWeight.w500,
                                  color: selectTabs == "redeem"
                                      ? AppColor.whiteColor
                                      : AppColor.blackColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Obx(() {
                        return Get.put(VendorController()).userAdsLoader.value
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.2,
                                  ),
                                  Center(
                                      child: SpinKitThreeBounce(
                                          size: 25,
                                          color: AppColor.primaryColor)),
                                ],
                              )
                            : Get.put(VendorController()).getAdsList.isEmpty
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.2,
                                      ),
                                      Center(
                                          child: AppText(
                                        title: noData_.tr,
                                        color: AppColor.blackColor
                                            .withOpacity(0.7),
                                        size: 16,
                                        fontWeight: FontWeight.w500,
                                      ))
                                    ],
                                  )
                                : ListView.builder(
                                    itemCount: Get.put(VendorController())
                                        .getAdsList
                                        .length,
                                    shrinkWrap: true,
                                    primary: false,
                                    padding: EdgeInsets.zero,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                          padding: EdgeInsets.only(
                                              top: index == 0 ? 0 : 10,
                                              bottom: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(AddDetail(
                                                data:
                                                    Get.put(VendorController())
                                                        .getAdsList[index],
                                              ));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    spreadRadius: 2,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        2), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                child: Container(
                                                  width: Get.width,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xfffafafa),
                                                    // border: Border.all(color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.1),
                                                        spreadRadius: 2,
                                                        blurRadius: 7,
                                                        offset: const Offset(0,
                                                            2), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Get.width *
                                                                    0.04,
                                                            vertical: 15),
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              CachedNetworkImage(
                                                            placeholder: (context,
                                                                    url) =>
                                                                const Center(
                                                                    child: SpinKitThreeBounce(
                                                                        size:
                                                                            16,
                                                                        color: AppColor
                                                                            .primaryColor)),
                                                            imageUrl: Get.put(
                                                                    VendorController())
                                                                .getAdsList[
                                                                    index]
                                                                .image
                                                                .toString(),
                                                            fit: Get.put(
                                                                        VendorController())
                                                                    .name
                                                                    .value
                                                                    .isEmpty
                                                                ? BoxFit.cover
                                                                : BoxFit.cover,
                                                            height: 65,
                                                            width: 65,
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/bg.png",
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 65,
                                                                width: 65,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.02,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  AppText(
                                                                      title: Get.put(
                                                                              VendorController())
                                                                          .getAdsList[
                                                                              index]
                                                                          .title
                                                                          .toString(),
                                                                      size: 16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppColor
                                                                          .blackColor),
                                                                  Container(
                                                                    height: 24,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.black.withOpacity(0.5))),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              5),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.circle,
                                                                            color:
                                                                                Colors.green,
                                                                            size:
                                                                                8,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                7,
                                                                          ),
                                                                          Center(
                                                                            child: AppText(
                                                                                title: active.tr,
                                                                                size: 10,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: AppColor.blackColor),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    Get.height *
                                                                        0.005,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                              "assets/icons/likes.svg"),
                                                                      SizedBox(
                                                                        width:
                                                                            7,
                                                                      ),
                                                                      AppText(
                                                                          title:
                                                                              "0",
                                                                          size:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              AppColor.boldBlackColor),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        Get.width *
                                                                            0.03,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                              "assets/icons/total.svg"),
                                                                      SizedBox(
                                                                        width:
                                                                            7,
                                                                      ),
                                                                      AppText(
                                                                          title:
                                                                              "0",
                                                                          size:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              AppColor.boldBlackColor),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    Get.height *
                                                                        0.005,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  AppText(
                                                                      title:
                                                                          published
                                                                              .tr,
                                                                      size: 12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColor
                                                                          .boldBlackColor),
                                                                  SvgPicture
                                                                      .asset(
                                                                    "assets/icons/times.svg",
                                                                    height: 16,
                                                                    width: 16,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 7,
                                                                  ),
                                                                  AppText(
                                                                      title: timeago.format(DateTime.parse(
                                                                          (Get.put(VendorController()).getAdsList[index].adDate)
                                                                              .toString())),
                                                                      size: 12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColor
                                                                          .blackColor),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ));
                                    },
                                  );
                      })
                    ],
                  ),
                )),
              ),
            ],
          ),
          Positioned(
              top: Get.height * 0.058,
              right: 12,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context,
                      builder: (context) => addsInfoWidget());
                },
                child: Image.asset(
                  "assets/icons/info.png",
                  height: 25,
                  width: 25,
                ),
              ))
        ],
      ),
    );
  }
}

class CreateAddView extends StatefulWidget {
  const CreateAddView({super.key});

  @override
  State<CreateAddView> createState() => _CreateAddViewState();
}

class _CreateAddViewState extends State<CreateAddView> {
  bool stripe = false;
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusDay) {
    setState(() {
      today = day;
    });
  }

  var titleController = TextEditingController();
  var desController = TextEditingController();
  var addressController = TextEditingController();
  var offerValue = TextEditingController();
  var website = TextEditingController();
  var whatsappController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  var dateController = TextEditingController();
  var budgetController = TextEditingController();
  var daysController = TextEditingController();
  String? _offerType;
  String isWebsite = "";
  File? file;
  bool isSchedule = true;

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: Column(
        children: [
          TopBar(
              onTap1: () {},
              onTap: () {
                Get.back();
              },
              text: createNewAdd.tr,
              image: "assets/icons/share.svg",
              color: AppColor.whiteColor),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (builder) => bottomSheet(onCamera: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.camera)
                                      .then((value) {
                                    setState(() {
                                      file = value!;
                                    });
                                  });
                                }, onGallery: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.gallery)
                                      .then((value) {
                                    setState(() {
                                      file = value!;
                                    });
                                  });
                                }));
                      },
                      child: Container(
                        width: Get.width,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: AppColor.greyLightColor2)),
                        child: file == null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/icons/image.svg"),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  AppText(
                                      title: uploadAddImage.tr,
                                      size: 16,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.blackColor),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  AppText(
                                      title: "(358*150px)",
                                      size: 12,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.greyLightColor2)
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  file as File,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    textAuth(text: addTitle.tr, color: Colors.transparent),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    betField(
                        hint: typeHere.tr,
                        max: 1,
                        controller: titleController,
                        textInputAction: TextInputAction.done),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textAuth(
                                  text: updateNow.tr,
                                  color: Colors.transparent),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              SizedBox(
                                  width: Get.width,
                                  child: Obx(() {
                                    return dropDownAppAddAll(
                                      hint: discount.tr,
                                      child1: SizedBox.shrink(),
                                      width: Get.put(AuthController())
                                              .provinceList
                                              .isEmpty
                                          ? Get.width * 0.43
                                          : Get.width * 0.43,
                                      height: Get.height * 0.3,
                                      items: ["Discount"],
                                      color: AppColor.borderColorField,
                                      value: _offerType,
                                      onChange: (value) {
                                        setState(() {
                                          _offerType = value.toString();
                                        });
                                      },
                                    );
                                  }))
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
                              textAuth(
                                  text: offerType.tr,
                                  color: Colors.transparent),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              betField(
                                  hint: typeHere.tr,
                                  max: 1,
                                  controller: offerValue,
                                  textInputAction: TextInputAction.done),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    textAuth(
                        text: offerDescription.tr, color: Colors.transparent),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    betField(
                        hint: typeHere.tr,
                        max: 2,
                        controller: desController,
                        textInputAction: TextInputAction.done),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isWebsite = '';
                            });
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                isWebsite == ''
                                    ? "assets/icons/fill.png"
                                    : "assets/icons/circle.png",
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              AppText(
                                  title: websiteLink.tr,
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isWebsite = 'what';
                            });
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                isWebsite == "what"
                                    ? "assets/icons/fill.png"
                                    : "assets/icons/circle.png",
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              AppText(
                                  title: whatsapp.tr,
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackColor),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    betField(
                        hint: typeHere.tr,
                        max: 2,
                        controller: website,
                        textInputType: isWebsite == "what"
                            ? TextInputType.phone
                            : TextInputType.url,
                        textInputAction: TextInputAction.done),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/pin.svg",
                          color: AppColor.blackColor,
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        AppText(
                            title: addLocation.tr,
                            size: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    betField(
                        hint: typeHere.tr,
                        max: 1,
                        controller: addressController,
                        textInputType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.done),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                  title: selectDays.tr,
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackColor),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              betField(
                                  hint: typeHere.tr,
                                  max: 1,
                                  controller: daysController,
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
                                  title: selectBudget.tr,
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackColor),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              betField(
                                  hint: typeHere.tr,
                                  max: 1,
                                  controller: budgetController,
                                  textInputType: TextInputType.phone,
                                  textInputAction: TextInputAction.done),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                  title: startTime.tr,
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackColor),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              betField(
                                  hint: startTime.tr,
                                  max: 1,
                                  controller: startTimeController,
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
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    );

                                    if (pickedTime != null) {
                                      final String formattedTime =
                                          '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                          '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                      setState(() {
                                        startTimeController.text =
                                            '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                            '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                        print(
                                            "this is time  ${startTimeController.text}");
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
                                  title: endTime.tr,
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blackColor),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              betField(
                                  hint: endTime.tr,
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
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    );

                                    if (pickedTime != null) {
                                      final String formattedTime =
                                          '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                          '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                      setState(() {
                                        endTimeController.text =
                                            '${pickedTime.hour.toString().padLeft(2, '0')}:'
                                            '${pickedTime.minute.toString().padLeft(2, '0')}:00';
                                        print(
                                            "this is time  ${endTimeController.text}");
                                      });
                                    }
                                  },
                                  controller: endTimeController,
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSchedule == true) {
                            isSchedule = false;
                          } else {
                            isSchedule = true;
                          }
                        });
                      },
                      child: Row(
                        children: [
                          isSchedule == true
                              ? Icon(
                                  Icons.check_box,
                                  color: AppColor.boldBlackColor,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  color: AppColor.boldBlackColor,
                                  size: 30,
                                ),
                          SizedBox(
                            width: 10,
                          ),
                          AppText(
                            title: scheduleAdd.tr,
                            size: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.boldBlackColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      color: Colors.white,
                      width: Get.width,
                      child: TableCalendar(
                        locale: "en_US",
                        rowHeight: 38,
                        daysOfWeekVisible: false,
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 16,
                            // Customize the color for the title
                            fontWeight: FontWeight
                                .w600, // You can customize other text styles as well
                          )),
                        ),
                        availableGestures: AvailableGestures.all,
                        focusedDay: today,
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            gradient: AppColor.Home_GRADIENT,
                            // Customize the color for the focused date
                            shape: BoxShape
                                .circle, // You can use other shapes as well
                          ),
                          selectedDecoration: BoxDecoration(
                            gradient: AppColor.Home_GRADIENT,

                            /// Customize the color for the selected date
                            shape: BoxShape.circle,
                          ),
                        ),
                        selectedDayPredicate: (day) => isSameDay(day, today),
                        firstDay: DateTime.now(),
                        lastDay: DateTime.utc(2030, 10, 16),
                        onDaySelected: _onDaySelected,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                  ],
                ),
              ),
            ),
          ),
          isKeyBoard
              ? SizedBox.shrink()
              : Obx(() {
                  return Get.put(VendorController()).adLoader.value
                      ? Center(
                          child: SpinKitThreeBounce(
                              size: 25, color: AppColor.primaryColor))
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: AppButton(
                            buttonWidth: Get.width,
                            buttonRadius: BorderRadius.circular(10),
                            buttonName: publishAdd,
                            fontWeight: FontWeight.w600,
                            textSize: 16,
                            textColor: AppColor.whiteColor,
                            onTap: () {
                              if (validateAds(context)) {
                                Get.put(VendorController())
                                    .updateAdLoader(true);
                                ApiManger().createBusAds(
                                    title: titleController.text,
                                    date:
                                        DateFormat("yyyy-MM-dd").format(today),
                                    description: desController.text,
                                    isWebsite: isWebsite == "" ? true : false,
                                    isWhatsapp: isWebsite == "" ? false : true,
                                    offerType: discount.tr,
                                    offerTypeValue: offerValue.text,
                                    address: addressController.text,
                                    website:
                                        isWebsite == "" ? website.text : '',
                                    whatsapp: isWebsite != ""
                                        ? whatsappController.text
                                        : "",
                                    schedule: isSchedule,
                                    startDate: startTimeController.text,
                                    endDate: endTimeController.text,
                                    file: file,
                                    addDay: daysController.text,
                                    budget: budgetController.text);
                              }
                            },
                            buttonColor: AppColor.primaryColor,
                          ),
                        );
                }),
        ],
      ),
    );
  }

  bool validateAds(BuildContext context) {
    if (file == null) {
      flutterToast(msg: pleaseUploadImage.tr);
      return false;
    }
    if (titleController.text.isEmpty) {
      flutterToast(msg: pleaseEnterTitle.tr);
      return false;
    }
    if (_offerType == null) {
      flutterToast(msg: pleaseSelectOfferType.tr);
      return false;
    }
    if (offerValue.text.isEmpty) {
      flutterToast(msg: pleaseEnterOfferValue.tr);
      return false;
    }
    if (desController.text.isEmpty) {
      flutterToast(msg: pleaseEnterDescription.tr);
      return false;
    }
    if (website.text.isEmpty) {
      flutterToast(msg: pleaseEnterWebsiteWhatsappNum.tr);
      return false;
    }
    if (addressController.text.isEmpty) {
      flutterToast(msg: pleaseEnterAddress.tr);
      return false;
    }

    if (daysController.text.isEmpty) {
      flutterToast(msg:pleaseEnterDays.tr);
      return false;
    }
    if (budgetController.text.isEmpty) {
      flutterToast(msg: pleaseEnterBudget.tr);
      return false;
    }
    if (startTimeController.text.isEmpty) {
      flutterToast(msg: pleaseSelectStartTime.tr);
      return false;
    }

    return true;
  }
}
