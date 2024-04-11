import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/component/verification.dart';
import 'package:image_picker/image_picker.dart';
import 'package:giftcart/app/auth/component.dart';
import 'package:giftcart/app/bottom_tabs/component/component.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';
import 'package:giftcart/services/api_manager.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/util/toast.dart';
import 'package:giftcart/util/translation_keys.dart';
import 'package:giftcart/widgets/app_button.dart';
import 'package:giftcart/widgets/app_text.dart';
import 'package:giftcart/widgets/bottom_sheet.dart';
import 'package:giftcart/widgets/helper_function.dart';
import 'package:video_player/video_player.dart';

class ClaimView extends StatefulWidget {
  const ClaimView({Key? key}) : super(key: key);

  @override
  State<ClaimView> createState() => _ClaimViewState();
}

class _ClaimViewState extends State<ClaimView> {
  String? valueDrop;

  VideoPlayerController? _videoController;
  String? selectedVideoPath;

  var nameController = TextEditingController();
  var phoneCon = TextEditingController();
  var addressController = TextEditingController();
  var emailCon = TextEditingController();
  var idController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoController = VideoPlayerController.asset(""); //
    nameController.text = Get.put(HomeController()).name.value.toString();
    phoneCon.text = Get.put(HomeController()).phone.value.toString();
    emailCon.text = Get.put(HomeController()).email.value.toString();
    setState(() {});
  }

  bool isCompressing = false;

  Future<void> pickVideo() async {
    XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    double videoDuration = await getVideoDuration(video.path);

    if (videoDuration > 15) {
      flutterToast(msg: pleaseSelectVideo15Orless.tr);
    } else {
      setState(() {
        selectedVideoPath = video.path;
        Get.put(HomeController()).videoFile = video;
        flutterToast(msg: videoSelected.tr);
      });
    }
  }

  Future<double> getVideoDuration(String videoPath) async {
    VideoPlayerController videoController =
        VideoPlayerController.file(File(videoPath));
    await videoController.initialize();
    double duration = videoController.value.duration.inSeconds.toDouble();
    await videoController.dispose();
    return duration;
  }

  @override
  void dispose() {
    _videoController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Stack(
      children: [
        Scaffold(
          body: Column(
            children: [
              TopBar(
                  onTap1: () {},
                  onTap: () {
                    Get.back();
                  },
                  text: claim.tr,
                  image: "assets/icons/share.svg",
                  color: AppColor.whiteColor),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        AppText(
                          title: fillDetailsToGetReward.tr,
                          size: AppSizes.size_14,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w500,
                          color: AppColor.boldBlackColor.withOpacity(0.8),
                        ),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: betField(
                                  isSuffix: false,
                                  hint: fullName.tr,
                                  controller: nameController),
                            ),
                            SizedBox(
                              width: Get.width * 0.04,
                            ),
                            Expanded(
                              child: betField(
                                controller: phoneCon,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                isSuffix: false,
                                hint: phoneNumber.tr,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: betField(
                                  isSuffix: false,
                                  controller: idController,
                                  hint: bcId.tr,
                                  textInputType: TextInputType.text,
                                  textInputAction: TextInputAction.next),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        betField(
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            isSuffix: false,
                            hint: address.tr,
                            controller: addressController),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        betField(
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          isRead: true,
                          isCur: false,
                          controller: emailCon,
                          isSuffix: false,
                          hint: emailAddress,
                        ),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        AppText(
                          title: uploadYourPictureNReactionVideo.tr,
                          size: AppSizes.size_14,
                          fontFamily: AppFont.medium,
                          fontWeight: FontWeight.w400,
                          color: AppColor.boldBlackColor.withOpacity(0.8),
                        ),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap:(){
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (builder) =>
                                          bottomSheet(onCamera: () {
                                            Navigator.pop(context);
                                            HelperFunctions.pickImage(
                                                ImageSource.camera)
                                                .then((value) {
                                              setState(() {
                                                Get.put(HomeController())
                                                    .claimProfile =
                                                value!;
                                              });
                                            });
                                          }, onGallery: () {
                                            Navigator.pop(context);
                                            HelperFunctions.pickImage(
                                                ImageSource.gallery)
                                                .then((value) {
                                              setState(() {
                                                Get.put(HomeController())
                                                    .claimProfile =
                                                value!;
                                              });
                                            });
                                          }));
                                },
                                child: Container(
                                  height:110,
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Color(0xffD8D8D8))
                                ),
                                child:
                                Get.put(HomeController()).claimProfile !=
                                    null?
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      Get.put(HomeController()).claimProfile =
                                      null;
                                    });
                                  },
                                  child: SizedBox(
                                    height: Get.put(HomeController())
                                        .image
                                        .value
                                        .isNotEmpty
                                        ? Get.height * 0.15
                                        : Get.height * 0.17,
                                    width: Get.height * 0.17,
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: Get.width,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            child: Image.file(
                                              Get.put(HomeController())
                                                  .claimProfile as File,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            right: 10,
                                            top: 8,
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                color: AppColor.primaryColor,
                                                borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Icon(
                                                Icons.cancel_rounded,
                                                size: 20,
                                                color: AppColor.whiteColor,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ):

                                  Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/icons/gallery1.png",
                                    height: 40,
                                      width: 40,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    AppText(
                                      title: "Upload photo",
                                      size: AppSizes.size_14,
                                      fontFamily: AppFont.medium,
                                      fontWeight: FontWeight.w400,
                                      color:Color(0xff686868),
                                    ),
                                  ],
                                ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => pickVideo(),
                                child: Container(
                                  height:110,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Color(0xffD8D8D8))
                                  ),
                                  child:
                                  Get.put(HomeController()).videoFile!=null?
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Get.put(HomeController()).videoFile =
                                        null;
                                      });
                                    },
                                    child: SizedBox(
                                      height: Get.put(HomeController())
                                          .image
                                          .value
                                          .isNotEmpty
                                          ? Get.height * 0.15
                                          : Get.height * 0.17,
                                      width: Get.height * 0.17,
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            width: Get.width,
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              child: Image.asset(
                                               "assets/icons/youtube.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              right: 10,
                                              top: 8,
                                              child: Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    color: AppColor.primaryColor,
                                                    borderRadius: BorderRadius.circular(100)
                                                ),
                                                child: Icon(
                                                  Icons.cancel_rounded,
                                                  size: 20,
                                                  color: AppColor.whiteColor,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ):

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/icons/video1.png",
                                        height: 40,
                                        width: 40,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      AppText(
                                        title: "Upload video",
                                        size: AppSizes.size_14,
                                        fontFamily: AppFont.medium,
                                        fontWeight: FontWeight.w400,
                                        color:Color(0xff686868),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: Get.height * 0.035,
                        ),


                      ],
                    ),
                  ),
                ),

              ),
              isKeyBoard?SizedBox.shrink():
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal:16,vertical: 10),
                child: Obx(() {
                  return   AppButton(
                    buttonName:
                    Get.put(HomeController()).isClaim.value
                        ?
                    submit.tr:  submit.tr,
                    buttonColor: AppColor.primaryColor,
                    textColor: AppColor.whiteColor,
                    onTap: () {

                      if (validateClaim(context)) {
                        Get.put(HomeController())
                            .updateIsClaim(true);
                        ApiManger().claimReward(
                            name: nameController.text,
                            phone: phoneCon.text,
                            email: emailCon.text,
                            addrss: addressController.text,
                            file:
                            Get.put(HomeController()).videoFile,
                            id: idController.text);
                      }
                    },
                    buttonRadius: BorderRadius.circular(10),
                    buttonWidth: Get.width,

                  );
                }),
              )
            ],
          ),
        ),
        Obx(() {
          return Get.put(HomeController()).isClaim.value == false
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
    );
  }

  bool validateClaim(BuildContext context) {
    if (nameController.text.isEmpty) {
      flutterToast(msg: pleaseEnterFullName.tr);
      return false;
    }
    if (phoneCon.text.isEmpty) {
      flutterToast(msg: enterValidPhone.tr);
      return false;
    }
    if (idController.text.isEmpty) {
      flutterToast(msg: pleaseEnterIdentityId.tr);
      return false;
    }

    if (addressController.text.isEmpty) {
      flutterToast(msg: pleaseEnterValidAddress.tr);
      return false;
    }
    if (emailCon.text.isEmpty) {
      flutterToast(msg: pleaseEnterValidEmail.tr);
      return false;
    }
    if (Get.put(HomeController()).claimProfile == null) {
      flutterToast(msg: pleaseUploadYourPic.tr);
      return false;
    }
    if (Get.put(HomeController()).videoFile == null) {
      flutterToast(msg: pleaseMake15SecVideo.tr);
      return false;
    }

    return true;
  }
}
