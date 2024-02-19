import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';

import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/component/drawer.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/view/dashboard_view.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:scratcher/scratcher.dart';

class StatsView extends StatefulWidget {
  StatsView({Key? key}) : super(key: key);

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  final homeController = Get.put(HomeController());
  final auth = Get.put(AuthController());

  String Slots="";  String? provinceName;
  double _opacity = 0.0;
   List names=["day",
  "week",
    "month"
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _selectedItem;
  String?filter;
  var provinceId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provinceId=null;
    filter=null;
    _selectedItem=null;
    homeController.updateTypeSelect("");
    homeController.getStatHis(id: "",day: "");
  }

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
                          title: "Stats",
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

          Padding(

            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                // border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.03, right: Get.width * 0.01),
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 10),
                            child: SizedBox(
                                width: Get.width*0.36,
                                child: Obx(() {
                                  return dropDownAppAddAll(
                                    hint: "Province",
                                    child1:  SvgPicture.asset("assets/icons/layer.svg",height: Get.height*0.018,
                                      color: AppColor.boldBlackColor,

                                    ),
                                    width:  Get.put(AuthController())
                                        .provinceList.isEmpty?Get.width * 0.33:Get.width * 0.33,
                                    height: Get.height * 0.3,
                                    items:Get.put(AuthController()).provinceAllList,
                                    color: AppColor.primaryColor,
                                    value: provinceName,
                                    onChange: (value) {
                                      setState(() {
                                        print(value.toString());


                                        provinceName = value;

                                        for (int i = 0;
                                        i <
                                            Get.put(AuthController())
                                                .provinceList.length;
                                        i++) {
                                          if (value == Get.put(AuthController())
                                              .provinceList[i].name){
                                            homeController.getStatHis(id:  Get.put(AuthController())
                                                .provinceList[i].id,
                                                day:filter==null?"": filter.toString()
                                            );
                                            homeController.updateProvincesName(
                                                Get.put(AuthController()).provinceList[i].name);

                                          }
                                        }
                                      });
                                    },
                                  );
                                })),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: 10),
                            child: SizedBox(
                                width: Get.width*0.3,
                                child: Obx(() {
                                  return dropDownAppAddAll(
                                    hint: "Grocery",
                                      colorIcon:Colors.transparent,
                                    child1:  SizedBox.shrink(),
                                    width:  Get.put(AuthController())
                                        .provinceList.isEmpty?Get.width * 0.3:Get.width * 0.3,
                                    height: Get.height * 0.3,
                                    items:["Grocery"],
                                    color: AppColor.primaryColor,
                                    value:null,
                                    onChange: (value) {

                                    },
                                  );
                                })),
                          ),


                          Padding(
                            padding:  EdgeInsets.only(right:0,top: 5 ),
                            child: SizedBox(
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
                                    filter=value.toString();
                                    homeController.getStatHis(id:
                                    provinceId==null?"":
                                    provinceId.toString(),
                                        day:value.toString()
                                    );




                                  });
                                },
                                constraints: BoxConstraints(
                                    minWidth: Get.height * 0.1,
                                    maxWidth: Get.height * 0.1,
                                    maxHeight: Get.height*0.25),
                                itemBuilder: (BuildContext bc) {
                                  return List.generate(
                                      names.length, (index ) {
                                    return  PopupMenuItem(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 12),
                                        value:  names[index].toString(),
                                        child: AppText(
                                          title: names[index]

                                              .toString(),

                                          size: 13,
                                          fontWeight: FontWeight.w500,

                                          color: AppColor.blackColor,
                                        ));
                                  });
                                },
                                child:Center(
                                  child: Image.asset(
                                    "assets/images/filter1.png",

                                  ),
                                ),
                              ),
                            ),
                          )


                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.greyColor.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 0.01),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                              child: Row(
                                children: [
                                  AppText(
                                    title: provinceName==null?"":provinceName.toString(),
                                    size: AppSizes.size_16,
                                    fontFamily: AppFont.semi,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  provinceName==null?SizedBox.shrink():
                                  SizedBox(width: Get.width*0.023,),
                                  provinceName==null?SizedBox.shrink():
                                  Image.asset(
                                    "assets/icons/line.png",
                                    height: Get.height * 0.03,
                                  ),
                                  provinceName==null?SizedBox.shrink():

                                  SizedBox(width: Get.width*0.023,),
                                  Obx(
                                    () {
                                      return Container(
                                        height:
                                        homeController.statHistList.isEmpty?Get.height*0.02:
                                        Get.height*0.02,
                                        width: Get.width*0.55,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: AppColor.greys,),
                                            borderRadius: BorderRadius.circular(10)
                                        ),

                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: LinearProgressIndicator(

                                            value: homeController.statHistList.length/100, // The value should be between 0.0 and 1.0
                                            backgroundColor: AppColor.greys,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                                AppColor.primaryColor),
                                          ),
                                        ),
                                      );
                                    }
                                  ),
                                  SizedBox(width: 13,),
                                  Column(
                                    children: [
                                      AppText(
                                        title: "Slots",
                                        size: 12,
                                        fontFamily: AppFont.regular,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      SizedBox(height: 7,),
                                      Obx(
                                              () {
                                            return AppText(
                                              title: homeController.statHistList.length.toString(),
                                              size: AppSizes.size_15,
                                              fontFamily: AppFont.regular,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            );
                                          }
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          title: "Total Price: ",
                          size: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        SizedBox(width: 7,),
                        Obx(
                                () {
                              return AppText(
                                title:
                                homeController.totalPrice.value.isEmpty?"0":
                                "\$${homeController.totalPrice.value}",
                                size:
                                homeController.totalPrice.value.isNotEmpty? 18:
                                18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              );
                            }
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.012,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.012,
                    ),
                    Obx(
                      () {
                        return
                          homeController.statLoading.value?
                          Column(
                            children: [
                              SizedBox(height: Get.height*0.13,),
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
                          homeController.statHistList.isNotEmpty?
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            reverse: true,
                            primary: false,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                childAspectRatio: Get.width / Get.width * 1.2,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 16),
                            itemCount: homeController.statHistList.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                onTap: homeController.statHistList[index].isScratch==true?(){
                                  print(homeController.statHistList[index].id
                                      .toString());

                                  // Get.generalDialog(
                                  //     pageBuilder: (context, __, ___) =>
                                  //         AlertDialog(
                                  //           shape: RoundedRectangleBorder(
                                  //             borderRadius: BorderRadius.circular(40), // Customize the border radius
                                  //           ),
                                  //
                                  //
                                  //           content: SizedBox(
                                  //             height: Get.height*0.35,
                                  //             width: Get.width*0.55,
                                  //             child: Column(
                                  //               crossAxisAlignment: CrossAxisAlignment.start,
                                  //               children: [
                                  //
                                  //                 Center(
                                  //                   child: AppText(
                                  //                     title:"Scratch Coupon!",
                                  //                     size: 16,
                                  //                     fontFamily:
                                  //                     AppFont.semi,
                                  //                     fontWeight:
                                  //                     FontWeight.w600,
                                  //                     color: Colors.black,
                                  //                   ),
                                  //                 ),
                                  //                 SizedBox(height: Get.height*0.03,),
                                  //                 SizedBox(
                                  //                   height: Get.height * 0.2,
                                  //                   child: Center(
                                  //                     child: Scratcher(
                                  //                       brushSize: 50, // Adjust the brush size as needed
                                  //                       threshold: 40, // Adjust the threshold as needed
                                  //                       color: AppColor.primaryColor, // Initial scratch card color
                                  //                       image: Image.asset('assets/images/scratch.png'), // Custom brush image
                                  //                       onChange: (value) {
                                  //                         if (value >= 1.0 && !isScratched) {
                                  //                           setState(() {
                                  //                             isScratched = true; // Scratch threshold reached
                                  //                           });
                                  //                         }
                                  //                         print("Scratch progress: ${value * 100}%");
                                  //                       },
                                  //                       child: Container(
                                  //                           width: 300,
                                  //                           height: 200,
                                  //                           alignment: Alignment.center,
                                  //                           decoration: BoxDecoration(
                                  //                             color: AppColor.primaryColor, // Content revealed
                                  //                             borderRadius: BorderRadius.circular(10),
                                  //                             // boxShadow: isScratched
                                  //                             //     ? [] // No shadow when content is revealed
                                  //                             //     : [BoxShadow(blurRadius: 10, color: Colors.grey)], // Add a blurred effect
                                  //                           ),
                                  //                           child: Column(
                                  //                             crossAxisAlignment: CrossAxisAlignment.center,
                                  //                             mainAxisAlignment: MainAxisAlignment.center,
                                  //                             children: [
                                  //
                                  //                               AppText(
                                  //                                 title:homeController.getSlot[index].code.toString(),
                                  //                                 size: 17,
                                  //                                 fontFamily:
                                  //                                 AppFont.bold,
                                  //                                 fontWeight:
                                  //                                 FontWeight.w800,
                                  //                                 color: Colors.white,
                                  //                               ),
                                  //                               SizedBox(height: Get.height*0.015,),
                                  //                               Image.asset("assets/images/sca.png",
                                  //                                 height: Get.height*0.1,
                                  //                               )
                                  //                             ],
                                  //                           )
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //                 SizedBox(height: Get.height*0.03,),
                                  //                 Padding(
                                  //                   padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                                  //                   child: AppButton(
                                  //                     buttonName: "Cancel",
                                  //                     buttonColor: AppColor.primaryColor,
                                  //                     textColor: AppColor.whiteColor,
                                  //                     onTap: () {
                                  //                       Get.back();
                                  //                     },
                                  //                     buttonHeight: Get.height * 0.055,
                                  //                     buttonWidth: Get.width,
                                  //                     fontFamily: AppFont.medium,
                                  //                     textSize: 17,
                                  //                     buttonRadius: BorderRadius.circular(30),
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //
                                  //         ));
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) =>   SlotTrue(
                                        id:homeController.statHistList[index].id
                                            .toString() ,
                                        code:homeController.statHistList[index].code
                                            .toString()  ,

                                      ));
                                }:
                                    () {
                                  print(homeController.statHistList[index].id
                                      .toString());
                                  ApiManger().slotVView(id: homeController.statHistList[index].id.toString());

                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) =>   SlotView(
                                        id:homeController.statHistList[index].id
                                            .toString() ,
                                        code:homeController.statHistList[index].code
                                            .toString()  ,


                                      ));

                                },
                                child:




                                Container(
                                  decoration:  BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                    homeController.statHistList[index].isScratch==true?
                                    AppColor.primaryColor.withOpacity(0.25):Color(0xfffa7175)
                                    ),
                                  child: Padding(
                                      padding:
                                      const EdgeInsets.all(
                                          18.0),
                                      child: Icon(
                                        Icons.shopping_cart,
                                        color:
                                        // homeController
                                        //     .getSlot1[index].isScratch=="true"?
                                        // AppColor.primaryColor:
                                        AppColor.grey3Color,
                                        size: AppSizes.size_25,
                                      )),
                                )

                              );
                            }):
                          Column(
                            children: [
                              SizedBox(height: Get.height*0.15,),
                              Center(child: AppText(title: "No  History!",
                                color: AppColor.blackColor.withOpacity(0.7),
                                size: 16,
                                fontWeight: FontWeight.w500,
                              ))
                            ],
                          );
                        ;
                      }
                    ),
                    SizedBox(
                      height: Get.height * 0.065,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  List<DropdownMenuItem<int>> countryDataList({var dataList}) {
    List<DropdownMenuItem<int>> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(DropdownMenuItem<int>(
          value: dataList[i].id,
          child: Row(
            children: [
              SvgPicture.asset("assets/icons/layer.svg",height: Get.height*0.026,
                color: AppColor.boldBlackColor,

              ),
              SizedBox(width: Get.width*0.04,),
              AppText(
                title: dataList[i].name,
                size: AppSizes.size_15,
                color: AppColor.blackColor,
                fontFamily: AppFont.medium,
                fontWeight: FontWeight.w500,
              ),
            ],
          )));
    }
    return outputList;
  }
  Future<void> scratchDialog({required BuildContext context, text, id,String?value}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: CircleBorder(),
            title: SizedBox.shrink(),
            content: Container(
              height: Get.height * 0.83,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.28,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  StatefulBuilder(builder: (context, StateSetter setState) {
                    return Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child:
                        value==null?

                        Scratcher(
                          accuracy: ScratchAccuracy.low,
                          color: Colors.blueGrey,
                          onChange: (value) {
                            setState(() {
                              if (value == 60.0) {
                                ApiManger().claimScratch(
                                    context: context, id: id.toString());
                              } else {
                                print(value.toString());
                              }
                            });
                          },
                          onScratchStart: () {
                            print("Scratching has started");
                          },
                          onScratchUpdate: () {
                            print("Scratching in progress");
                          },
                          onScratchEnd: () {
                            print("Scratching has finished");
                          },
                          image: Image.asset(
                            'assets/images/scan1.png',
                          ),
                          brushSize: 15,
                          threshold: 60,
                          onThreshold: () {
                            setState(() {
                              _opacity = 1;
                            });
                          },
                          child: AnimatedOpacity(
                            duration: Duration(microseconds: 100),
                            opacity: _opacity,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              height: MediaQuery.of(context).size.height * 0.22,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                  AppText(
                                    title: "Congratulations!",
                                    size: AppSizes.size_16,
                                    fontFamily: AppFont.semi,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primaryColor,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  AppText(
                                    title: text.toString(),
                                    size: AppSizes.size_19,
                                    fontFamily: AppFont.semi,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.blackColor,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  Image.asset(
                                    "assets/images/sca.png",
                                    height: Get.height * 0.16,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ):Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.03,
                              ),
                              AppText(
                                title: "Congratulations!",
                                size: AppSizes.size_16,
                                fontFamily: AppFont.semi,
                                fontWeight: FontWeight.w600,
                                color: AppColor.primaryColor,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              AppText(
                                title: text.toString(),
                                size: AppSizes.size_19,
                                fontFamily: AppFont.semi,
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackColor,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Image.asset(
                                "assets/images/sca.png",
                                height: Get.height * 0.09,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: Get.height * 0.13,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                    child: AppButton(
                      buttonName: "Ok",
                      buttonColor: AppColor.primaryColor,
                      textColor: AppColor.whiteColor,
                      onTap: () {
                        Get.back();
                      },
                      buttonHeight: Get.height * 0.055,
                      buttonWidth: Get.width,
                      fontFamily: AppFont.medium,
                      textSize: AppSizes.size_16,
                      buttonRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
