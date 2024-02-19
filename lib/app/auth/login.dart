import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/account_type.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/auth/forget/view/forget_password.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key,this.email,this.pass,this.login}) : super(key: key);
  var email;
  var pass;
  var login;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final authController = Get.put(AuthController());

  var emailController = TextEditingController();

  var pass = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? token;
  void getToken() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    log(token.toString());
  }

  @override
  void initState() {
    super.initState();

    widget.email==null?"":
    widget.email=emailController.text;
    widget.pass==null?"":
    widget.pass

    =pass.text;

    getToken();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.email.toString());
    print(widget.pass.toString());
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return WillPopScope(
      onWillPop: () {
        // Check the condition and return the appropriate value
        if (widget.login == "true") {
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Stack(
        children: [
          Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Get.height * 0.08,
                            ),
                            AppText(
                              title: welcomeBack.tr,
                              size: 24,
                              fontWeight: FontWeight.w600,
                              color: AppColor.boldBlackColor,
                            ),
                            AppText(
                              title:  signInToContinue.tr,
                              size: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.greyLightColor2,
                            ),
                            SizedBox(
                              height: 48,
                            ),


                            textAuth(text:  email.tr, color: Colors.transparent),
                            SizedBox(
                              height: Get.height * 0.013,
                            ),
                            betField(
                              validator: (value) => EmailValidator.validate(value!)
                                  ? null
                                  :  pleaseEnterValidEmail.tr,
                              hint: "Example@gmail.com",
                              onChange: (val) {
                                setState(() {});
                              },
                              controller: Get.put(AuthController()).emailRegController,
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            textAuth(text:  password.tr, color: Colors.transparent),
                            SizedBox(
                              height: Get.height * 0.013,
                            ),
                            Obx(() {
                              return betField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return  enterPassword.tr;
                                  }

                                  return null;
                                },
                                hint:  password.tr,
                                textInputType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                obscure: authController.isVisible.value,
                                controller: Get.put(AuthController()).passRegController,
                                child: IconButton(
                                    onPressed: () {
                                      authController.updateVisibleStatus();
                                    },
                                    icon: Icon(
                                        authController.isVisible.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        size: Get.height * 0.022,
                                        color: AppColor.blackColor)),
                              );
                            }),
                            SizedBox(
                              height: Get.height * 0.015,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  authController.clear();
                                  authController.clearForget();
                                  Get.to(ResetView());
                                },
                                child: AppText(
                                  title:  forgotPassword.tr,
                                  size: 14,
                                  fontFamily: AppFont.medium,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 48,
                            ),
                            AppButton(
                                buttonWidth: Get.width,
                                buttonRadius: BorderRadius.circular(10),
                                buttonName:  signIn.tr,
                                fontWeight: FontWeight.w500,
                                textSize: 16,
                                gard: true,
                                buttonColor: AppColor.primaryColor,
                                textColor: AppColor.whiteColor,
                                onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          Get.put(AuthController()).upddateEmailVerrify(emailController.text);
                                          authController.updateLoginLoader(true);
                                          ApiManger().loginResponse(
                                              context: context,
                                              email: Get.put(AuthController()).emailRegController.text,
                                              password: Get.put(AuthController()).passRegController.text,
                                              token: token.toString());
                                        }
                                        //  Get.to(Home());
                                      }),
                            SizedBox(
                              height: 36,
                            ),
                            Center(
                              child: AppText(
                                title: signInUsing.tr,
                                size: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.boldBlackColor,
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            Container(
                              width: Get.width,
                              height: 53,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: SvgPicture.asset(
                                      "assets/icons/google.svg")),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  isKeyBoard?SizedBox.shrink():
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(AccountType());
                        authController.clear();
                        authController.clearForget();
                      },
                      child: Padding(
                        padding:  EdgeInsets.only(bottom: 32),
                        child: RichText(
                          text: TextSpan(
                            text:  dontHaveAcc.tr,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w500,
                                fontSize: AppSizes.size_15),
                            children: <TextSpan>[
                              TextSpan(
                                  text:  signUp.tr,
                                  style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontFamily: AppFont.semi,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppSizes.size_15)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            return authController.loaderLogin.value == false
                ? SizedBox.shrink()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black.withOpacity(0.7),
                    child: Center(
                        child: SpinKitThreeBounce(
                            size: 25, color: AppColor.primaryColor)),
                  );
          })
        ],
      ),
    );
  }
}
