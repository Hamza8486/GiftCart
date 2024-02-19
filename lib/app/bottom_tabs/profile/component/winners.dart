import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/component/drawer.dart';
import 'package:mr_bet/app/bottom_tabs/component/message.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';

class Winners extends StatefulWidget {
  const Winners({Key? key}) : super(key: key);

  @override
  State<Winners> createState() => _WinnersState();
}

class _WinnersState extends State<Winners> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(HomeController()).winnerList.clear();
    Get.put(HomeController()).getWinnerData();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Container(
            height: 102,
            width: Get.width,
            decoration: BoxDecoration(
                color: AppColor.whiteColor
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15 ),
              child: Column(
                children: [
                  SizedBox(height: 52,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      GestureDetector(
                        onTap: (){
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Image.asset("assets/images/menu.png",height: 38,
                          width: 38,


                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: AppText(
                          title: "Giveaway",
                          size: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColor.boldBlackColor,
                        ),
                      ),
                      AppText(
                        title: "Testimonials",
                        size: 0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.whiteColor,
                      ),

                    ],
                  ),
                ],
              ),
            ),

          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Obx(
                          () {
                            return
                              Get.put(HomeController()).winnerList.isEmpty?SizedBox.shrink():

                              SizedBox(
                              height: Get.height*0.17,
                              width: Get.width,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Image.asset("assets/images/tag9.png",
                                      height: 120,
                                      width: 105,
                                    ),
                                  ),
                                  Positioned(
                                     left: Get.width*0.38,
                                      top: Get.height*0.045,
                                      child:  Container(
                                      height:70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColor
                                                .primaryColor,
                                            width: 1.9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius
                                            .circular(100),
                                        child: Image.network(
                                            Get.put(HomeController()).winnerList[0].user.logo==null?"": Get.put(HomeController()).winnerList[0].user.logo,



                                            fit: BoxFit.cover,
                                            errorBuilder: (
                                                context,
                                                exception,
                                                stackTrace) {
                                              return ClipRRect(
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    100),
                                                child: Image
                                                    .asset(
                                                  "assets/images/persons.jpg",
                                                  fit: BoxFit
                                                      .cover,
                                                ),
                                              );
                                            }),
                                      )))
                                ],
                              ),
                            );
                          }
                        ),




                        SizedBox(
                          height: Get.height * 0.1,
                        ),
                        Obx(
                           () {
                            return
                              Get.put(HomeController()).winnerValue.value?

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: Get.height * 0.27),
                                  Center(
                                    child: Container(
                                      height: 57,width: 57,

                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                                        color: AppColor.primaryColor,),
                                      child:  Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            backgroundColor: Colors.white,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                                AppColor.primaryColor.withOpacity(0.5) //<-- SEE HERE

                                            ),
                                            // strokeWidth: 5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ):
                              Get.put(HomeController()).winnerList.isNotEmpty?

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xffF65356).withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                                  child: ListView.builder(
                                    itemCount: Get.put(HomeController()).winnerList.length,
                                    shrinkWrap: true,
                                    reverse: true,
                                    padding: EdgeInsets.only(top: 10),
                                    primary: false,
                                    itemBuilder: (BuildContext context, int index) {
                                      // Increment the index by 1 to get the actual index number
                                      int indexNumber = index + 1;

                                      // Convert the index number to a string with leading zeros when less than 10
                                      String indexString = indexNumber.toString().padLeft(2, '0');
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  titlePadding: EdgeInsets.zero,
                                                  contentPadding: EdgeInsets.only(
                                                    left: Get.width * 0.05,
                                                    right: Get.width * 0.05,
                                                    top: Get.height * 0.01,
                                                    bottom: Get.height * 0.01,
                                                  ),
                                                  content: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(
                                                          10), color: AppColor.whiteColor,),

                                                    height: Get.height * 0.4,
                                                    width: Get.width * 0.5,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        SizedBox(
                                                          height: Get.height * 0.015,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                                height: Get.height * 0.08,
                                                                width: Get.height * 0.08,
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: AppColor
                                                                          .primaryColor,
                                                                      width: 1.9),
                                                                  shape: BoxShape.circle,
                                                                ),
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius
                                                                      .circular(100),
                                                                  child: Image.network(
                                                                      Get.put(HomeController()).winnerList[index].user.logo==null?"": Get.put(HomeController()).winnerList[index].user.logo



                                                                      , fit: BoxFit.cover,
                                                                      errorBuilder: (
                                                                          context,
                                                                          exception,
                                                                          stackTrace) {
                                                                        return ClipRRect(
                                                                          borderRadius: BorderRadius
                                                                              .circular(
                                                                              100),
                                                                          child: Image
                                                                              .asset(
                                                                            "assets/images/persons.jpg",
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                        );
                                                                      }),
                                                                )),
                                                            SizedBox(
                                                              width: Get.width * 0.03,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                AppText(
                                                                  title:  Get.put(HomeController()).winnerList[index].user.fullName,
                                                                  size: AppSizes.size_15,
                                                                  fontFamily: AppFont
                                                                      .medium,
                                                                  fontWeight: FontWeight
                                                                      .w600,
                                                                  color: AppColor
                                                                      .boldBlackColor,
                                                                ),
                                                                SizedBox(
                                                                  height: Get.height *
                                                                      0.005,
                                                                ),
                                                                AppText(
                                                                  title: "00${indexString.toString()}",
                                                                  size: AppSizes.size_12,
                                                                  fontFamily: AppFont
                                                                      .medium,
                                                                  fontWeight: FontWeight
                                                                      .w500,
                                                                  color: AppColor
                                                                      .boldBlackColor,
                                                                ),

                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: Get.height * 0.025,
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .circular(40),
                                                            border: Border.all(
                                                                color: AppColor
                                                                    .primaryColor),

                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(horizontal: 30),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .center,
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    AppText(
                                                                      title: "Province",
                                                                      size: AppSizes
                                                                          .size_11,
                                                                      fontFamily: AppFont
                                                                          .medium,
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      color: Colors.black,
                                                                    ),
                                                                    SizedBox(height: 3,),
                                                                    AppText(
                                                                      title: Get.put(HomeController()).winnerList[index].province.name.toString(),
                                                                      size: AppSizes
                                                                          .size_11,
                                                                      fontFamily: AppFont
                                                                          .medium,
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      color: Colors.grey,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  height: Get.height * 0.06,
                                                                  width: Get.width * 0.003,
                                                                  decoration: BoxDecoration(
                                                                      color: AppColor
                                                                          .primaryColor,
                                                                      borderRadius: BorderRadius
                                                                          .circular(20)
                                                                  ),
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .center,
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    AppText(
                                                                      title: "Purchase Slots",
                                                                      size: AppSizes
                                                                          .size_11,
                                                                      fontFamily: AppFont
                                                                          .medium,
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      color: Colors.black,
                                                                    ),
                                                                    SizedBox(height: 3,),
                                                                    AppText(
                                                                      title: Get.put(HomeController()).winnerList[index].province.slot.toString(),
                                                                      size: AppSizes
                                                                          .size_11,
                                                                      fontFamily: AppFont
                                                                          .medium,
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      color: Colors.grey,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: Get.height * 0.015,
                                                        ),
                                                        AppText(
                                                          title: "Prize:",
                                                          size: AppSizes.size_13,
                                                          fontFamily: AppFont.semi,
                                                          fontWeight: FontWeight.w600,
                                                          color: AppColor.primaryColor,
                                                        ),
                                                        SizedBox(
                                                          height: Get.height * 0.005,
                                                        ),
                                                        AppText(
                                                          title:"Grocery",
                                                          size: AppSizes.size_11,
                                                          fontFamily: AppFont.medium,
                                                          fontWeight: FontWeight.w400,
                                                          color: AppColor.grey2Color,
                                                        ),
                                                        SizedBox(
                                                          height: Get.height * 0.025,
                                                        ),
                                                        Get.put(HomeController()).winnerList[index].isMessage==false?SizedBox.shrink():
                                                        AppButton(
                                                          buttonColor: AppColor.grey2Color
                                                              .withOpacity(0.6),
                                                          textColor: AppColor.whiteColor,
                                                          onTap: () {
                                                            Get.put(HomeController()).getWinnerChar(id:Get.put(HomeController()).winnerList[index].toString() );
                                                            Get.to(ChatDetail(data:Get.put(HomeController()).winnerList[index] ,));
                                                          },
                                                          buttonName: "Message",
                                                          buttonHeight: Get.height * 0.04,
                                                          buttonWidth: Get.width,
                                                          buttonRadius: BorderRadius
                                                              .circular(20),
                                                        ),
                                                        SizedBox(
                                                          height: Get.height * 0.025,
                                                        ),
                                                        AppButton(
                                                          gard: false,
                                                          buttonColor: Color(0xffC4C4C4),

                                                          textColor: AppColor.whiteColor,
                                                          onTap: () {
                                                            print(Get.put(HomeController()).winnerList[index].user.id.toString());
                                                            Get.back();
                                                          },
                                                          buttonName: "Cancel",
                                                          buttonHeight: Get.height * 0.04,
                                                          buttonWidth: Get.width,
                                                          buttonRadius: BorderRadius
                                                              .circular(20),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                              );
                                            },
                                          );
                                        },
                                        child:     Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                          child: Column(
                                            children: [

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      AppText(
                                                        title: indexString.toString(),
                                                        size:17,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                      SizedBox(width: Get.width * 0.02,),
                                                      Container(
                                                          height: Get.height * 0.053,
                                                          width: Get.height * 0.053,
                                                          decoration: BoxDecoration(
                                                            gradient: AppColor.Home_GRADIENT,
                                                            border: Border.all(
                                                                color: AppColor.primaryColor
                                                                    .withOpacity(0.6),
                                                                width: 1.9),
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius
                                                                .circular(100),
                                                            child: Image.network(
                                                                Get.put(HomeController()).winnerList[index].user.logo==null?"":              Get.put(HomeController()).winnerList[index].user.logo,
                                                                fit: BoxFit.cover,
                                                                errorBuilder: (context,
                                                                    exception, stackTrace) {
                                                                  return ClipRRect(
                                                                    borderRadius: BorderRadius
                                                                        .circular(100),
                                                                    child: Image.asset(
                                                                      "assets/images/persons.jpg",
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  );
                                                                }),
                                                          )),
                                                      SizedBox(width: Get.width * 0.02,),
                                                      SizedBox(
                                                        width: Get.width*0.32,
                                                        child: AppText(
                                                          title: Get.put(HomeController()).winnerList[index].user.fullName.toString(),
                                                          size: 16,
                                                          maxLines: 2,
                                                          fontFamily: AppFont.medium,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColor.primaryColor,
                                                        borderRadius: BorderRadius.circular(
                                                            20)
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 17, vertical: 6),
                                                      child: AppText(
                                                        title:
                                                        Get.put(HomeController()).winnerList[index].isMessage==false?
                                                        "View":"Message",
                                                        size: AppSizes.size_12,
                                                        fontFamily: AppFont.medium,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Get.put(HomeController()).winnerList.length==1?SizedBox.shrink():
                                              Column(
                                                children: [
                                                  SizedBox(height: 8,),
                                                  Divider(color: Colors.grey.withOpacity(0.7),),
                                                  SizedBox(height: 8,),
                                                ],
                                              )


                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                ),
                              ):Column(
                                children: [
                                  SizedBox(height: Get.height*0.27,),
                                  Center(child: AppText(title: "No Winners Data!",
                                    color: AppColor.blackColor.withOpacity(0.7),
                                    size: 16,
                                    fontWeight: FontWeight.w500,
                                  ))
                                ],
                              );
                          }
                        ),


                      ],
                    ),
                    Positioned(
                      top: Get.height * 0.16,
                      left: 0, // Adjust this value as needed to control the horizontal position
                      right: 0,
                        child:  Obx(
                          () {
                            return

                              Get.put(HomeController()).winnerList.isEmpty?SizedBox.shrink():
                              Center(
                              child: AppText(
                                title:Get.put(HomeController()).winnerList[0].user.fullName.toString(),
                                size:14,

                                fontWeight: FontWeight.w600,
                                color: AppColor.blackColor,
                              ),
                            );
                          }
                        ),),
                    Positioned(
                      top: Get.height * 0.21,
                      left: Get.width*0.67, // Adjust this value as needed to control the horizontal position
                      right: 0,

                      child:  Obx(
                              () {
                            return

                              Get.put(HomeController()).winnerList.isEmpty?SizedBox.shrink():
                              Center(
                                child: AppText(
                                  title:Get.put(HomeController()).winnerList[0].user.fullName.toString(),
                                  size:14,

                                  fontWeight: FontWeight.w600,
                                  color: AppColor.blackColor,
                                ),
                              );
                          }
                      ),),

                    Positioned(
                      top: Get.height * 0.21,
                      right: Get.width*0.72, // Adjust this value as needed to control the horizontal position

                      child:  Obx(
                              () {
                            return

                              Get.put(HomeController()).winnerList.isEmpty?SizedBox.shrink():
                              Center(
                                child: AppText(
                                  title: Get.put(HomeController()).winnerList[0].user.fullName==null?"": Get.put(HomeController()).winnerList[0].user.fullName,
                                  size:12,

                                  fontWeight: FontWeight.w600,
                                  color: AppColor.blackColor,
                                ),
                              );
                          }
                      ),),

                    Positioned(
                        right: Get.width*0.01,
                        top: Get.height*0.08,
                        child:  Obx(
                            () {
                          return
                            Get.put(HomeController()).winnerList.isEmpty?SizedBox.shrink():

                            SizedBox(
                              height: 105,
                              width: 96,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Image.asset("assets/images/tag6.png",
                                      height: Get.height*0.15,
                                    ),
                                  ),
                                  Positioned(
                                      right: 20,
                                      top: 25,
                                      child:  Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColor
                                                    .primaryColor,
                                                width: 1.9),
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius
                                                .circular(100),
                                            child: Image.network(
                                                Get.put(HomeController()).winnerList[0].user.logo==null?"": Get.put(HomeController()).winnerList[0].user.logo,



                                                fit: BoxFit.cover,
                                                errorBuilder: (
                                                    context,
                                                    exception,
                                                    stackTrace) {
                                                  return ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        100),
                                                    child: Image
                                                        .asset(
                                                      "assets/images/persons.jpg",
                                                      fit: BoxFit
                                                          .cover,
                                                    ),
                                                  );
                                                }),
                                          )))
                                ],
                              ),
                            );
                        }
                    )),
                    Positioned(
                        left: Get.width*0.01,
                        top: Get.height*0.08,
                        child:  Obx(
                                () {
                              return
                                Get.put(HomeController()).winnerList.isEmpty?SizedBox.shrink():

                                SizedBox(
                                  height: 105,
                                  width: 96,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Image.asset("assets/images/tag7.png",
                                          height: Get.height*0.15,
                                        ),
                                      ),
                                      Positioned(
                                          right: 20,
                                          top: 25,
                                          child:  Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColor
                                                        .primaryColor,
                                                    width: 1.9),
                                                shape: BoxShape.circle,
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius
                                                    .circular(100),
                                                child: Image.network(
                                                    Get.put(HomeController()).winnerList[0].user.logo==null?"": Get.put(HomeController()).winnerList[0].user.logo,



                                                    fit: BoxFit.cover,
                                                    errorBuilder: (
                                                        context,
                                                        exception,
                                                        stackTrace) {
                                                      return ClipRRect(
                                                        borderRadius: BorderRadius
                                                            .circular(
                                                            100),
                                                        child: Image
                                                            .asset(
                                                          "assets/images/persons.jpg",
                                                          fit: BoxFit
                                                              .cover,
                                                        ),
                                                      );
                                                    }),
                                              )))
                                    ],
                                  ),
                                );
                            }
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}