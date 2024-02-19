import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/bottom_sheet.dart';
import 'package:mr_bet/widgets/helper_function.dart';

import '../../../util/translation_keys.dart';


class UploadLegalView extends StatefulWidget {
  UploadLegalView({Key? key}) : super(key: key);

  @override
  State<UploadLegalView> createState() => _UploadLegalViewState();
}

class _UploadLegalViewState extends State<UploadLegalView> {
  final authController = Get.put(AuthController());
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
                          height: Get.height * 0.07,
                        ),
                        Row(
                          children: [
                            Image.asset("assets/icons/shape.png",
                              width: 8,
                              height: 14,
                            ),
                            SizedBox(width: 20,),
                            AppText(
                              title: uploadLegalDocuments.tr,
                              size: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColor.boldBlackColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 36,
                        ),
                        textAuth(text: termsOfService.tr,color: Colors.transparent),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(

                          hint: upload.tr,
                          isRead: true,
                          isCur: false,
                            isSuffix:true,

                          child: GestureDetector(
                              onTap: (){
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (builder) => bottomSheet(onCamera: () {
                                      Navigator.pop(context);
                                      HelperFunctions.pickImage(ImageSource.camera)
                                          .then((value) {
                                        setState(() {
                                          Get.put(AuthController()).fileService = value!;
                                          Get.put(AuthController()).termsService.text=value.path.split("/").last;
                                        });
                                      });
                                    }, onGallery: () {
                                      Navigator.pop(context);
                                      HelperFunctions.pickImage(ImageSource.gallery)
                                          .then((value) {
                                        setState(() {
                                          Get.put(AuthController()).fileService = value!;
                                          Get.put(AuthController()).termsService.text=value.path.split("/").last;
                                        });
                                      });
                                    }));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset("assets/icons/files.png",
                                height: 18,
                                  width: 18,
                                ),
                              )),
                          controller: authController.termsService,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        textAuth(text: refundAndReturnPolicy.tr,color: Colors.transparent),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(

                          hint:upload.tr ,
                          isRead: true,
                          isCur: false,
                          isSuffix:true,

                          child: GestureDetector(
                              onTap: (){
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (builder) => bottomSheet(onCamera: () {
                                      Navigator.pop(context);
                                      HelperFunctions.pickImage(ImageSource.camera)
                                          .then((value) {
                                        setState(() {
                                          Get.put(AuthController()).returnPolicy = value!;
                                          Get.put(AuthController()).returnPol.text=value.path.split("/").last;
                                        });
                                      });
                                    }, onGallery: () {
                                      Navigator.pop(context);
                                      HelperFunctions.pickImage(ImageSource.gallery)
                                          .then((value) {
                                        setState(() {
                                          Get.put(AuthController()).returnPolicy = value!;
                                          Get.put(AuthController()).returnPol.text=value.path.split("/").last;
                                        });
                                      });
                                    }));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset("assets/icons/files.png",
                                  height: 18,
                                  width: 18,
                                ),
                              )),
                          controller: authController.returnPol,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        textAuth(text: disputeResolution.tr,color: Colors.transparent),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(

                          hint: upload.tr,
                          isRead: true,
                          isCur: false,
                          isSuffix:true,

                          child: GestureDetector(
                              onTap: (){
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (builder) => bottomSheet(onCamera: () {
                                      Navigator.pop(context);
                                      HelperFunctions.pickImage(ImageSource.camera)
                                          .then((value) {
                                        setState(() {
                                          Get.put(AuthController()).dispute = value!;
                                          Get.put(AuthController()).disResol.text=value.path.split("/").last;
                                        });
                                      });
                                    }, onGallery: () {
                                      Navigator.pop(context);
                                      HelperFunctions.pickImage(ImageSource.gallery)
                                          .then((value) {
                                        setState(() {
                                          Get.put(AuthController()).dispute = value!;
                                          Get.put(AuthController()).disResol.text=value.path.split("/").last;
                                        });
                                      });
                                    }));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset("assets/icons/files.png",
                                  height: 18,
                                  width: 18,
                                ),
                              )),
                          controller: authController.disResol,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        textAuth(text: businessRegistrationInformation.tr,color: Colors.transparent),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        betField(

                          hint: upload.tr,
                          isRead: true,
                          isCur: false,
                          isSuffix:true,

                          child: GestureDetector(
                              onTap: (){
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (builder) => bottomSheet(onCamera: () {
                                      Navigator.pop(context);
                                      HelperFunctions.pickImage(ImageSource.camera)
                                          .then((value) {
                                        setState(() {
                                          Get.put(AuthController()).businessReg = value!;
                                          Get.put(AuthController()).busRegInformation.text=value.path.split("/").last;
                                        });
                                      });
                                    }, onGallery: () {
                                      Navigator.pop(context);
                                      HelperFunctions.pickImage(ImageSource.gallery)
                                          .then((value) {
                                        setState(() {
                                          Get.put(AuthController()).businessReg = value!;
                                          Get.put(AuthController()).busRegInformation.text=value.path.split("/").last;
                                          print(value.path.toString());
                                        });
                                      });
                                    }));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset("assets/icons/files.png",
                                  height: 18,
                                  width: 18,
                                ),
                              )),
                          controller: authController.busRegInformation,
                        ),
                        SizedBox(
                          height: 48,
                        ),
                        AppButton(
                            buttonWidth: Get.width,
                            buttonRadius: BorderRadius.circular(10),
                            buttonName: next.tr,
                            fontWeight: FontWeight.w500,
                            textSize:16,
                            buttonColor: AppColor.primaryColor,
                            textColor: AppColor.whiteColor,
                            onTap: () {
                              if(validateLegalRegister(context)){
                                authController.updateLoader(true);
                                ApiManger().storeCreate(context: context
                                );

                              }
                            }),

                      ],
                    ),
                  ),
                ),

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



  bool validateLegalRegister(BuildContext context) {


    if (Get.put(AuthController()).fileService==null) {
      flutterToast(msg: uploadTermsServices.tr);
      return false;
    }
    if (Get.put(AuthController()).returnPolicy==null) {
      flutterToast(msg: uploadReturnPolicies.tr);
      return false;
    }



    if (Get.put(AuthController()).dispute==null) {
      flutterToast(msg: uploadDisputeResolution.tr);
      return false;
    }

    if (Get.put(AuthController()).businessReg==null) {
      flutterToast(msg: uploadBusinessRegistrationInfo.tr);
      return false;
    }







    return true;
  }
}
