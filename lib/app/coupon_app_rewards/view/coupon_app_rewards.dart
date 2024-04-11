import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:giftcart/app/auth/component.dart';
import 'package:giftcart/app/auth/controller.dart';
import 'package:giftcart/app/bottom_tabs/component/component.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/component/detail.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/component/wallet.dart';
import 'package:giftcart/app/bottom_tabs/profile/component/all_data.dart';
import 'package:giftcart/app/bottom_tabs/wallet/controller/wallet_controller.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';
import 'package:giftcart/services/api_manager.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/util/toast.dart';
import 'package:giftcart/widgets/app_button.dart';
import 'package:giftcart/widgets/app_text.dart';
import 'package:giftcart/widgets/helper_function.dart';
import 'package:giftcart/widgets/image_pick.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../util/translation_keys.dart';

class RewardView extends StatefulWidget {
  const RewardView({super.key});

  @override
  State<RewardView> createState() => _RewardViewState();
}

class _RewardViewState extends State<RewardView> {


  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
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
              SizedBox(
                height: Get.height * 0.06,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          "assets/icons/backs.png",
                          height: 30,
                          width: 30,
                        )),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    AppText(
                      title: "Rewards",
                      size: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColor.primaryColor,
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),

              Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Obx(
                        () {
                          return
                            Get.put(HomeController()).invoiceLoader.value
                                ? Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.35,
                                ),
                                Center(
                                    child: SpinKitThreeBounce(
                                        size: 25,
                                        color: AppColor.primaryColor)),
                              ],
                            )
                                :

                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset('assets/images/backs.png',
                                      height: 146,

                                      width: Get.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 146,
                                    width: Get.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            title: "Reward points",
                                            size: 16,
                                            fontFamily: AppFont.medium,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),

                                          Spacer(),

                                          AppText(
                                            title: "Total balance",
                                            size: 14,
                                            fontFamily: AppFont.medium,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset("assets/images/coin1.png",
                                                width: 30,
                                                height: 24,
                                              ),
                                              SizedBox(width: 10,),
                                              AppText(
                                                title:
                                                Get.put(HomeController()).rewardsDataModel?.coins==null?"0":
                                                (Get.put(HomeController()).rewardsDataModel?.coins).toString().split(".").first,
                                                size: 32,
                                                fontFamily: AppFont.medium,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                              AppText(
                                                title: " (worth \$${ Get.put(HomeController()).rewardsDataModel?.dollarValue==null?"0":
                                                (Get.put(HomeController()).rewardsDataModel?.dollarValue).toString().split(".").first})",
                                                size: 12,
                                                fontFamily: AppFont.medium,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 30,
                                    right: 10,
                                    child:  Image.asset("assets/images/coins.png",
                                    width: 70,
                                    height: 70,
                                  ),)
                                ],
                              ),
                              SizedBox(height: 16,),
                              (Get.put(HomeController()).rewardsDataModel?.inovices??[]).isEmpty?SizedBox.shrink():
                              AppText(
                                title: "Reward point history",
                                size: 15,
                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w500,
                                color: AppColor.blackColor
                                ,
                              ),
                              (Get.put(HomeController()).rewardsDataModel?.inovices??[]).isEmpty?SizedBox.shrink():
                              SizedBox(height: 6,),
                              (Get.put(HomeController()).rewardsDataModel?.inovices??[]).isEmpty?SizedBox.shrink():
                ListView.builder(
                    itemCount:  Get.put(HomeController()).rewardsDataModel?.inovices?.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      DateTime time = DateTime.parse(
                        (Get.put(HomeController()).rewardsDataModel?.inovices?[index].createdAt).toString(),
                      );
                          return  Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Color(0xffD9D9D9))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        AppText(
                                          title: "Date (${DateFormat('dd MMM yyyy').format(
                                              time
                                          )})",
                                          size: 11,
                                          fontFamily: AppFont.medium,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.greyLightColor2
                                          ,
                                        ),
                                      ],
                                    ),
                                    AppText(
                                      title: "${ (Get.put(HomeController()).rewardsDataModel?.inovices?[index].title).toString()} Coins",
                                      size: 16,
                                      fontFamily: AppFont.medium,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff45A843)
                                      ,
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        AppText(
                                          title: "Invoice no - ",
                                          size: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff3B3B3B)
                                          ,
                                        ),
                                        AppText(
                                          title: "#000${(Get.put(HomeController()).rewardsDataModel?.inovices?[index].id).toString()}",
                                          size: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.blackColor
                                          ,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                    }),



                            ],
                          );
                        }
                      ),
                    )),
              ),
              Obx(
                () {

                  return

                    Get.put(HomeController()).invoiceLoader.value?SizedBox.shrink():
                    Get.put(HomeController()).rewardsDataModel?.coins==null?SizedBox.shrink():
                    int.parse((Get.put(HomeController()).rewardsDataModel?.coins).toString().split(".").first)<99?SizedBox.shrink():


                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    child: AppButton(buttonName: "Redeem", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor, onTap:


                        (){
                      showModalBottomSheet(
                          backgroundColor:
                          Colors.transparent,
                          isScrollControlled:
                          true,
                          isDismissible: true,
                          context: context,
                          builder: (context) =>
                              RedeemReward(
                                totalValue: Get.put(HomeController()).rewardsDataModel?.coins==null?SizedBox.shrink():
                                Get.put(HomeController()).rewardsDataModel?.coins.toString().split(".").first ,

                              ));
                    },
                    buttonWidth: Get.width,
                      buttonRadius: BorderRadius.circular(10),
                      gard: true,
                    ),
                  );
                }
              )
            ],
          ),
          Positioned(
              top: Get.height * 0.06,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  Get.to(AllData(name: "Rewards",link: "https://admin.mr-corp.ca/help/Reward",));

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

class RedeemReward extends StatefulWidget {
   RedeemReward({super.key,this.totalValue});
  var totalValue;

  @override
  State<RedeemReward> createState() => _RedeemRewardState();
}

class _RedeemRewardState extends State<RedeemReward> {
  var totalValueCon  = TextEditingController();
  var redeemValue  = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalValueCon.text = widget.totalValue.toString();
  }

  @override

  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return
      DraggableScrollableSheet(
        initialChildSize: isKeyBoard?0.8:0.5,
        minChildSize: isKeyBoard?0.8:0.5,
        maxChildSize: isKeyBoard?0.8:0.5,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: Get.height * 0.03),
                Center(
                  child: AppText(
                      title: "Redeem reward points",
                      size: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColor.blackColor),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                textAuth(text: "Total reward points"),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                betField(
                  hint: "20",
                  controller: totalValueCon,
                  isRead: true
                    ,
                  isCur: false
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                textAuth(text: "Enter points to redeem"),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                betField(
                  hint: "Type here",
                  onChange: (val){
                    setState(() {

                    });
                  },
                  textInputAction: TextInputAction.done,
                    controller: redeemValue,
                  textInputType: TextInputType.phone

                ),
                Spacer(),
                Obx(
                  () {
                    return
                      Get.put(PaymentController()).redeemLoader.value?
                      Center(
                          child: SpinKitThreeBounce(
                              size: 25,
                              color: AppColor.primaryColor)):
                      AppButton(buttonName: "Redeem", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor, onTap: (){
                        if(redeemValue.text.isEmpty){
                          flutterToast(msg: "Please enter coins");
                        }
                        else{
                          Get.put(PaymentController()).updateRedeemLoader(true);
                          ApiManger().addInvoice(amount: redeemValue.text,context: context);
                        }

                    },
                      buttonWidth: Get.width,
                      buttonRadius: BorderRadius.circular(10),
                      gard: true,
                    );
                  }
                ),

              ],
            ),
          ),
        ),
      );
  }
}


class RedeemSuccessfull extends StatelessWidget {
  const RedeemSuccessfull({super.key});

  @override

  Widget build(BuildContext context) {
    return
      DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.4,
        maxChildSize: 0.4,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: Get.height * 0.07),
                Center(
                  child: Image.asset(
                    "assets/images/yes.png",
                    height: 38,
                    width: 38,
                  ),
                ),
                SizedBox(height: Get.height * 0.015),
                Center(
                  child: AppText(
                      title: "Points redeemed successful",
                      size: 19,
                      fontWeight: FontWeight.w600,
                      color: AppColor.blackColor),
                ),
                SizedBox(height: Get.height * 0.005),
                Center(
                  child: AppText(
                      title: "You have successfully redeemed!",
                      size: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColor.greyLightColor2),
                ),

                Spacer(),
            AppButton(buttonName: "Go to wallet", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor, onTap: (){
              Get.back();
              Get.put(HomeController()).getTransData();
              Get.put(HomeController()).getProfileData()
              ;
              Get.put(HomeController()).getSlotHis();
              Get.to(NewWalletView());

            },
              buttonWidth: Get.width,
              buttonRadius: BorderRadius.circular(10),
              gard: true,
            ),
                SizedBox(height: Get.height * 0.03),

              ],
            ),
          ),
        ),
      );
  }
}