// ignore_for_file: must_be_immutable

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/auth/component.dart';
import 'package:giftcart/app/auth/controller.dart';
import 'package:giftcart/services/api_manager.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/widgets/app_button.dart';
import 'package:giftcart/widgets/app_text.dart';
import 'package:giftcart/widgets/app_textfield.dart';

import '../../../../util/translation_keys.dart';

class ResetView extends StatelessWidget {
  ResetView({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPaddings.mainPadding,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                        onTap: () {
                          Get.back();
                          authController.clear();
                          authController.clearForget();
                        },
                        child: Image.asset("assets/icons/backs.png",
                          height: 30,
                          width: 30,
                          color: Colors.black,
                        ))),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                AppText(
                  title: forgotnPassword.tr,
                  size: AppSizes.size_22,
                  fontFamily: AppFont.semi,
                  color: AppColor.boldBlackColor,
                ),
                SizedBox(
                  height: Get.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AppText(
                    title:"Enter your email ID associated with your account and we’ll send on email for reset your password",
                    size: AppSizes.size_13,
                    fontFamily: AppFont.regular,
                    textAlign: TextAlign.justify,
                    color: AppColor.textGreyColor,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.025,
                ),
                textAuth(text: email.tr),
                SizedBox(
                  height: Get.height * 0.012,
                ),
                AppTextField(
                  isborderline: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  isborderline2: true,
                  validator: (value) => EmailValidator.validate(value!)
                      ? null
                      : pleaseEnterValidEmail.tr,
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.04,
                      vertical: Get.height * 0.0185),
                  borderRadius: BorderRadius.circular(10),
                  borderRadius2: BorderRadius.circular(10),
                  borderColor: AppColor.borderColorField,
                  hint: email.tr,
                  hintColor: AppColor.blackColor,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  hintSize: AppSizes.size_12,
                  controller: authController.emailForgetController,
                  fontFamily: AppFont.medium,
                  borderColor2: AppColor.primaryColor,
                  maxLines: 1,
                ),
                SizedBox(
                  height: Get.height * 0.06,
                ),
                Obx(() {
                  return authController.loaderForget.value
                      ? Center(
                          child: SpinKitThreeBounce(
                              size: 25, color: AppColor.primaryColor))
                      : AppButton(
                          buttonWidth: Get.width,
                          buttonRadius: BorderRadius.circular(10),
                          buttonName: "Continue",
                          buttonColor: AppColor.primaryColor,
                          textColor: AppColor.whiteColor,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              authController.updateForgetLoader(true);
                              ApiManger().forgetResponse(
                                  context: context,
                                  email: authController
                                      .emailForgetController.text);

                              return;
                            }
                          });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
