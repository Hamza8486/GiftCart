import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/auth/forget/view/otp.dart';
import 'package:mr_bet/app/auth/login.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';


class BasicInformation extends StatefulWidget {
  BasicInformation({Key? key}) : super(key: key);

  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  final authController = Get.put(AuthController());
  bool isCheck=false;

  final formKey = GlobalKey<FormState>();
  String? provinceName;
  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.08,
                        ),
                        AppText(
                          title: createAccount.tr,
                          size: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColor.boldBlackColor,
                        ),
                        AppText(
                          title: signUpText.tr,
                          size: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.greyLightColor2,
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        textAuth(text: fullName.tr,color: Colors.red),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return null;
                            }
                            if (!RegExp("[a-zA-Z]").hasMatch(value)) {
                              return null;
                            }
                            return null;
                          },
                          hint: "alexandra daddario",
                          controller: authController.fullNameController,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: email.tr),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField( validator: (value) => EmailValidator.validate(value!)
                            ? null
                            : pleaseEnterValidEmail.tr,
                          hint: "Example@gmail.com",
                          controller: authController.emailRegController,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: phoneNumber.tr),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(
                            hint: phoneNumber.tr,
                            controller: authController.mobileController,
                            textInputType: TextInputType.phone,
                            textInputAction: TextInputAction.next
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: province.tr),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        SizedBox(
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
                                for (int i = 0; i < Get.put(AuthController()).provinceList.length; i++) {
                                  if (value.toString() ==
                                      Get.put(AuthController()).provinceList[i].id.toString()) {
                                    Get.put(AuthController())
                                        .updateNameProv(Get.put(AuthController()).provinceList[i].name);
                                  }
                                }

                                authController.provinceId = value;


                              });
                            },
                            constraints: BoxConstraints(
                                minWidth: Get.height * 0.6,
                                maxWidth: Get.height * 0.6,
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
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.blackColor.withOpacity(0.4),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() {
                                      return SizedBox(
                                        width: Get.width*0.22,
                                        child: AppText(
                                            overFlow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            title:Get.put(AuthController())
                                                .nameProvince
                                                .value
                                                .isEmpty
                                                ?province.tr:Get.put(AuthController())
                                                .nameProvince
                                                .value,
                                            color:
                                            Get.put(AuthController())
                                                .nameProvince
                                                .value
                                                .isEmpty?
                                            AppColor.greyColors:
                                            AppColor.blackColor,
                                            fontWeight:
                                            Get.put(AuthController())
                                                .nameProvince
                                                .value
                                                .isEmpty
                                                ?
                                            FontWeight.w400:FontWeight.w500,

                                            size:
                                            Get.put(AuthController())
                                                .nameProvince
                                                .value
                                                .isEmpty
                                                ?14:15

                                        ),
                                      );
                                    }),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/downs.svg",
                                      height: Get.height * 0.01,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),



                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        textAuth(text: password.tr),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        Obx(() {
                          return betField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return enterPassword.tr;
                              }
                              // if(value.length<8)
                              // {
                              //   return 'Password must be greater then 8 character';
                              // }
                              return null;
                            },
                            hint: password.tr,
                            textInputType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            obscure: authController.isVisible1.value,
                            controller: authController.passRegController,
                            child:    IconButton(
                                onPressed: () {
                                  authController.updateVisible1Status();
                                },
                                icon: Icon(
                                    authController.isVisible1.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: Get.height * 0.022,
                                    color: AppColor.blackColor)),
                          );
                        }),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: (){setState(() {
                            if(isCheck){
                              isCheck=false;
                            }
                            else{
                              isCheck=true;
                            }
                          });},
                          child: Container(

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height:22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                    color:
                                    isCheck==true?
                                    AppColor.boldBlackColor:Colors.transparent,
                                    border: Border.all(color: AppColor.boldBlackColor),
                                    borderRadius: BorderRadius.circular(5),

                                  ),
                                  child: Center(
                                    child: Icon(Icons.check,
                                      color:

                                      Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      title: iAgreeeToThe.tr,
                                      size: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff3E444D),
                                    ),
                                    AppText(
                                      title: privacyPolicy.tr,
                                      size: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.blueColor,
                                    ),
                                  ],
                                ),
                                AppText(
                                  title: termsConditions.tr,
                                  size: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blueColor,
                                ),
                                AppText(
                                  title: and.tr,
                                  size: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff3E444D),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),


                      ],
                    ),
                  ),
                ),
                isKeyBoard?SizedBox.shrink():
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(10),
                        buttonName: signUp.tr,
                        fontWeight: FontWeight.w500,
                        textSize:16,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          authController.getProvinceData();
                          print(authController.provinceId.toString());
                          if(validateRegister(context)){
                            if(isCheck==true){
                              authController.updateLoader(true);
                              ApiManger().registerBusinessResponse(context: context);
                            }
                            else{
                              flutterToast(msg: acceptTermsText.tr);
                            }


                          }

                        }),
                    SizedBox(
                      height: Get.height * 0.016,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.offAll(LoginView());
                          Get.put(AuthController()).clear();

                        },
                        child: RichText(
                          text: TextSpan(
                            text: alreadyHaveAnAccount.tr,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontFamily: AppFont.medium,
                                fontWeight: FontWeight.w400,
                                fontSize:14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: signIn.tr,
                                  style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontFamily: AppFont.medium,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Obx(() {
          return authController.loader.value == false
              ? SizedBox.shrink()
              : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.7),
            child:   Center(
                child: SpinKitThreeBounce(
                    size: 25, color: AppColor.primaryColor)
            ),
          );



        })
      ],
    );
  }



  bool validateRegister(BuildContext context) {


    if (Get.put(AuthController()).fullNameController.text.isEmpty) {
      flutterToast(msg: pleaseEnterName.tr);
      return false;
    }
    if (Get.put(AuthController()).emailRegController.text.isEmpty) {
      flutterToast(msg: pleaseEnterEmail.tr);
      return false;
    }
    if (Get.put(AuthController()).mobileController.text.isEmpty) {
      flutterToast(msg:pleaseEnterPhone.tr);
      return false;
    }
    if (Get.put(AuthController()).mobileController.text.length<9) {
      flutterToast(msg: enterValidPhone.tr);
      return false;
    }

    if (Get.put(AuthController()).provinceId==null) {
      flutterToast(msg: selectProvince.tr);
      return false;
    }

    if (Get.put(AuthController()).passRegController.text.isEmpty) {
      flutterToast(msg: enterPassword.tr);
      return false;
    }

    if (Get.put(AuthController()).passRegController.text.length<7) {
      flutterToast(msg:errPassword7Digit.tr);
      return false;
    }







    return true;
  }
}
