import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';

import 'package:mr_bet/app/auth/partner_signup/upload_legal.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/bottom_sheet.dart';
import 'package:mr_bet/widgets/helper_function.dart';


class UpdateStore extends StatefulWidget {
  UpdateStore({Key? key}) : super(key: key);

  @override
  State<UpdateStore> createState() => _UpdateStoreState();
}

class _UpdateStoreState extends State<UpdateStore> {
  final authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.storeName.text=(
        Get.put(VendorController()).profileAllData?.data?.store?.name==null?"":
        Get.put(VendorController()).profileAllData?.data?.store?.name).toString();
    authController.storeDes.text=(
        Get.put(VendorController()).profileAllData?.data?.store?.description==null?"":
        Get.put(VendorController()).profileAllData?.data?.store?.description).toString();
    authController.storeNumber.text=(
        Get.put(VendorController()).profileAllData?.data?.store?.contact==null?"":
        Get.put(VendorController()).profileAllData?.data?.store?.contact).toString();
    authController.storeAddress.text=(
        Get.put(VendorController()).profileAllData?.data?.store?.address==null?"":
        Get.put(VendorController()).profileAllData?.data?.store?.address).toString();
  }


  @override
  Widget build(BuildContext context) {
    print(authController.emailRegController.text);
    print(authController.emailRegController.text);
    print(authController.emailRegController.text);
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.065,
                ),
                Row(
                  children: [
                    Image.asset("assets/icons/shape.png",
                      width: 8,
                      height: 14,
                    ),
                    SizedBox(width: 20,),
                    AppText(
                      title: storeInfoUpdate.tr,
                      size: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColor.boldBlackColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(
                          height: 26,
                        ),
                        textAuth(text: store_name.tr,color: Colors.red),
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
                          hint: store_name.tr,
                          controller: authController.storeName,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: store_description.tr,color: Colors.transparent),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(
                          hint: store_description.tr,
                          max: 3,
                          controller: authController.storeDes,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: contact.tr),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(
                            hint: contactNo.tr,
                            controller: authController.storeNumber,
                            textInputType: TextInputType.phone,
                            textInputAction: TextInputAction.done
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: storeAddress.tr),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(
                            hint: storeAddress.tr,
                            controller: authController.storeAddress,
                            textInputAction: TextInputAction.done

                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: uploadStoreLogo.tr),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        MaterialButton(
                          minWidth: Get.width,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color:AppColor.borderColorField),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (builder) => bottomSheet(onCamera: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.camera)
                                      .then((value) {
                                    setState(() {
                                      Get.put(AuthController()).storeLogoFile = value!;
                                    });
                                  });
                                }, onGallery: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.gallery)
                                      .then((value) {
                                    setState(() {
                                      Get.put(AuthController()).storeLogoFile = value!;
                                    });
                                  });
                                }));
                          },
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Get.put(AuthController()).file==null?20: 20),
                              child: Column(
                                children: [
                                  Get.put(AuthController()).storeLogoFile==null?
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
                                            padding:  EdgeInsets.symmetric(horizontal: 12,vertical:10),
                                            child:   AppText(
                                              title: uploadLogo.tr,
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
                                                Get.put(AuthController()).storeLogoFile as File
                                            )),
                                      ),
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              Get.put(AuthController()).storeLogoFile=null;
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
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        textAuth(text: uploadStoreBanner.tr),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        MaterialButton(
                          minWidth: Get.width,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color:AppColor.borderColorField),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (builder) => bottomSheet(onCamera: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.camera)
                                      .then((value) {
                                    setState(() {
                                      Get.put(AuthController()).storeBannerFile = value!;
                                    });
                                  });
                                }, onGallery: () {
                                  Navigator.pop(context);
                                  HelperFunctions.pickImage(ImageSource.gallery)
                                      .then((value) {
                                    setState(() {
                                      Get.put(AuthController()).storeBannerFile = value!;
                                    });
                                  });
                                }));
                          },
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Get.put(AuthController()).storeBannerFile==null?20: 5),
                              child: Column(
                                children: [
                                  Get.put(AuthController()).storeBannerFile==null?
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
                                              title: uploadBanner.tr,
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
                                                Get.put(AuthController()).storeBannerFile as File
                                            )),
                                      ),
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              Get.put(AuthController()).storeBannerFile=null;
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
                        )

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
                        buttonName: updateNow.tr,
                        fontWeight: FontWeight.w500,
                        textSize:16,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          if(validateBusiness(context)){
                            authController.updateLoader(true);
                            ApiManger().updateStore(context: context
                            );
                          }


                        }),

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



  bool validateBusiness(BuildContext context) {


    if (Get.put(AuthController()).storeName.text.isEmpty) {
      flutterToast(msg: pleaseEnterStoreName.tr);
      return false;
    }
    if (Get.put(AuthController()).storeDes.text.isEmpty) {
      flutterToast(msg: enterStoreDescription.tr);
      return false;
    }
    if (Get.put(AuthController()).storeNumber.text.isEmpty) {
      flutterToast(msg: enterStorePhone.tr);
      return false;
    }
    if (Get.put(AuthController()).storeNumber.text.length<9) {
      flutterToast(msg:enterValidPhone.tr);
      return false;
    }
    if (Get.put(AuthController()).storeAddress.text.isEmpty) {
      flutterToast(msg: pleaseEnterStoreAddress.tr);
      return false;
    }

    return true;
  }
}
