
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/vendor_home/controller/vendor_controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/drop_down.dart';
import 'package:mr_bet/widgets/helper_function.dart';
import 'package:mr_bet/widgets/image_pick.dart';

import '../../../../../util/translation_keys.dart';





class VendorSettings extends StatefulWidget {
  VendorSettings({Key? key}) : super(key: key);

  @override
  State<VendorSettings> createState() => _VendorSettingsState();
}

class _VendorSettingsState extends State<VendorSettings> {

  var nameController = TextEditingController();
  var occup = TextEditingController();
  var emailController = TextEditingController();
  var phone = TextEditingController();
  var provinceId;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < Get.put(AuthController()).provinceList.length; i++) {
      if((Get.put(VendorController()).profileAllData?.data?.province).toString()==Get.put(AuthController()).provinceList[i].id.toString()){
      }
    }
    nameController.text=Get.put(VendorController()
    ).name.value;
    emailController.text=Get.put(VendorController()).email.value;
    occup.text=(
        Get.put(VendorController()).profileAllData?.data?.occupation==null?"":
        Get.put(VendorController()).profileAllData?.data?.occupation).toString();
    phone.text=Get.put(VendorController()).phone.value;
    //provinceId=Get.put(VendorController()).profileAllData?.data?.province.toString();
  }



  @override
  Widget build(BuildContext context) {
    print(Get.put(VendorController()).profileAllData?.data?.province.toString());
    print(Get.put(VendorController()).profileAllData?.data?.province.toString());

    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Stack(
      children: [
        Scaffold(
          body: Column(
            children: [
              TopBar(onTap1: (){},onTap: (){
                Get.back();
              },text: accountSettings.tr,
                  image: "assets/icons/share.svg",color: AppColor.whiteColor
              ),


              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      GestureDetector(
                        onTap: (){
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (builder) => bottomSheet(onCamera: () {
                                Navigator.pop(context);
                                HelperFunctions.pickImage(ImageSource.camera)
                                    .then((value) {
                                  setState(() {
                                    Get.put(VendorController()).file=value
                                        ;
                                  });
                                });
                              }, onGallery: () {
                                Navigator.pop(context);
                                HelperFunctions.pickImage(ImageSource.gallery)
                                    .then((value) {
                                  setState(() {
                                    Get.put(VendorController()).file=value
                                    ;
                                  });
                                });
                              }));
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: Get.width,
                          height: 250,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColor.primaryColor)
                                ),
                                width: Get.width,
                                height: 216,
                                child: Center(
                                  child: Container(
                                    width: Get.width,

                                    decoration: const BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(0))),
                                    child: Get.find<VendorController>().file == null
                                        ? Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),

                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        child: Obx(
                                                () {
                                              return Image.network(
                                               ( Get.find<VendorController>().profileAllData?.data?.logo).toString(),
                                                width: Get.width,
                                                fit: Get.find<VendorController>().name.value.isEmpty?BoxFit.cover: BoxFit.cover,
                                                errorBuilder: (context, exception,
                                                    stackTrace) {
                                                  return ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    child: Image.asset(
                                                      "assets/icons/error.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                        ),
                                      ),
                                    )
                                        : Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        child: Image.file(
                                          Get.find<VendorController>().file as File,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 20,
                                  bottom: 5,
                                  child: Image.asset("assets/icons/icon.png",
                                    height: 56,
                                    width: 56,
                                  ))
                            ],
                          ),
                        ),
                      ),



                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            textAuth(text: fullName.tr),
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
                              controller: nameController,
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            textAuth(text: email.tr,color: Colors.transparent),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            betField(
                              hint:pleaseEnterEmail.tr,
                              isRead: true,
                              isCur: false,
                              controller: emailController,
                            ),

                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            textAuth(text: phoneNumber.tr,color: Colors.transparent),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            betField(
                                hint: phoneNumber.tr,
                                controller: phone,
                                textInputType: TextInputType.phone,
                                isRead: true,
                                isCur: false,
                                textInputAction: TextInputAction.next
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Row(
                              children: [

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      textAuth(text: province.tr,color: Colors.transparent),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Obx(
                                              () {
                                            return SizedBox(
                                              height: Get.height*0.055,
                                              child: dropDownButtons(
                                                  color: AppColor.borderColorField,
                                                  color1: AppColor.borderColorField,

                                                  contentPadding: EdgeInsets.zero,
                                                  color2:  AppColor.greyColors,

                                                  hinText: selectProvince.tr,
                                                  value: provinceId,
                                                  onChanged: (value) async {
                                                    setState(() {
                                                      provinceId=value;
                                                    });



                                                  },
                                                  items: countryDataList(
                                                      dataList: Get.put(AuthController())
                                                          .provinceList)),
                                            );
                                          }
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),

                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              isKeyBoard?SizedBox.shrink():
              Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.005,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                    child: AppButton(
                        buttonWidth: Get.width,
                        buttonRadius: BorderRadius.circular(10),
                        buttonName: updateProfileSettings.tr,


                        fontWeight: FontWeight.w500,
                        textSize: 15,
                        fontFamily: AppFont.medium,
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        onTap: () {
                          if(validateProfile(context)){
                            Get.put(VendorController()
                            ).updateLoader(true);
                            ApiManger().editStoreResponse(context: context,
                            name: nameController.text,
                              phone: phone.text,
                              province: provinceId.toString()
                            );

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
        ),
        Obx(() {
          return Get.put(VendorController()).loader.value == false
              ? SizedBox.shrink()
              : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black26,
            child:  Center(
                child: SpinKitThreeBounce(
                    size: 25, color: AppColor.blackColor)
            ),
          );



        })
      ],
    );
  }



  bool validateProfile(BuildContext context) {

    if (nameController.text.isEmpty) {
      flutterToast(msg: pleaseEnterName.tr);
      return false;
    }
    if (phone.text.isEmpty) {
      flutterToast(msg: pleaseEnterPhone.tr);
      return false;
    }






    return true;
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
}

