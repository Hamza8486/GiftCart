import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/app/auth/address.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/auth/login.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/drop_down.dart';
import 'package:mr_bet/widgets/helper_function.dart';
import 'package:mr_bet/widgets/image_pick.dart';


class UserStore extends StatefulWidget {
  UserStore({Key? key}) : super(key: key);

  @override
  State<UserStore> createState() => _UserStoreState();
}

class _UserStoreState extends State<UserStore> {
  final authController = Get.put(AuthController());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
                right: Get.width * 0.04,left: Get.width * 0.04),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.055,
                ),
                Row(
                  children: [
                    backButton(

                        onTap: () {
                          Get.back();
                        }),
                    SizedBox(
                      width: Get.width * 0.25,
                    ),
                    AppText(
                      title: addSTore.tr,
                      color: AppColor.blackColor,
                      size: AppSizes.size_18,
                      fontFamily: AppFont.semi,
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        textAuth(text: storeName.tr),
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
                          hint: enterStoreName.tr,
                          controller: authController.storeNameController,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: storeAddress.tr),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(
                            hint: enterStoreAddress.tr,
                            onTap:(){
                              Get.to(AddAddress());
                            },

                            controller: authController.addressController,
                            textInputType: TextInputType.streetAddress,
                            isRead: true,
                            isCur: false,
                            textInputAction: TextInputAction.next
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: province.tr),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Obx(
                                () {
                              return SizedBox(

                                child: dropDownButtons(
                                    color: AppColor.borderColorField,
                                    color1: AppColor.borderColorField,

                                    contentPadding: EdgeInsets.symmetric(vertical: Get.height*0.016),
                                    color2:  AppColor.greyColors,

                                    hinText:selectProvince.tr,
                                    value: authController.provinceId,
                                    onChanged: (value) async {
                                      setState(() {
                                        authController.provinceId=value;
                                      });



                                    },
                                    items: countryDataList(
                                        dataList: authController
                                            .provinceList)),
                              );
                            }
                        ),
                        SizedBox(
                          height: Get.height * 0.017,
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
                          height: Get.height * 0.017,
                        ),
                        textAuth(text: uploadStoreLogo.tr),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        DottedBorder(
                          strokeCap: StrokeCap.square,
                          color:Colors.grey.withOpacity(0.7),
                          dashPattern: [10, 7],
                          strokeWidth: 1.6,
                          child: MaterialButton(
                            minWidth: Get.width,
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (builder) => bottomSheet(onCamera: () {
                                    Navigator.pop(context);
                                    HelperFunctions.pickImage(ImageSource.camera)
                                        .then((value) {
                                      setState(() {
                                        Get.put(AuthController()).file = value!;
                                      });
                                    });
                                  }, onGallery: () {
                                    Navigator.pop(context);
                                    HelperFunctions.pickImage(ImageSource.gallery)
                                        .then((value) {
                                      setState(() {
                                        Get.put(AuthController()).file = value!;
                                      });
                                    });
                                  }));
                            },
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Get.put(AuthController()).file==null?20: 5),
                                child: Column(
                                  children: [
                                    Get.put(AuthController()).file==null?
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColor.greys,
                                              shape: BoxShape.circle
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset("assets/images/gal.png",
                                              height: Get.height*0.03,
                                            ),
                                          ) ,
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColor.redLight,
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child:Padding(
                                              padding:  EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                              child:   AppText(
                                                title: uploadStoreLogo.tr,
                                                size: AppSizes.size_10,
                                                color: AppColor.boldBlackColor,
                                                fontFamily: AppFont.medium,


                                              )
                                          ) ,
                                        ),
                                      ],
                                    ):
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        width: Get.width,
                                        height: Get.height*0.1,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColor.primaryColor,
                                              width: 2),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                  Get.put(AuthController()).file as File
                                              )),
                                        ),
                                        child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                Get.put(AuthController()).file=null;
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: Get.height * 0.15,
                                                  left: Get.width * 0.76),
                                              child: const Icon(
                                                Icons.cancel_outlined,
                                                color: Colors.red,
                                              ),
                                            )),
                                      ),
                                    )
                                    ,



                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.017,
                        ),
                        textAuth(text: uploadLicenseDoc.tr),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        ImagePick(
                          text:upload.tr,
                        ),

                        SizedBox(
                          height: Get.height * 0.012,
                        ),


                      ],
                    ),
                  ),
                ),
                isKeyBoard?SizedBox.shrink():
                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(10),
                        buttonName: addSTore.tr,
                        fontWeight: FontWeight.w500,
                        textSize: AppSizes.size_15,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap: () {

                          if(validateRegister(context)){
                            authController.updateLoader(true);
                            ApiManger().userStore(context: context);
                          }
                        }),
                    SizedBox(
                      height: Get.height * 0.01,
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

  List<DropdownMenuItem<int>> countryDataList({var dataList}) {
    List<DropdownMenuItem<int>> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(DropdownMenuItem<int>(
          value: dataList[i].id,
          child: AppText(
            title: dataList[i].name,
            size: AppSizes.size_15,
            color: AppColor.blackColor,
            fontFamily: AppFont.regular,
            fontWeight: FontWeight.w500,
          )));
    }
    return outputList;
  }
  bool validateRegister(BuildContext context) {


    if (Get.put(AuthController()).storeNameController.text.isEmpty) {
      flutterToast(msg: pleaseEnterStoreName.tr);
      return false;
    }
    if (Get.put(AuthController()).addressController.text.isEmpty) {
      flutterToast(msg: pleaseEnterStoreAddress.tr);
      return false;
    }

    if (Get.put(AuthController()).mobileController.text.isEmpty) {
      flutterToast(msg: pleaseEnterPhone.tr);
      return false;
    }
    if (Get.put(AuthController()).mobileController.text.length<9) {
      flutterToast(msg: enterValidPhone.tr);
      return false;
    }

    if (Get.put(AuthController()).provinceId==null) {
      flutterToast(msg: pleaseSelectProvince.tr);
      return false;
    }
    if (Get.put(AuthController()).file==null) {

      flutterToast(msg: pleaseUploadStoreLogo.tr);
      return false;
    }
    if (Get.put(AuthController()).file1==null) {
      flutterToast(msg: pleaseUploadStoreLicense.tr);
      return false;
    }








    return true;
  }
}
