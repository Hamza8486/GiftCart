import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/auth/login.dart';
import 'package:mr_bet/app/auth/partner_signup/basic_info.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/vendor_dashboard/component/payments.dart';



import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/helper_function.dart';
import 'package:url_launcher/url_launcher.dart';


class StoreList extends StatefulWidget {
   StoreList({Key? key,this.type}) : super(key: key);
   var type;

  @override
  State<StoreList> createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
   final CarouselController _controller = CarouselController();

   double _opacity = 0.0;

   final authController = Get.put(AuthController());
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.getStoreData();
  }

   //final auth = Get.put(AuthController());
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   int _current = 0;

   List<String> bannerList = [
     'assets/images/mans.png',
     'assets/images/mans.png',
     'assets/images/mans.png',

     // Add more image paths as needed
   ];

  List cat = ["Restaurants",
  "Grocery",
    "Furniture","liquor store"


  ];
   void openWhatsApp({String phoneNumber ="", String message=""}) async {
     String url = "https://wa.me/$phoneNumber?text=${Uri.parse(message)}";

     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: Get.height*0.06,),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                child: Row(

                  children: [

                    GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Image.asset("assets/icons/backs.png",
                          height: 30,
                          width: 30,
                        )),
                    SizedBox(width: Get.width*0.02,),
                    AppText(
                      title: partners.tr,
                      size: 16,

                      fontWeight: FontWeight.w600,
                      color: AppColor.primaryColor,
                    ),



                  ],
                ),
              ),
              SizedBox(height: Get.height*0.01,),
              Divider(color: Colors.grey,),
              SizedBox(height: Get.height*0.01,),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                    child: Column(
                      children: [
                        SizedBox(height: 5,),
                        Obx(
                                () {
                              return
                                authController.allAdsLoader.value?
                                Center(
                                    child: SpinKitThreeBounce(
                                        size: 25, color: AppColor.primaryColor)):

                                authController.getAllAdsList.isNotEmpty?

                                Stack(
                                  children: [
                                    CarouselSlider(
                                      carouselController: _controller,
                                      options: CarouselOptions(
                                        aspectRatio: 16 / 9,
                                        pageSnapping: false,
                                        height: 145,
                                        viewportFraction: 1,
                                        initialPage: 0,
                                        enableInfiniteScroll: false,
                                        pauseAutoPlayInFiniteScroll: false,
                                        reverse: true,
                                        autoPlay: true,
                                        autoPlayInterval: const Duration(seconds: 3),
                                        autoPlayAnimationDuration: const Duration(milliseconds: 400),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        scrollDirection: Axis.horizontal,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _current = index;
                                          });
                                        },
                                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                                      ),
                                      items: authController.getAllAdsList
                                          .map((item) => GestureDetector(
                                        onTap:
                                            (){

                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top:0,left: 15),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 5,),

                                                    Row(
                                                      children: [
                                                        CachedNetworkImage(
                                                          imageUrl:item.image.toString(),
                                                          fit: BoxFit.cover,
                                                          width: 62,
                                                          height: 44,
                                                          errorWidget: (context, url, error) => ClipRRect(
                                                            borderRadius: BorderRadius.circular(1000),
                                                            child: Image.asset(
                                                              "assets/images/logo_man.png",
                                                              fit: BoxFit.cover,
                                                              width: 62,
                                                              height: 44,
                                                            ),
                                                          ),
                                                        ),

                                                        SizedBox(width: 6,),
                                                        Text("Special Offer",
                                                          style: GoogleFonts.italianno(
                                                              textStyle : TextStyle(
                                                                  color: AppColor.blackColor,
                                                                  fontSize: 24,
                                                                  fontWeight: FontWeight.w500


                                                              )),
                                                        ),

                                                      ],
                                                    ),
                                                    SizedBox(height: 8,),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: AppColor.primaryColor.withOpacity(0.2),
                                                              borderRadius: BorderRadius.circular(8)
                                                          ),
                                                          child: Padding(
                                                            padding:  EdgeInsets.symmetric(horizontal: 13,vertical: 5),
                                                            child: AppText(
                                                              title:
                                                              item.offerTypeValue==null?"0% Off":
                                                              "${item.offerTypeValue.toString()}% Off",
                                                              size: 12,
                                                              fontWeight: FontWeight.w600,
                                                              color: AppColor.primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 5,),
                                                        AppText(
                                                          title: "on all orders",
                                                          size: 11,
                                                          fontWeight: FontWeight.w400,
                                                          color: AppColor.blackColor,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 14,),
                                                    item.isWebsite ==true?
                                                    GestureDetector(
                                                      onTap: (){
                                                        launch(item.website.toString()
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 120,
                                                        height: 32,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            border: Border.all(color:
                                                            AppColor.primaryColor
                                                            )
                                                        ),
                                                        child:
                                                        Center(
                                                          child: AppText(
                                                            title: "Visit website",
                                                            size: 14,
                                                            fontWeight: FontWeight.w500,
                                                            color: AppColor.primaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ):
                                                    GestureDetector(
                                                      onTap: (){
                                                        openWhatsApp(phoneNumber: item.whatsapp.toString(),
                                                            message: "Welcome to mr grocery"
                                                        );
                                                      },
                                                      child: Image.asset("assets/images/chat.png",
                                                        width: 104,
                                                        height: 32,
                                                      ),
                                                    )

                                                  ],
                                                ),
                                              ),
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: CachedNetworkImage(
                                                      imageUrl:item.image.toString(),

                                                      fit: BoxFit.cover,
                                                      width: 150,
                                                      height: 140,
                                                      errorWidget: (context, url, error) => ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: Image.asset(
                                                          "assets/images/mans.png",
                                                          fit: BoxFit.cover,
                                                          width: 210,
                                                          height: 140,
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  Positioned(
                                                      top: 12,
                                                      right: 12,
                                                      child: Image.asset("assets/images/spoo.png",
                                                        width: 92,
                                                        height: 20,
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                          .toList(),
                                    ),

                                    Positioned(
                                        right: 0,
                                        left: 0,
                                        bottom: 15,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: bannerList.asMap().entries.map((entry) {
                                            return GestureDetector(
                                              onTap: () => _controller.animateToPage(entry.key),
                                              child: Container(
                                                width: 8.0,
                                                height: 8.0,
                                                margin: const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _current == entry.key
                                                        ? AppColor.primaryColor
                                                        :

                                                    Colors.white.withOpacity(0.6)),
                                              ),
                                            );
                                          }).toList(),
                                        )),

                                  ],
                                ):

                                Stack(
                                  children: [
                                    CarouselSlider(
                                      carouselController: _controller,
                                      options: CarouselOptions(
                                        aspectRatio: 16 / 9,
                                        pageSnapping: false,
                                        height: 145,
                                        viewportFraction: 1,
                                        initialPage: 0,
                                        enableInfiniteScroll: false,
                                        pauseAutoPlayInFiniteScroll: false,
                                        reverse: true,
                                        autoPlay: true,
                                        autoPlayInterval: const Duration(seconds: 3),
                                        autoPlayAnimationDuration: const Duration(milliseconds: 400),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        scrollDirection: Axis.horizontal,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _current = index;
                                          });
                                        },
                                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                                      ),
                                      items: bannerList
                                          .map((item) => GestureDetector(
                                        onTap:
                                            (){

                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top:0,left: 15),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 5,),

                                                    Row(
                                                      children: [
                                                        Image.asset("assets/images/logo_man.png",
                                                          width: 31,
                                                          height: 22,
                                                        ),
                                                        SizedBox(width: 6,),
                                                        Text("Special offer",
                                                          style: GoogleFonts.italianno(
                                                              textStyle : TextStyle(
                                                                  color: AppColor.blackColor,
                                                                  fontSize: 24,
                                                                  fontWeight: FontWeight.w500


                                                              )),
                                                        ),

                                                      ],
                                                    ),
                                                    SizedBox(height: 8,),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: AppColor.primaryColor.withOpacity(0.2),
                                                              borderRadius: BorderRadius.circular(8)
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 5),
                                                            child: AppText(
                                                              title: "50% Off",
                                                              size: 12,
                                                              fontWeight: FontWeight.w600,
                                                              color: AppColor.primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 5,),
                                                        AppText(
                                                          title: "on all orders",
                                                          size: 11,
                                                          fontWeight: FontWeight.w400,
                                                          color: AppColor.blackColor,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 14,),
                                                    Image.asset("assets/images/chat.png",
                                                      width: 104,
                                                      height: 32,
                                                    )

                                                  ],
                                                ),
                                              ),
                                              Stack(
                                                children: [
                                                  Image.asset(item.toString(),

                                                  ),
                                                  Positioned(
                                                      top: 12,
                                                      right: 12,
                                                      child: Image.asset("assets/images/spoo.png",
                                                        width: 92,
                                                        height: 20,
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                          .toList(),
                                    ),

                                    Positioned(
                                        right: 0,
                                        left: 0,
                                        bottom: 15,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: bannerList.asMap().entries.map((entry) {
                                            return GestureDetector(
                                              onTap: () => _controller.animateToPage(entry.key),
                                              child: Container(
                                                width: 8.0,
                                                height: 8.0,
                                                margin: const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _current == entry.key
                                                        ? AppColor.primaryColor
                                                        :

                                                    Colors.white.withOpacity(0.6)),
                                              ),
                                            );
                                          }).toList(),
                                        )),

                                  ],
                                );
                            }
                        ),
                        SizedBox(height: 20,),
                        SizedBox(
                            height: Get.height * 0.052,
                            child: ListView.builder(
                                itemCount:cat.length,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection:
                               Axis.horizontal,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return   GestureDetector(
                                    onTap: () {


                                    },
                                    child: Card(
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                          Get.width * 0.01,vertical: 2),
                                      color: index ==
                                          0
                                          ? AppColor.primaryColor
                                          : AppColor.whiteColor,
                                      shape: RoundedRectangleBorder(   borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(color:
                                      index==0?AppColor.primaryColor:
                                      AppColor.blackColor)
                                      ),
                                      shadowColor: AppColor.greyLightColor,


                                      elevation: 0,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                            Get.width * 0.05),
                                        child: Center(
                                          child: AppText(
                                            title:cat[index],
                                            color: index==0
                                                ? AppColor.whiteColor
                                                : AppColor.blackColor,
                                            size: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );

                                })),
                        SizedBox(height: 20,),

                        Obx(
                          () {
                            return

                              authController.storeLoader.value?
                              Column(
                                children: [
                                  SizedBox(height: Get.height*0.25,),
                                  Center(
                                      child: SpinKitThreeBounce(
                                          size: 25, color: AppColor.primaryColor)),
                                ],
                              ):

                              authController
                                  .getStoreList.isEmpty?
                              Column(
                                children: [
                                  SizedBox(height: Get.height*0.25,),
                                  Center(child: AppText(title: "No Store Data",
                                    color: AppColor.blackColor.withOpacity(0.7),
                                    size: 16,
                                    fontWeight: FontWeight.w500,
                                  ))
                                ],
                              ):

                              ListView.builder(
                                itemCount:  authController
                                    .getStoreList.length,
                                shrinkWrap: true,
                                primary: false,
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding:  EdgeInsets.symmetric(vertical: 8),
                                    child: Container(
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.greyLightColor.withOpacity(0.1)
                                      ),
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(1000),
                                              child: CachedNetworkImage(
                                                imageUrl:authController
                                                    .getStoreList[index].logo.toString(),

                                                fit: BoxFit.cover,
                                                width: 70,
                                                height: 70,
                                                errorWidget: (context, url, error) => ClipRRect(
                                                  borderRadius: BorderRadius.circular(10000),
                                                  child: Image.asset(
                                                    "assets/images/logo1.png",
                                                    fit: BoxFit.cover,
                                                    width: 70,
                                                    height: 70,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 11,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  authController
                                                      .getStoreList[index].openTime==null?
                                                  AppText(
                                                    title: "opens at 7AM onwards",
                                                    size: 10,
                                                    fontWeight: FontWeight.w700,
                                                    maxLines: 1,
                                                    overFlow: TextOverflow.ellipsis,
                                                    color: Color(0xffF8C647),):AppText(
                                    title: "opens at ${DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse((authController
                                        .getStoreList[index].openTime).toString()))} onwards",
                                    size: 10,
                                    fontWeight: FontWeight.w700,
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                    color: Color(0xffF8C647),),
                                                  SizedBox(height: 3,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      AppText(
                                                        title:authController
                                                            .getStoreList[index].name.toString(),
                                                        size: 16,
                                                        fontWeight: FontWeight.w500,
                                                        maxLines: 1,
                                                        overFlow: TextOverflow.ellipsis,
                                                        color: Colors.black,),
                                                      // Image.asset("assets/icons/heart.png",
                                                      // height: 20,
                                                      //   width: 20,
                                                      // )
                                                    ],
                                                  ),
                                                  SizedBox(height: 3,),
                                                  AppText(
                                                    title: authController
                                                        .getStoreList[index].address.toString(),
                                                    size: 12,
                                                    fontWeight: FontWeight.w400,
                                                    maxLines: 1,
                                                    overFlow: TextOverflow.ellipsis,
                                                    color: Color(0xff828282),),
                                                  SizedBox(height: 8,),

                                                  Row(
                                                    children: [
                                                      Container(decoration: BoxDecoration(
                                                        gradient: AppColor.Home_GRADIENT,
                                                        borderRadius: BorderRadius.circular(7)
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                        child: AppText(
                                                          title: "0",
                                                          size: 11,
                                                          fontWeight: FontWeight.w500,
                                                          maxLines: 1,
                                                          overFlow: TextOverflow.ellipsis,
                                                          color: Colors.white,),
                                                      ),
                                                      ),
                                                      SizedBox(width: Get.width*0.02,),
                                                      Container(decoration: BoxDecoration(

                                                          borderRadius: BorderRadius.circular(7),
                                                        color: Color(0xff45A843).withOpacity(0.2)
                                                      ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                          child: AppText(
                                                            title: "Offer available",
                                                            size: 11,
                                                            fontWeight: FontWeight.w400,
                                                            maxLines: 1,
                                                            overFlow: TextOverflow.ellipsis,
                                                            color: Color(0xff45A843),),
                                                        ),
                                                      )
                                                    ],
                                                  )

                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                        ),

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
              top: Get.height * 0.061,
              right:
              widget.type=="part"?20:
              100,
              child: GestureDetector(
                onTap: (){
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context,
                      builder: (context) =>   infoPaymentWidget());
                },
                child: Image.asset(
                  "assets/icons/info.png",



                  height: 25,
                  width: 25,

                ),
              )),
          Positioned(
              top: Get.height * 0.061,
              right:
              widget.type=="part"?0:
              20,
              child:
              widget.type=="part"?SizedBox.shrink():
              GestureDetector(
                onTap: (){
                    Get.delete<HomeController>();

                    HelperFunctions().clearPrefs();
                  Get.offAll(LoginView());
                },
                child: Container(
                  height: 28,
                  width: 69,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.primaryColor)

                  ),
                  child:  Center(
                    child: AppText(
                      title: join.tr,
                      maxLines: 1,

                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                      size: 14,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

