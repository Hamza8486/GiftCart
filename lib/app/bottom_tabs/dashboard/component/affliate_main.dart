import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/component/affiliate/affilicate_activate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:giftcart/app/auth/component.dart';
import 'package:giftcart/app/auth/controller.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/component/affiliate/affiliate_slider.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/component/affiliate/redeem_info_bottomsheet.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/component/affiliate/redeem_now.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/all_data.dart';
import 'package:giftcart/app/bottom_tabs/wallet/view/wallet_view.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';
import 'package:giftcart/util/image_const.dart';
import 'package:giftcart/util/translation_keys.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/widgets/app_button.dart';
import 'package:giftcart/widgets/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

class AffiliateViewMain extends StatefulWidget {
  AffiliateViewMain({this.isShowActivateNow = true, super.key});

  var isShowActivateNow;

  @override
  State<AffiliateViewMain> createState() => _AffliateViewState();
}

class _AffliateViewState extends State<AffiliateViewMain> {
  List<String> bannerList = [
    'assets/images/mans.png',
    'assets/images/mans.png',
    'assets/images/mans.png',

    // Add more image paths as needed
  ];
  int _current = 0;

  final CarouselController _controller = CarouselController();
  String wallet = "wallet";

  void openWhatsApp({String phoneNumber = "", String message = ""}) async {
    String url = "https://wa.me/$phoneNumber?text=${Uri.parse(message)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          appBarWidget(),
          bodyWidget(),
        ],
      ),
    );
  }

  appBarWidget() {
    return Stack(
      children: [
        Container(
          height: 280,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/backs.png',
                ),
                fit: BoxFit.cover),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.06),
              appBarView(),
              Spacer(),
              rewardAndReferWidget(),
              SizedBox(height: 10),
              redeemRewardAndTransactionWidget(),
              SizedBox(height: 10)
            ],
          ),
        )
      ],
    );
  }

  bodyWidget() {
    return Expanded(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 20),
            Obx(() {
              return Get.put(AuthController()).allAdsLoader.value
                  ? Center(
                      child: SpinKitThreeBounce(
                          size: 25, color: AppColor.primaryColor))
                  : Get.put(AuthController()).getAllAdsList.isNotEmpty
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
                                autoPlayInterval: const Duration(seconds: 3),
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
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                              ),
                              items: Get.put(AuthController())
                                  .getAllAdsList
                                  .map((item) => GestureDetector(
                                        onTap: () {
                                          print("object");
                                          print("object");
                                          print("object");
                                          print("object");
                                          print(item.website.toString());
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.red.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0, left: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      1000),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: item.image
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                            width: 62,
                                                            height: 44,
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          1000),
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/logo_man.png",
                                                                fit: BoxFit
                                                                    .cover,
                                                                width: 62,
                                                                height: 44,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        SizedBox(
                                                          width: 125,
                                                          child: Text(
                                                            item.title
                                                                .toString(),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts.italianno(
                                                                textStyle: TextStyle(
                                                                    color: AppColor
                                                                        .blackColor,
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
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
                                                              color: AppColor
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        13,
                                                                    vertical:
                                                                        5),
                                                            child: AppText(
                                                              title: item.offerTypeValue ==
                                                                      null
                                                                  ? "0% Off"
                                                                  : "${item.offerTypeValue.toString()}% Off",
                                                              size: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColor
                                                                  .primaryColor,
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
                                                    item.isWebsite == true
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              launch(
                                                                  "http://${item.website.toString()}");
                                                            },
                                                            child: Container(
                                                              height: 32,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border.all(
                                                                      color: AppColor
                                                                          .primaryColor)),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child: Center(
                                                                  child:
                                                                      AppText(
                                                                    title:
                                                                        visitWebsite
                                                                            .tr,
                                                                    size: 14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppColor
                                                                        .primaryColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : GestureDetector(
                                                            onTap: () {
                                                              openWhatsApp(
                                                                  phoneNumber: item
                                                                      .whatsapp
                                                                      .toString(),
                                                                  message:
                                                                      welcomeToMyGrocery
                                                                          .tr);
                                                            },
                                                            child: Image.asset(
                                                              "assets/images/chat.png",
                                                              width: 104,
                                                              height: 32,
                                                            ),
                                                          )
                                                  ],
                                                ),
                                              ),
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          item.image.toString(),
                                                      fit: BoxFit.cover,
                                                      width: 150,
                                                      height: 140,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.asset(
                                                          "assets/images/mans.png",
                                                          fit: BoxFit.cover,
                                                          width: 210,
                                                          height: 140,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: 12,
                                                      right: 12,
                                                      child: Image.asset(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      bannerList.asMap().entries.map((entry) {
                                    return GestureDetector(
                                      onTap: () =>
                                          _controller.animateToPage(entry.key),
                                      child: Container(
                                        width: 8.0,
                                        height: 8.0,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _current == entry.key
                                                ? AppColor.primaryColor
                                                : Colors.white
                                                    .withOpacity(0.6)),
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
                                autoPlayInterval: const Duration(seconds: 3),
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
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                              ),
                              items: bannerList
                                  .map((item) => GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.red.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0, left: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/logo_man.png",
                                                          width: 31,
                                                          height: 22,
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text(
                                                          specialOffer.tr,
                                                          style: GoogleFonts.italianno(
                                                              textStyle: TextStyle(
                                                                  color: AppColor
                                                                      .blackColor,
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
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
                                                              color: AppColor
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        13,
                                                                    vertical:
                                                                        5),
                                                            child: AppText(
                                                              title:
                                                                  fiftyOff.tr,
                                                              size: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColor
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        AppText(
                                                          title: onAllOrders.tr,
                                                          size: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                                      child: Image.asset(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      bannerList.asMap().entries.map((entry) {
                                    return GestureDetector(
                                      onTap: () =>
                                          _controller.animateToPage(entry.key),
                                      child: Container(
                                        width: 8.0,
                                        height: 8.0,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _current == entry.key
                                                ? AppColor.primaryColor
                                                : Colors.white
                                                    .withOpacity(0.6)),
                                      ),
                                    );
                                  }).toList(),
                                )),
                          ],
                        );
            }),
            SizedBox(height: 15),
            widget.isShowActivateNow ? activateNowView() : Container(),
            SizedBox(height: 15),
            widget.isShowActivateNow ? Container() : activateAffiliateView(),
            textAuth(text: referId.tr),
            SizedBox(height: Get.height * 0.01),
            addReferIdWidget(),
            SizedBox(height: 15),
            shareWithFriendWidget(),
            SizedBox(height: 20),
            referContact(),
            SizedBox(height: 10),
            referContactListWidget(),
            SizedBox(height: Get.height * 0.06),
          ],
        ),
      ),
    ));
  }

  carouselWidget() {
    return Stack(
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
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 400),
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
                    child: AffiliateSliderItem(item),
                  ))
              .toList(),
        ),
        Positioned(
            right: 0,
            left: 0,
            bottom: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bannerList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == entry.key
                            ? AppColor.primaryColor
                            : Colors.white.withOpacity(0.6)),
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }

  shareWithFriendWidget() {
    return AppButton(
        buttonWidth: Get.width,
        buttonRadius: BorderRadius.circular(10),
        buttonName: shareWithFriends.tr,
        fontWeight: FontWeight.w500,
        gard: true,
        buttonColor: AppColor.primaryColor,
        buttonHeight: Get.height * 0.054,
        textSize: AppSizes.size_15,
        borderWidth: 1.1,
        borderColor: AppColor.primaryColor,
        textColor: AppColor.whiteColor,
        onTap: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              isDismissible: true,
              context: context,
              builder: (context) => UploadReceiipt());
        });
  }

  referContact() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          title: referYrContact.tr,
          color: AppColor.greyLightColor2,
          size: 14,
          fontWeight: FontWeight.w600,
        ),
        AppText(
          title: viewAll.tr,
          color: AppColor.whiteColor,
          size: 12,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  addReferIdWidget() {
    return betField(
        hint: "LSUbaske188343666655",
        isSuffix: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/icons/copy.png",
            scale: 3,
          ),
        ));
  }

  referContactListItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: Get.height * 0.05,
                  width: Get.height * 0.05,
                  decoration: BoxDecoration(
                      color: AppColor.lightBlue,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: AppText(
                      title: "JS",
                      size: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.04,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title: "Jack Smith",
                      size: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.blackColor,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    AppText(
                      title: "+1 666 443 2323",
                      size: 12,
                      fontFamily: AppFont.regular,
                      fontWeight: FontWeight.w500,
                      color: AppColor.greyLightColor2,
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Image.asset(
                  "assets/images/wh.png",
                  height: 25,
                  width: 25,
                ),
                SizedBox(width: 20),
                Image.asset(
                  "assets/images/mess.png",
                  height: 25,
                  width: 25,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  referContactListWidget() {
    return ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return referContactListItem(index);
        });
  }

  rewardAndReferWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              title: rewards.tr,
              size: 14,
              fontWeight: FontWeight.w400,
              color: AppColor.whiteColor.withOpacity(0.9),
            ),
            AppText(
              title: "\$200",
              size: 28,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ],
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white.withOpacity(0.3)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      title: "12",
                      color: AppColor.whiteColor,
                      size: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    AppText(
                      title: friendsReferred.tr,
                      color: AppColor.whiteColor,
                      size: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  redeemRewardAndTransactionWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                isDismissible: true,
                context: context,
                builder: (context) => RedeemNowWidget());
          },
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.whiteColor),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: AppText(
                  title: redeemRewards.tr,
                  color: AppColor.whiteColor,
                  size: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        AppText(
          title: transactions.tr,
          color: AppColor.whiteColor,
          size: 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  profileViewWidget() {
    return Obx(() {
      return Container(
        height: 36,
        width: Get.put(HomeController()).name.value.isEmpty ? 36 : 36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            border: Border.all(color: AppColor.whiteColor, width: 1.5)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: CachedNetworkImage(
              imageUrl: Get.put(HomeController()).image.value,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset(
                  "assets/images/person.png",
                  fit: BoxFit.cover,
                ),
              ),
            )),
      );
    });
  }

  countsWidget() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: countItemWidget("\$200", total.tr),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: countItemWidget("\$84", monthly.tr),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: countItemWidget("10k", rewardsHistory.tr),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: countItemWidget("20", members.tr),
            ),
          ],
        )
      ],
    );
  }

  countItemWidget(String value, String name) {
    return Container(
      height: 78,
      padding: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
            image: AssetImage('assets/images/backs.png'), fit: BoxFit.cover),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/person.png",
            fit: BoxFit.cover,
            height: 35,
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                  title: value,
                  color: AppColor.whiteColor,
                  size: 16,
                  fontWeight: FontWeight.w600),
              SizedBox(
                width: 100,
                child: AppText(
                    title: name,
                    maxLines: 1,
                    overFlow: TextOverflow.ellipsis,
                    color: AppColor.whiteColor,
                    size: 12,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }

  activeAffiliateView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 96,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
            image: AssetImage('assets/images/backs.png'), fit: BoxFit.cover),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                  title: activeAffiliates.tr,
                  color: AppColor.whiteColor,
                  size: 14,
                  fontWeight: FontWeight.w400),
              AppText(
                  title: "10k",
                  color: AppColor.whiteColor,
                  size: 32,
                  fontWeight: FontWeight.w700)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                  title: "\$20k",
                  color: AppColor.whiteColor,
                  size: 32,
                  fontWeight: FontWeight.w700),
              AppText(
                  title: totalEarned.tr,
                  color: AppColor.whiteColor,
                  size: 14,
                  fontWeight: FontWeight.w400)
            ],
          )
        ],
      ),
    );
  }

  appBarView() {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              "assets/icons/backs.png",
              height: 30,
              width: 30,
              color: Colors.white,
            )),
        SizedBox(width: Get.width * 0.04),
        Expanded(
          child: AppText(
            title: affiliate.tr,
            color: AppColor.whiteColor,
            size: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(AllData(
              name: "Afffiliate",
              link: "https://admin.mr-corp.ca/help/Afffiliate",
            ));
          },
          child: Image.asset(
            "assets/icons/info.png",
            height: 25,
            color: Colors.white,
            width: 25,
          ),
        ),
        SizedBox(width: 20),
        profileViewWidget(),
      ],
    );
  }

  activateNowView() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.borderColorField),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: [
          AppText(
            title: 'Activate the affiliate account',
          ),
          SizedBox(height: 16),
          InkWell(
            onTap:(){
              Get.to(ActivateAffiliateAccScreen());
            } ,
            child: Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                width: Get.width,
                decoration: BoxDecoration(
                    color: AppColor.greenColor1,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: AppText(
                  title: 'Activate now',
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w500,
                )),
          )
        ],
      ),
    );
  }

  activateAffiliateView() {
    return Column(
      children: [
        countsWidget(),
        SizedBox(height: Get.height * 0.02),
        activeAffiliateView(),
        SizedBox(height: Get.height * 0.02),
      ],
    );
  }
}
