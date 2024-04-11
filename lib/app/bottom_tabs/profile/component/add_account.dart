import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/auth/component.dart';
import 'package:giftcart/app/bottom_tabs/component/component.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';
import 'package:giftcart/services/api_manager.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/util/toast.dart';
import 'package:giftcart/util/translation_keys.dart';
import 'package:giftcart/widgets/app_button.dart';

class AddAccounts extends StatefulWidget {
  const AddAccounts({Key? key}) : super(key: key);

  @override
  State<AddAccounts> createState() => _AddAccountsState();
}

class _AddAccountsState extends State<AddAccounts> {
  var name = TextEditingController();
  var transitNum = TextEditingController();
  var instNum = TextEditingController();
  var address = TextEditingController();
  var number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Stack(
      children: [
        Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  TopBar(
                      onTap1: () {},
                      onTap: () {
                        Get.back();
                      },
                      text: "Add Bank Accounts",
                      image: "assets/icons/share.svg",
                      color: AppColor.whiteColor),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            textAuth(text: 'Card Holder Name'),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            betField(
                              hint: "Card Holder Name",

                              controller: name,
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            textAuth(text: 'Account Number'),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            betField(
                                hint: 'Account Number',
                                controller: number,
                                textInputType: TextInputType.phone,
                                listInputParam: [
                                  LengthLimitingTextInputFormatter(
                                      18),
                                ],
                                textInputAction: TextInputAction.done),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            textAuth(text: "Transit Number"),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            betField(
                                hint: "Transit Number",
                                controller: transitNum,
                                listInputParam: [
                                  LengthLimitingTextInputFormatter(
                                      11),
                                ],
                                textInputType: TextInputType.phone),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            textAuth(text: "Institution number"),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            betField(
                                hint: "Institution number",
                                controller: instNum,
                                listInputParam: [
                                  LengthLimitingTextInputFormatter(11),
                                ], // Limit input length programmatically

                                textInputType: TextInputType.phone),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            textAuth(text: "Address"),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            betField(
                                hint: "Address",
                                controller: address,
                                textInputType: TextInputType.streetAddress,
                                textInputAction: TextInputAction.done),
                          ],
                        ),
                      ),
                    ),
                  ),
                  isKeyBoard
                      ? SizedBox.shrink()
                      : Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.005,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.04),
                              child: AppButton(
                                  buttonWidth: Get.width,
                                  buttonRadius: BorderRadius.circular(10),
                                  buttonName: add.tr,
                                  fontWeight: FontWeight.w500,
                                  textSize: AppSizes.size_14,
                                  fontFamily: AppFont.medium,
                                  buttonColor: AppColor.primaryColor,
                                  textColor: AppColor.whiteColor,
                                  onTap: () {
                                    if (validateAccount(context)) {
                                      Get.put(HomeController())
                                          .updateLoader(true);
                                      ApiManger().addBank1(
                                          userName: name.text,
                                          transit: transitNum.text,
                                          account: number.text,
                                          address: address.text,
                                          instNum: instNum.text);
                                    }
                                  }),
                            ),
                            SizedBox(
                              height: Get.height * 0.012,
                            ),
                          ],
                        )
                ],
              ),
              Positioned(
                  top: Get.height * 0.057,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: Get.height * 0.045,
                      width: Get.height * 0.045,
                      decoration: BoxDecoration(
                          color: AppColor.transParent,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Get.height * 0.1))),
                      child: Icon(
                        Icons.add,
                        color: AppColor.transParent,
                        size: AppSizes.size_20,
                      ),
                    ),
                  ))
            ],
          ),
        ),
        Obx(() {
          return Get.put(HomeController()).loader.value == false
              ? SizedBox.shrink()
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black26,
                  child: Center(
                      child: SpinKitThreeBounce(
                          size: 25, color: AppColor.primaryColor)),
                );
        })
      ],
    );
  }

  bool validateAccount(BuildContext context) {
    if (name.text.isEmpty) {
      flutterToast(msg: "Enter card holder name");
      return false;
    }

    if (number.text.isEmpty) {
      flutterToast(msg: "Enter account number");
      return false;
    }
    if (transitNum.text.isEmpty) {
      flutterToast(msg: "Enter transit number");
      return false;
    }
    if (number.text.isEmpty) {
      flutterToast(msg: "Enter institution number");
      return false;
    }
    if (number.text.isEmpty) {
      flutterToast(msg: "Enter address");
      return false;
    }

    return true;
  }
}
