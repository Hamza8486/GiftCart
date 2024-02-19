import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/component/add_acc.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';

class PaymentsView extends StatefulWidget {
  PaymentsView({Key? key, this.type}) : super(key: key);

  var type;

  @override
  State<PaymentsView> createState() => _PaymentsViewState();
}

class _PaymentsViewState extends State<PaymentsView> {
  final vendorController = Get.put(VendorController());
  String type = "Pending";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              TopBar(
                Child: widget.type != "true" ? SizedBox.shrink() : null,
                onTap1: () {},
                onTap: () {
                  Get.back();
                },
                text: payments.tr,
                image: "assets/icons/share.svg",
                color: AppColor.whiteColor,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Container(
                        height: 123,
                        decoration: BoxDecoration(
                            gradient: AppColor.Home_GRADIENT,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.04, vertical: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() {
                                    return vendorController.loaderProfile.value
                                        ? AppText(
                                            title: "\$0",
                                            fontWeight: FontWeight.w700,
                                            size: 24,
                                            color: AppColor.whiteColor,
                                          )
                                        : AppText(
                                            title:
                                                "\$${(vendorController.profileAllData?.data?.store == null ? "0" : vendorController.profileAllData?.data?.store?.balance).toString()}",
                                            fontWeight: FontWeight.w700,
                                            size: 24,
                                            color: AppColor.whiteColor,
                                          );
                                  }),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  AppText(
                                    title: balanceDue.tr,
                                    fontWeight: FontWeight.w400,
                                    size: 14,
                                    color: AppColor.whiteColor,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(VendorAddAccounts());
                                },
                                child: Container(
                                  width: 140,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: AppColor.whiteColor),
                                  ),
                                  child:  Center(
                                    child: AppText(
                                      title: updateAccount.tr,
                                      fontWeight: FontWeight.w500,
                                      size: 12,
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      AppText(
                        title: paymentTransactions.tr,
                        fontWeight: FontWeight.w500,
                        size: 14,
                        color: AppColor.blackColor,
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                type = "Pending";
                              });
                            },
                            child: Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColor.primaryColor),
                                  color: type == "Pending"
                                      ? AppColor.primaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: AppText(
                                  title: pending.tr,
                                  size: 12,
                                  fontWeight: FontWeight.w500,
                                  color: type == "Pending"
                                      ? Colors.white
                                      : AppColor.blackColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.05,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                type = "Accepted";
                              });
                            },
                            child: Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColor.primaryColor),
                                  color: type == "Accepted"
                                      ? AppColor.primaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: AppText(
                                  title: completed.tr,
                                  size: 12,
                                  fontWeight: FontWeight.w500,
                                  color: type == "Accepted"
                                      ? Colors.white
                                      : AppColor.blackColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Obx(() {
                          return Get.put(VendorController())
                                  .allPaymentLoader
                                  .value
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                    ),
                                    Center(
                                        child: SpinKitThreeBounce(
                                            size: 25,
                                            color: AppColor.primaryColor)),
                                  ],
                                )
                              : Get.put(VendorController()).getProofList.isEmpty
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.2,
                                        ),
                                        Center(
                                            child: AppText(
                                          title: noTransactionData.tr,
                                          color: AppColor.blackColor
                                              .withOpacity(0.7),
                                          size: 16,
                                          fontWeight: FontWeight.w500,
                                        ))
                                      ],
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      physics: const BouncingScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: Get.put(VendorController())
                                          .getProofList
                                          .where((p0) => p0.status == type)
                                          .toList()
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        DateTime time = DateTime.parse(
                                          Get.put(VendorController())
                                              .getProofList
                                              .where((p0) => p0.status == type)
                                              .toList()[index]
                                              .createdAt
                                              .toString(),
                                        );
                                        return GestureDetector(
                                          onTap: () {
                                            // Get.to(const OrderDetail());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xffF65356)
                                                            .withOpacity(0.1),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                color: Colors.white,
                                              ),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 13),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    Get.width *
                                                                        0.03),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        Get.width *
                                                                            0.017),
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
                                                                          title:
                                                                              "Invoice no - #000${Get.put(VendorController()).getProofList.where((p0) => p0.status == type).toList()[index].id.toString()} ",
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          size:
                                                                              14,
                                                                          color:
                                                                              AppColor.blackColor,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              Get.height * 0.005,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            AppText(
                                                                              title: Get.put(VendorController()).getProofList.where((p0) => p0.status == type).toList()[index].status == "Pending" ? "Settled  " : "Settlement date - ",
                                                                              fontWeight: FontWeight.w500,
                                                                              size: 12,
                                                                              color: type != "Pending" ? Colors.green : AppColor.greyLightColor2,
                                                                            ),
                                                                            AppText(
                                                                              title: "${DateFormat('MMM dd, yyyy').format(time)} ",
                                                                              fontWeight: FontWeight.w500,
                                                                              size: 12,
                                                                              color: AppColor.primaryColor,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              Get.height * 0.005,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            AppText(
                                                                              title: "TRXN ",
                                                                              fontWeight: FontWeight.w500,
                                                                              size: 12,
                                                                              color: AppColor.blackColor,
                                                                            ),
                                                                            AppText(
                                                                              title: "TRXN Date(${DateFormat('MMM dd, yyyy').format(time)} )",
                                                                              fontWeight: FontWeight.w500,
                                                                              size: 12,
                                                                              color: AppColor.greyLightColor2,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        AppText(
                                                                          title:
                                                                              "\$${Get.put(VendorController()).getProofList.where((p0) => p0.status == type).toList()[index].amount.toString()}",
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          size:
                                                                              16,
                                                                          color:
                                                                              AppColor.blackColor,
                                                                        ),
                                                                        // SizedBox(height: Get.height*0.005,),
                                                                        //  Container(
                                                                        //    decoration: BoxDecoration(
                                                                        //      border: Border.all(color: AppColor.primaryColor),
                                                                        //      borderRadius: BorderRadius.circular(10)
                                                                        //    ),
                                                                        //    child: const Padding(
                                                                        //      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                                        //      child: AppText(
                                                                        //       title:
                                                                        //
                                                                        //       "info",
                                                                        //
                                                                        //       fontWeight: FontWeight.w500,
                                                                        //       size: 12,
                                                                        //       color: AppColor.primaryColor,
                                                                        // ),
                                                                        //    ),
                                                                        //  ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                        }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ))
            ])),
        Positioned(
            top: Get.height * 0.058,
            right: 20,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    isDismissible: true,
                    context: context,
                    builder: (context) => infoPaymentWidget());
              },
              child: Image.asset(
                "assets/icons/info.png",
                height: 25,
                width: 25,
              ),
            )),
      ],
    );
  }
}

class UpdateBankAccount extends StatefulWidget {
  const UpdateBankAccount({super.key});

  @override
  State<UpdateBankAccount> createState() => _UpdateBankAccountState();
}

class _UpdateBankAccountState extends State<UpdateBankAccount> {
  bool stripe = false;

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return DraggableScrollableSheet(
      initialChildSize: isKeyBoard ? 0.9 : 0.75,
      minChildSize: isKeyBoard ? 0.9 : 0.75,
      maxChildSize: isKeyBoard ? 0.9 : 0.75,
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
                height: Get.height * 0.03,
              ),
               AppText(
                  title: updateBankAcc.tr,
                  size: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackColor),
              SizedBox(
                height: Get.height * 0.04,
              ),
              textAuth(text: accountNumber.tr, color: Colors.transparent),
              SizedBox(
                height: Get.height * 0.01,
              ),
              betField(
                  hint: yourAccountHere.tr,
                  max: 1,
                  textInputAction: TextInputAction.done),
              SizedBox(
                height: Get.height * 0.015,
              ),
              textAuth(text: "IFSC code", color: Colors.transparent),
              SizedBox(
                height: Get.height * 0.01,
              ),
              betField(
                  hint: typeHere.tr,
                  max: 1,
                  textInputAction: TextInputAction.done),
              SizedBox(
                height: Get.height * 0.015,
              ),
              textAuth(text:bankName.tr, color: Colors.transparent),
              SizedBox(
                height: Get.height * 0.01,
              ),
              betField(
                  hint:typeHere.tr,
                  max: 1,
                  textInputAction: TextInputAction.done),
              SizedBox(
                height: Get.height * 0.015,
              ),
              textAuth(text: nameOnAccount.tr, color: Colors.transparent),
              SizedBox(
                height: Get.height * 0.01,
              ),
              betField(
                  hint: yourNameHere.tr,
                  max: 1,
                  textInputAction: TextInputAction.done),
              Spacer(),
              AppButton(
                buttonWidth: Get.width,
                buttonRadius: BorderRadius.circular(10),
                buttonName: updateBankAcc.tr,
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

Widget infoPaymentWidget() {
  return DraggableScrollableSheet(
    initialChildSize: 0.7,
    minChildSize: 0.7,
    maxChildSize: 0.7,
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
              height: Get.height * 0.03,
            ),
             AppText(
                title: infoAboutPayments.tr,
                size: 20,
                fontWeight: FontWeight.w600,
                color: AppColor.blackColor),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  primary: false,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          AppText(
                              title: "${index + 1} - ",
                              size: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.blackColor),
                          AppText(
                              title: clearExpDateForeachCoupon.tr,
                              size: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.blackColor),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ),
  );
}
