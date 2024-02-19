// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/video_widget.dart';
import 'package:share_plus/share_plus.dart';



class VideoViewDetail extends StatelessWidget {
  VideoViewDetail({Key? key,this.data}) : super(key: key);
  var data;



  List videoList = [
    "assets/videos/video3.mp4",
    "assets/videos/video3.mp4",
    "assets/videos/video3.mp4"

  ];

  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body:  Stack(
        children: [
          Column(
            children: [
              Expanded(child:Stack(
                children: [
                  VideoPlayerItem(
                    videoUrl: data.video.toString(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Container(
                                  padding:  EdgeInsets.only(left: Get.width*0.045),
                                  child:  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height:36,
                                            width: 36,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(1000),
                                                border: Border.all(color: AppColor.whiteColor, width: 1.5)),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(1000),
                                                child: CachedNetworkImage(
                                                  imageUrl:data.image.toString(),
                                                  fit: BoxFit.cover,
                                                  errorWidget: (context, url, error) => ClipRRect(
                                                    borderRadius: BorderRadius.circular(1000),
                                                    child: Image.asset(
                                                      "assets/images/person.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          AppText(
                                            title: "@${data.firstName.toString()}00",
                                            size: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.whiteColor,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height*0.01,),
                                      AppText(
                                        title: "Good morning every one #goodmorning",
                                        size: 11,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.whiteColor.withOpacity(0.9),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: Get.height*0.035,horizontal: Get.width*0.045),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    Obx(
                                      () {
                                        return GestureDetector(
                                          onTap:
                                          Get.put(HomeController()).likeStatus.value==false?
                                              (){
                                            if(Get.put(HomeController()).likeStatus.value==false){
                                              Get.put(HomeController()).updateLikeStatus(true);
                                              ApiManger().likeTestMonial(id: data.id.toString());
                                            }
                                            else{
                                              Get.put(HomeController()).updateLikeStatus(false);
                                              ApiManger().unLikeTestMonial(id: data.id.toString());
                                            }

                                          }:(){
                                            if(Get.put(HomeController()).likeStatus.value==false){
                                              Get.put(HomeController()).updateLikeStatus(true);
                                              ApiManger().likeTestMonial(id: data.id.toString());
                                            }
                                            else{
                                              Get.put(HomeController()).updateLikeStatus(false);
                                              ApiManger().unLikeTestMonial(id: data.id.toString());
                                            }

                                          },
                                          child:


                                          Obx(
                                            () {
                                              return Image.asset(
                                                Get.put(HomeController()).likeStatus.value?
                                                "assets/images/favourite.png":  "assets/images/like.png",
                                                height: 26,
                                                width: 26,
                                                color:
                                                Get.put(HomeController()).likeStatus.value==false?
                                                AppColor.whiteColor:AppColor.primaryColor,
                                              );
                                            }
                                          ),
                                        );
                                      }
                                    ),
                                    SizedBox(height: Get.height*0.05,

                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            isScrollControlled: true,
                                            isDismissible: true,
                                            context: context,
                                            builder: (context) =>   infoWidget(context: context));
                                      },
                                      child: Image.asset("assets/images/com.png",
                                        height: 26,
                                        width: 26,
                                      ),
                                    ),
                                    SizedBox(height: Get.height*0.05,),
                                    GestureDetector(
                                      onTap: (){
                                        Share.share(data.video.toString(), subject: 'Look what I made!');
                                      },
                                      child: Image.asset("assets/images/share.png",
                                        height: 26,
                                        width: 26,
                                      ),
                                    ),



                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
            ],
          ),
          Positioned(child:  Material(
            color:  AppColor.whiteColor,
            elevation: 1,
            child: SizedBox(
              width: Get.width,
              height: Get.height / 9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.03,
                        vertical: Get.height * 0.018),
                    child: Row(

                      children: [
                        GestureDetector(
                          onTap:(){
                            Get.back();
                          },
                          child:  Image.asset("assets/icons/backs.png",
                            height: 30,
                            width: 30,
                          ),
                        ),
                        SizedBox(width: 10,),
                        AppText(
                          title: data.firstName.toString(),
                          color: AppColor.primaryColor,
                          size: 18,
                         fontWeight: FontWeight.w600,
                        ),
                        AppText(
                          title: "",
                          color: AppColor.blackColor,
                          size: AppSizes.size_17,
                          fontFamily: AppFont.semi,
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),)
        ],
      ),
    );
  }
  Widget infoWidget({required BuildContext context}){
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return DraggableScrollableSheet(
      initialChildSize:
      isKeyBoard?0.9:
      0.7,
      minChildSize:isKeyBoard?0.9:
      0.7,
      maxChildSize: isKeyBoard?0.9:
      0.7,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/slide.png",
                    scale: 3,
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              const AppText(
                  title: "Comments",
                  size: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackColor),

              SizedBox(
                height: Get.height * 0.0,
              ),

              SizedBox(
                height: Get.height * 0.03,
              ),
              Row(
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
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],

                      ),

                      child:   Padding(
                        padding: EdgeInsets.only(
                            left: 16,right: 8),
                        child: Row(
                          children: [

                            Expanded(
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                controller: commentController,

                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.done,
                                onChanged: (val){

                                },



                                maxLines: 5,
                                minLines: 1,
                                style:GoogleFonts.poppins(
                                    textStyle : TextStyle(
                                      fontSize: 15,

                                      fontWeight: FontWeight.w500,

                                    )),



                                decoration: InputDecoration(
                                  border: InputBorder.none,


                                  hintText: "Write comments!",
                                  hintStyle: GoogleFonts.poppins(
                                      textStyle : TextStyle(
                                        fontSize: 12,
                                        color: AppColor.greyLightColor,

                                        fontWeight: FontWeight.w400,

                                      )),

                                  contentPadding: EdgeInsets.only(bottom: 13),
                                ),
                              ),
                            ),



                          ],
                        ),
                      ),

                    ),
                  ),
                  SizedBox(width: 10,),
                  Obx(
                          () {
                        return
                          Get.put(HomeController()).commentUpdate.value?
                          Center(
                              child: SpinKitThreeBounce(
                                  size: 10, color: AppColor.primaryColor)):
                          GestureDetector(
                            onTap: (){
                              print(data.id.toString());
                              print(commentController.text);
                              print(Get.put(HomeController()).token.value);
                              Get.put(HomeController()).updateComment(true);
                              ApiManger().postCommentsModel(id:data.id.toString(),text: commentController.text);
                              commentController.clear();
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.primaryColor
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Image.asset("assets/icons/send.png",
                                  height: 42,
                                  width: 42,

                                ),
                              ),
                            ),
                          );
                      }
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.007,
              ),
              Expanded(
                child: Obx(() {
                  return
                    Get.put(HomeController()).allCommentLoader.value?
                    Center(
                        child: SpinKitThreeBounce(
                            size: 10, color: AppColor.primaryColor)):
                    ListView.builder(
                      itemCount:   Get.put(HomeController()).getCommentList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                        dragStartBehavior: DragStartBehavior.down,
                      reverse: false,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        DateTime timestamp = DateTime.parse(Get.put(HomeController()).getCommentList[index].createdAt.toString());
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Column(

                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height:36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1000),
                                        border: Border.all(color: AppColor.whiteColor, width: 1.5)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(1000),
                                        child: CachedNetworkImage(
                                          imageUrl:( Get.put(HomeController()).getCommentList[index].user?.logo).toString(),
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) => ClipRRect(
                                            borderRadius: BorderRadius.circular(1000),
                                            child: Image.asset(
                                              "assets/images/person.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          AppText(
                                            title: "@${Get.put(HomeController()).getCommentList[index].user?.fullName.toString()}00",
                                            size: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.boldBlackColor,
                                          ),
                                        ],
                                      ),
                                      AppText(
                                        title:Get.put(HomeController()).getCommentList[index].text.toString(),
                                        size: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.greyLightColor2,
                                      ),
                                      SizedBox(height: 2,),
                                      AppText(
                                        title: DateFormat("dd MMM yyyy").format(timestamp),
                                        size: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.greyLightColor2,
                                      )

                                    ],
                                  ),

                                ],
                              ),


                            ],
                          ),
                        );
                      });
                }
                ),
              ),











            ],
          ),
        ),
      ),
    );
  }
}
