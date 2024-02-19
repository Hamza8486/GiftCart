// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_text.dart';

import '../../../util/translation_keys.dart';

class ChatDetail extends StatefulWidget {
  ChatDetail({super.key, this.data});

  var data;

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  var messageController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print(widget.data.id.toString());
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.06,
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColor.primaryColor,
                      size: 25,
                    )),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Center(
                      child: SpinKitThreeBounce(
                          size: 14, color: AppColor.primaryColor),
                    ),
                    imageUrl: widget.data.user.logo.toString(),
                    height: 55,
                    width: 55,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/person.png",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                AppText(
                    title: widget.data.user.fullName.toString(),
                    size: 16,
                    fontWeight: FontWeight.w600,
                    maxLines: 1,
                    overFlow: TextOverflow.ellipsis,
                    color: AppColor.primaryColor)
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Expanded(child: Obx(() {
              return Get.put(HomeController()).messageLoader.value
                  ? Center(
                      child: SpinKitThreeBounce(
                          size: 25, color: AppColor.primaryColor))
                  : ListView.builder(
                      shrinkWrap: true,
                      dragStartBehavior: DragStartBehavior.down,
                      itemCount: 1,
                      primary: false,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15),
                      itemBuilder: (context, index) {
                        // print(jsonEncode(jobController.activeList[index]));
                        // print(jsonEncode(P));

                        return Get.put(HomeController())
                                    .winnersChatModel
                                    ?.data
                                    ?.text ==
                                null
                            ? SizedBox()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                spreadRadius: 2,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    2), // changes position of shadow
                                              ),
                                            ],
                                            color: AppColor.primaryColor,
                                            // AppColors.greyColor.withOpacity(.5),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft:
                                                    Radius.circular(10))),
                                        child: Center(
                                          child: SizedBox(
                                            child: AppText(
                                              title: (Get.put(HomeController())
                                                      .winnersChatModel
                                                      ?.data
                                                      ?.text)
                                                  .toString(),
                                              size: 13,
                                              textAlign: TextAlign.left,
                                              fontWeight: FontWeight.w500,
                                              maxLines: 10,
                                              overFlow: TextOverflow.ellipsis,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      AppText(
                                        title: read10_04.tr,
                                        size: 11,
                                        fontWeight: FontWeight.w500,
                                        maxLines: 1,
                                        overFlow: TextOverflow.ellipsis,
                                        color: AppColor.greyLightColor,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                      },
                    );
            })),
            SizedBox(
              height: Get.height * 0.013,
            ),
            Obx(() {
              return Get.put(HomeController()).messageCheckLoader.value
                  ? SizedBox.shrink()
                  : Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              messageController.text =
                                  congratulationsScratchCoupon.tr;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff45A843).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(40)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Center(
                                child: AppText(
                                  title: congratulationsScratchCoupon.tr,
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  color: AppColor.blackColor.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              messageController.text = youAreLucky.tr +
                                  " ${widget.data.user.fullName.toString()}!";
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff45A843).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(40)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Center(
                                child: AppText(
                                  title: youAreLucky.tr +
                                      " ${widget.data.user.fullName.toString()}!",
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  color: AppColor.blackColor.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
            }),
            Get.put(HomeController()).messageCheckLoader.value
                ? SizedBox.shrink()
                : SizedBox(
                    height: Get.height * 0.013,
                  ),
            Obx(() {
              return Get.put(HomeController()).messageCheckLoader.value
                  ? SizedBox.shrink()
                  : Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              // border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 16, right: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.done,
                                      controller: messageController,
                                      onChanged: (v) {
                                        setState(() {});
                                      },
                                      maxLines: 5,
                                      minLines: 1,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      )),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        // prefixIcon:  Padding(
                                        //   padding: const EdgeInsets.all(12.0),
                                        //   child: SvgPicture.asset("assets/icons/camera.svg",
                                        //     height: 20,
                                        //     width: 20,
                                        //   ),
                                        // ),

                                        hintText: congrats.tr,
                                        hintStyle: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                          fontSize: 12,
                                          color: AppColor.greyLightColor,
                                          fontWeight: FontWeight.w400,
                                        )),

                                        contentPadding:
                                            EdgeInsets.only(bottom: 13),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Obx(() {
                          return Get.put(HomeController())
                                  .addMessageLoader
                                  .value
                              ? Center(
                                  child: SpinKitThreeBounce(
                                      size: 16, color: AppColor.primaryColor))
                              : GestureDetector(
                                  onTap: messageController.text.isEmpty
                                      ? () {
                                          flutterToast(
                                              msg: pleaseEnterMessage.tr);
                                        }
                                      : () {
                                          Get.put(HomeController())
                                              .addMessageLoader(true);
                                          ApiManger().sendMessageWinner(
                                              id: widget.data.id.toString(),
                                              text: messageController.text);
                                        },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: messageController.text.isEmpty
                                            ? AppColor.primaryColor
                                                .withOpacity(0.5)
                                            : AppColor.primaryColor),
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Image.asset(
                                        "assets/icons/send.png",
                                        height: 42,
                                        width: 42,
                                      ),
                                    ),
                                  ),
                                );
                        })
                      ],
                    );
            }),
            SizedBox(
              height: Get.height * 0.007,
            ),
          ],
        ),
      ),
    );
  }
}
