import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/notification_view.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/tap_pay.dart';
import 'package:mr_bet/app/bottom_tabs/wallet/controller/wallet_controller.dart';
import 'package:mr_bet/app/bottom_tabs/wallet/view/wallet_view.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';

class NewWalletView extends StatefulWidget {
  const NewWalletView({super.key});

  @override
  State<NewWalletView> createState() => _NewWalletViewState();
}

class _NewWalletViewState extends State<NewWalletView> {
  String wallet = "wallet";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset('assets/images/backs.png',
              height: 280,
                width: Get.width,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height*0.06,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap:(){
                                Get.back();
                              },
                              child:  Image.asset("assets/icons/backs.png",
                                height: 30,
                                color: Colors.white,
                                width: 30,
                              ),
                            ),
                            SizedBox(width: Get.width*0.04,),
                            AppText(
                              title: wallet.tr,
                              color: AppColor.whiteColor,
                              size: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),



                        Obx(
                          () {
                            return Container(
                              height:36,
                              width:

                              Get.put(HomeController()).name.value.isEmpty?36:
                              36,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  border: Border.all(color: AppColor.whiteColor, width: 1.5)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: CachedNetworkImage(
                                    imageUrl:Get.put(HomeController()).image.value,
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
                          }
                        ),


                      ],
                    ),
                    SizedBox(height: 25,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    setState(() {
                                      wallet="wallet";
                                    });
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(

                                        color: wallet=="wallet"?AppColor.whiteColor:Colors.transparent,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child:Center(
                                      child: AppText(
                                        title: wallet.tr,
                                        size: 12,
                                        fontWeight: FontWeight.w500,
                                        color:
                                        wallet=="wallet"?Colors.black:
                                        AppColor.blackColor,
                                      ),
                                    ) ,
                                  ),
                                ),

                                GestureDetector(
                                  onTap:(){
                                    Get.put(HomeController()).getPayHisData();
                                    setState(() {
                                      wallet="gift";
                                    });
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(

                                        color: wallet=="gift"?AppColor.whiteColor:Colors.transparent,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child:Center(
                                      child: AppText(
                                        title: giftWallet.tr,
                                        size: 12,
                                        fontWeight: FontWeight.w500,
                                        color:
                                        wallet=="gift"?Colors.black:
                                        AppColor.blackColor,
                                      ),
                                    ) ,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Obx(
                       () {
                        return AppText(
                          title: hi.tr+", ${Get.put(HomeController()).name.value}",
                          size:
                          Get.put(HomeController()).name.value.isEmpty?12:
                          13,
                          fontWeight: FontWeight.w400,
                          color:

                          AppColor.whiteColor.withOpacity(0.7));
                      }
                    ),
                      SizedBox(height: 10,),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                title: totalBalance.tr,
                                size: 14,
                                fontWeight: FontWeight.w400,
                                color:

                                AppColor.whiteColor.withOpacity(0.9),
                    ),

                              wallet!="gift"?
                              Obx(
                                      () {
                                    return
                                      Get.put(HomeController()).transactionLoadingValue.value?
                                      Center(
                                          child: SpinKitThreeBounce(
                                              size: 13, color: AppColor.whiteColor)):
                                      Get.put(HomeController()).totalAmountWallet.value=="0"?

                                      Center(
                                        child: AppText(
                                          title: "\$0",
                                          size:28,

                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ):Obx(
                                        () {
                                          return Center(
                                            child: AppText(
                                              title: "\$${Get.put(HomeController()).totalAmountWallet.value.toString()}",
                                              size:
                                              Get.put(HomeController()).rewardEarning.value.isNotEmpty?28:
                                              28,
                                              letterSpacing: 1.1,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          );
                                        }
                                      );
                                  }
                              ):Obx(
                                () {
                                  return AppText(
                                    title: "\$${Get.put(HomeController()).rewardEarning.value.toString()}",
                                    size:
                                    Get.put(HomeController()).rewardEarning.value.isNotEmpty?28:
                                    28,

                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  );
                                }
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){

                                  Get.to(TapPay(),
                                      transition: Transition.rightToLeft
                                  );
                                },
                                child: Image.asset(
                                  "assets/icons/bar.png",
                                  color: Colors.white,



                                  height:20,
                                  width: 20,

                                ),
                              ),
                              SizedBox(width: 13,),
                              GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) =>   infoWidget());
                                },
                                child: Image.asset(
                                  "assets/icons/info.png",
                                  color: Colors.white,



                                  height: 25,
                                  width: 25,

                                ),
                              ),
                              SizedBox(width: 13,),
                              wallet!="gift"?
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    Get.put(HomeController()).file1=null;
                                    Get.put(HomeController()).priceController.clear();
                                  });
                                  Get.generalDialog(
                                      pageBuilder: (context, __, ___) => AlertDialog(

                                        content: SizedBox(
                                          height: Get.height*0.18,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              textAuth(text: enterAmount.tr),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              betField(
                                                hint: enterAmount.tr,
                                                textInputAction: TextInputAction.done,
                                                onChange: (val){
                                                  setState(() {
                                                    if(val!.isEmpty||val=="0"){
                                                      Get.put(PaymentController()).updateCheckPayment("");
                                                      Get.put(PaymentController()).priceController.clear();
                                                    }
                                                    else{
                                                      Get.put(PaymentController()).updateCheckPayment(val.toString());
                                                    }


                                                  });
                                                },


                                                controller: Get.put(PaymentController()).priceController,


                                              ),
                                              SizedBox(height: Get.height*0.025,),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: AppButton(
                                                        buttonWidth: Get.width,
                                                        buttonHeight: Get.height*0.055,

                                                        buttonRadius: BorderRadius.circular(10),
                                                        borderColor: AppColor.primaryColor,
                                                        borderWidth: 1.5,
                                                        buttonName: cancel.tr, buttonColor: AppColor.transParent, textColor: AppColor.whiteColor, onTap: (){
                                                      Get.back();

                                                    }),
                                                  ),
                                                  SizedBox(width: Get.width*0.03,),
                                                  Expanded(
                                                    child: Obx(
                                                            () {
                                                          return AppButton(
                                                              buttonWidth: Get.width,
                                                              buttonHeight:
                                                              Get.put(PaymentController()).checkPayment.value.isEmpty?Get.height*0.055:
                                                              Get.height*0.055,

                                                              buttonRadius: BorderRadius.circular(10),
                                                              buttonName: add.tr, buttonColor:

                                                          Get.put(PaymentController()).checkPayment.value.isEmpty?AppColor.primaryColor.withOpacity(0.6):
                                                          AppColor.primaryColor, textColor: AppColor.whiteColor,

                                                              onTap:
                                                              Get.put(PaymentController()).checkPayment.value.isEmpty
                                                                  ? () {
                                                                flutterToast(msg: enterAmount.tr);
                                                              }
                                                                  :
                                                                  (){
                                                                Get.put(PaymentController()).updateCheckLoader(true);
                                                                // Get.put(PaymentController()).priceController.clear();


                                                                Get.back();
                                                                setState(() {
                                                                  Get.put(PaymentController()).makePayment(amount: Get.put(PaymentController()).checkPayment.value, currency: 'cad');

                                                                });
                                                              });
                                                        }
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),

                                      ));
                                },
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.whiteColor
                                  ),
                                  child: Center(child: Icon(Icons.add,color: AppColor.primaryColor,
                                  size: 20,
                                  )),
                                ),
                              ):
                              GestureDetector(
                                onTap: (){
                                  Get.to(NotificationView());
                                },
                                child: Image.asset(
                                  "assets/icons/not.png",
                                  color: Colors.white,



                                  height: 25,
                                  width: 25,

                                ),
                              )
                            ],
                          )
                        ],
                      ),
                  ],
                ),
              )
            ],
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 20,),
                AppButton(
                    buttonWidth: Get.width,
                    buttonRadius: BorderRadius.circular(10),
                    buttonName: uploadReceipt.tr,
                    fontWeight: FontWeight.w500,
                    gard: false,
                    buttonHeight: Get.height*0.054,
                    textSize: AppSizes.size_15,
                    borderWidth: 1.1,
                    borderColor: AppColor.primaryColor,
                    buttonColor: AppColor.whiteColor,
                    textColor: AppColor.primaryColor,
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          isDismissible: true,
                          context: context,
                          builder: (context) =>   UploadReceiipt());

                    }),
                SizedBox(height: 20,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     AppText(
                //       title: "Last Transactions",
                //       color: AppColor.greyLightColor2,
                //       size: 14,
                //       fontWeight: FontWeight.w600,
                //     ),
                //     AppText(
                //       title: "View all",
                //       color: AppColor.blueColor,
                //       size: 12,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ],
                // ),
                // SizedBox(height: 10,),
                wallet!="gift"?
                Obx(
                        () {
                      return
                        Get.put(HomeController()).transactionLoadingValue.value?Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 200,),
                            Center(
                                child: SpinKitThreeBounce(
                                    size: 25, color: AppColor.primaryColor)),
                          ],
                        ):
                        Get.put(HomeController()).transList.isNotEmpty?

                        ListView.builder(
                            itemCount: Get.put(HomeController()).transList.length,
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
                              DateTime time = DateTime.parse(
                                Get.put(HomeController()).transList[index].createdAt.toString(),
                              );

                              DateTime dateTime = DateTime.parse(Get.put(HomeController()).transList[index].createdAt.toString());
                              String formattedTime = DateFormat('hh:mm a').format(dateTime);
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 9),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height:Get.height*0.05,
                                            width:Get.height*0.05 ,
                                            decoration: BoxDecoration(
                                                color: AppColor.lightBlue,
                                                borderRadius: BorderRadius.circular(
                                                    100)
                                            ),
                                            child: Center(
                                              child: AppText(
                                                title: Get.put(HomeController()).transList[index].id.toString(),
                                                size: 14,

                                                fontWeight: FontWeight.w600,
                                                color: AppColor.whiteColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.04,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              AppText(
                                                title: "\$${Get.put(HomeController()).transList[index].amount.toString()}",
                                                size: 14,

                                                fontWeight: FontWeight.w600,
                                                color: AppColor.blackColor,
                                              ),
                                              SizedBox(height: 3,),
                                              AppText(
                                                title:  "${DateFormat('dd MMM yyyy').format(
                                                    time
                                                )} ",
                                                size: 12,
                                                fontFamily: AppFont.regular,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.greyLightColor2,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      AppText(
                                        title:  formattedTime.toString() ,
                                        size: AppSizes.size_13,
                                        fontFamily: AppFont.regular,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.blackColor,
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            })

                            :Column(
                          children: [
                            SizedBox(height: Get.height*0.1,),
                            Center(child: AppText(title: noTransactionData.tr,
                              color: AppColor.blackColor.withOpacity(0.7),
                              size: 16,
                              fontWeight: FontWeight.w500,
                            ))
                          ],
                        );
                    }
                ):
                Obx(() {
                    return


                      Get.put(HomeController()).allPaymentLoader.value?
                      Column(
                        children: [
                          SizedBox(height: 200,),
                          Center(
                              child: SpinKitThreeBounce(
                                  size: 25, color: AppColor.primaryColor)),
                        ],
                      ):
                      Get.put(HomeController()).getProofList.isEmpty?
                      Column(
                        children: [
                          SizedBox(height: Get.height*0.1,),
                          Center(child: AppText(title: noTransactionData.tr,
                            color: AppColor.blackColor.withOpacity(0.7),
                            size: 16,
                            fontWeight: FontWeight.w500,
                          ))
                        ],
                      ):
                      ListView.builder(
                        itemCount:    Get.put(HomeController()).getProofList.length,
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, int index) {
                          DateTime timestamp = DateTime.parse(Get.put(HomeController()).getProofList[index].createdAt.toString());

                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 9),

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height:Get.height*0.05,
                                        width:Get.height*0.05 ,
                                        decoration: BoxDecoration(
                                            color: AppColor.lightBlue,
                                            borderRadius: BorderRadius.circular(
                                                100)
                                        ),
                                        child: Center(
                                          child: AppText(
                                            title: 'GC',
                                            size: 14,

                                            fontWeight: FontWeight.w600,
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: Get.width * 0.04,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          AppText(
                                            title: "Grocery coupon",
                                            size: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.blackColor,
                                          ),

                                          AppText(
                                            title:  DateFormat("dd MMM yyyy").format(timestamp),
                                            size: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.greyLightColor2,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  AppText(
                                    title:  "\$${ Get.put(HomeController()).getProofList[index].amount
                                    .toString()
                                    }" ,
                                    size: 14,
                                    fontFamily: AppFont.regular,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.blackColor,
                                  ),

                                ],
                              ),
                            ),
                          );
                        });
                  }
                ),
                SizedBox(
                  height: Get.height * 0.06,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
