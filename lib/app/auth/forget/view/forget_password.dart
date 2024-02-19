// ignore_for_file: must_be_immutable

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/app_textfield.dart';

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
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: Get.height * 0.035,
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
                  height: Get.height * 0.025,
                ),
                AppText(
                  title:enterEmailAssociateText.tr,
                  size: AppSizes.size_13,
                  fontFamily: AppFont.regular,
                  textAlign: TextAlign.justify,
                  color: AppColor.textGreyColor,
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
                          buttonName: next.tr,
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
