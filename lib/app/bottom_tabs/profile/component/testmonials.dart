// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:mr_bet/app/auth/controller.dart';
// import 'package:mr_bet/app/bottom_tabs/component/component.dart';
// import 'package:mr_bet/app/bottom_tabs/profile/component/video_view.dart';
// import 'package:mr_bet/app/home/controller/home_controller.dart';
// import 'package:mr_bet/util/theme.dart';
// import 'package:mr_bet/widgets/app_text.dart';
// import 'package:mr_bet/widgets/helper_function.dart';
//
// class Testimonials extends StatefulWidget {
//   const Testimonials({Key? key}) : super(key: key);
//
//   @override
//   State<Testimonials> createState() => _TestimonialsState();
// }
//
// class _TestimonialsState extends State<Testimonials> {
//   String? _selectedItem;
//   var provinceId;
//   final homeController = Get.put(HomeController());
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Get.put(HomeController()).getAllTest();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           TopBar(
//           onTap1: () {},
//
//
//         onTap: () {
//
//         },
//         text: "Testimonials",
//         isValue: false,
//         Child: Container(height: Get.height*0.05,),
//         image: "assets/icons/share.svg",
//         color: AppColor.whiteColor),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: Get.height * 0.015,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         AppText(
//                           title: "Our User’s Reviews",
//                           size: AppSizes.size_16,
//                           fontFamily: AppFont.medium,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black,
//                         ),
//                         Padding(
//                           padding:  EdgeInsets.only(right:Get.width * 0.0 ),
//                           child: SizedBox(
//                             height: Get.put(AuthController()).provinceList.isEmpty
//                                 ? Get.height * 0.055
//                                 : Get.height * 0.055,
//                             child: PopupMenuButton(
//                               shape: const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(10.0),
//                                 ),
//                               ),
//                               offset: const Offset(0, 55),
//                               onSelected: (value) async {
//                                 setState(() {
//                                   homeController.getAllTest(id: value.toString());
//
//
//
//                                 });
//                               },
//                               constraints: BoxConstraints(
//                                   minWidth: Get.height * 0.08,
//                                   maxWidth: Get.height * 0.08,
//                                   maxHeight: Get.height*0.25),
//                               itemBuilder: (BuildContext bc) {
//                                 return List.generate(
//                                     Get.put(AuthController()).provinceList.length, (index ) {
//                                   return  PopupMenuItem(
//                                       padding:
//                                       const EdgeInsets.symmetric(horizontal: 12),
//                                       value:  Get.put(AuthController()).provinceList[index]
//                                           .id
//                                           .toString(),
//                                       child: AppText(
//                                         title: Get.put(AuthController()).provinceList[index]
//                                             .name
//                                             .toString(),
//
//                                         size: AppSizes.size_13,
//                                         fontWeight: FontWeight.w600,
//                                         fontFamily: AppFont.medium,
//                                         color: AppColor.blackColor,
//                                       ));
//                                 });
//                               },
//                               child:Center(
//                                 child: Image.asset(
//                                   "assets/images/filter1.png",
//
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//
//                       ],
//                     ),
//                     SizedBox(
//                       height: Get.height * 0.015,
//                     ),
//                     Obx(
//                       () {
//                         return
//                          homeController.testLoading.value?
//                          Column(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: [
//                              SizedBox(height: Get.height * 0.32),
//                              Center(
//                                child: Container(
//                                  height: 57,width: 57,
//
//                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
//                                    color: AppColor.primaryColor,),
//                                  child:  Padding(
//                                    padding: EdgeInsets.all(15.0),
//                                    child: Center(
//                                      child: CircularProgressIndicator(
//                                        strokeWidth: 3,
//                                        backgroundColor: Colors.white,
//                                        valueColor: AlwaysStoppedAnimation<Color>(
//                                            AppColor.primaryColor.withOpacity(0.5) //<-- SEE HERE
//
//                                        ),
//                                        // strokeWidth: 5,
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              )
//                            ],
//                          ):
//                          homeController.testList.isNotEmpty?
//                           GridView.builder(
//                             padding: EdgeInsets.zero,
//                             shrinkWrap: true,
//                             primary: false,
//                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 3,
//                                 childAspectRatio: Get.width / Get.height * 1.6,
//                                 crossAxisSpacing: 30,
//                                 mainAxisSpacing: 16),
//                             itemCount: homeController.testList.length,
//                             itemBuilder: (BuildContext ctx, index) {
//                               return GestureDetector(
//                                 onTap: (){
//                                   Get.to(VideoViewDetail(data:homeController.testList[index].video,));
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: AppColor.whiteColor,
//                                     // border: Border.all(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(10),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.1),
//                                         spreadRadius: 2,
//                                         blurRadius: 7,
//                                         offset: Offset(0, 2), // changes position of shadow
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),
//                                             topRight: Radius.circular(8)),
//                                         child:CachedNetworkImage(
//                                           placeholder: (context, url) =>  Center(
//                                             child: SpinKitThreeBounce(
//                                                 size: 16,
//                                                 color: AppColor.primaryColor
//                                             ),
//                                           ),
//                                           imageUrl:
//                                           homeController.testList[index].image==null?"":
//                                           homeController.testList[index].image.toString(),
//                                           height: Get.height * 0.11,
//                                           width: Get.width,
//                                           fit: BoxFit.cover,
//
//                                           errorWidget: (context, url, error) => Image.asset(
//                                             "assets/images/persons.jpg",
//                                             fit: BoxFit.cover,
//                                             height: Get.height * 0.11,
//                                             width: Get.width,
//                                           ),
//                                         ),
//
//
//
//
//                                       ),
//                                       SizedBox(height: Get.height*0.01,),
//                                       Padding(
//                                         padding:  EdgeInsets.symmetric(horizontal: Get.width*0.01),
//                                         child: SizedBox(
//                                           width:Get.width*0.24,
//                                           child: Center(
//                                             child: AppText(
//                                               title: homeController.testList[index].firstName,
//                                               size: AppSizes.size_15,
//                                               maxLines: 1,
//                                               fontFamily: AppFont.medium,
//                                               overFlow: TextOverflow.ellipsis,
//
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(height: Get.height*0.01,),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }):Column(
//                            children: [
//                              SizedBox(height: Get.height*0.34,),
//                              Center(child: AppText(title: "No Testimonials Data!",
//                                color: AppColor.blackColor.withOpacity(0.7),
//                                size: 16,
//                                fontWeight: FontWeight.w500,
//                              ))
//                            ],
//                          );
//                       }
//                     ),
//                     SizedBox(
//                       height: Get.height * 0.025,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
// }


import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_bet/app/auth/component.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/bottom_tabs/component/drawer.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/slot_model.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/view/dashboard_view.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/notification_view.dart';
import 'package:mr_bet/app/bottom_tabs/profile/component/video_view.dart';
import 'package:mr_bet/app/bottom_tabs/wallet/view/wallet_view.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/toast.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';



class Testimonials extends StatefulWidget {
  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {
  final homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current = 0;
  List<String> bannerList = [
    'assets/images/banner9.png',
    'assets/images/banner10.png',
    'assets/images/banner11.png',
  ];

  final CarouselController _controller = CarouselController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Column(

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
                            padding: const EdgeInsets.only(left: 0),
                            child: AppText(
                              title: "Testimonials",
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

              Expanded(child: Container(
                decoration: BoxDecoration(
                    gradient: AppColor.Home_GRADIENT
                ),
                height: Get.height,
                width: Get.width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 25),
                    child: Column(
                      children: [
                        AppText(
                          title: "Here affordability meets convenience",
                          size: 16,

                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        AppText(
                          title: "because you deserve the best without\n breaking the bank. ",
                          size: 12,
                          textAlign: TextAlign.center,

                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        SizedBox(height: 12,),
                        CarouselSlider(
                          carouselController: _controller,
                          options: CarouselOptions(
                            aspectRatio: 16 / 9,
                            pageSnapping: false,
                            height: 185,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            pauseAutoPlayInFiniteScroll: false,
                            reverse: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 2),
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
                            onTap: () {},
                            child: Container(
                              child: Image.asset(
                                item.toString(),
                                width: 157,
                                fit: BoxFit.cover,

                              ),
                            ),
                          ))
                              .toList(),
                        ),
                        SizedBox(height: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: bannerList.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 20.0,
                                height: 2.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    color: _current == entry.key
                                        ? AppColor.primaryColor
                                        :

                                    AppColor.whiteColor),
                              ),
                            );
                          }).toList(),
                        )

                      ],
                    ),
                  ),
                ),
              ))

            ],
          ),


          DraggableSheet(),
        ],
      ),
    );
  }

}

class DraggableSheet extends StatefulWidget {
  @override
  State<DraggableSheet> createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {

  final homeController = Get.put(HomeController());

  int _current = 0;

  final CarouselController _controller = CarouselController();

  String? _selectedItem;
  var provinceId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(HomeController()).getAllTest();
  }
  List<String> bannerList = [
    'assets/images/mans.png',
    'assets/images/mans.png',
    'assets/images/mans.png',

    // Add more image paths as needed
  ];
  void openWhatsApp({String phoneNumber ="", String message=""}) async {
    String url = "https://wa.me/$phoneNumber?text=${Uri.parse(message)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String? provinceName;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.66,
      minChildSize: 0.46,

      maxChildSize: 0.87, // Maximum percentage of the screen height
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.015,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width:40,
                    height: 5,
                    decoration: BoxDecoration(
                        color: AppColor.greyLightColor2
                    ),)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Obx(
                                () {
                              return
                                Get.put(AuthController()).allAdsLoader.value?
                                Center(
                                    child: SpinKitThreeBounce(
                                        size: 25, color: AppColor.primaryColor)):

                                Get.put(AuthController()).getAllAdsList.isNotEmpty?

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
                                      items: Get.put(AuthController()).getAllAdsList
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
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              title: "Our User’s Reviews",
                              size: AppSizes.size_16,
                              fontFamily: AppFont.medium,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            Padding(
                              padding:  EdgeInsets.only(right:Get.width * 0.0 ),
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
                                      homeController.getAllTest(id: value.toString());



                                    });
                                  },
                                  constraints: BoxConstraints(
                                      minWidth: Get.height * 0.08,
                                      maxWidth: Get.height * 0.08,
                                      maxHeight: Get.height*0.25),
                                  itemBuilder: (BuildContext bc) {
                                    return List.generate(
                                        Get.put(AuthController()).provinceList.length, (index ) {
                                      return  PopupMenuItem(
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 12),
                                          value:  Get.put(AuthController()).provinceList[index]
                                              .id
                                              .toString(),
                                          child: AppText(
                                            title: Get.put(AuthController()).provinceList[index]
                                                .name
                                                .toString(),

                                            size: AppSizes.size_13,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: AppFont.medium,
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
                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        Obx(
                                () {
                              return
                                homeController.testLoading.value?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: Get.height * 0.02),
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
                                homeController.testList.isNotEmpty?
                                GridView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    primary: false,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 102/150,
                                        crossAxisSpacing: 30,
                                        mainAxisSpacing: 16),
                                    itemCount: homeController.testList.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return GestureDetector(
                                        onTap: (){
                                          Get.put(HomeController()).updateLikeStatus(false);
                                          homeController.getLikeTestMonial(id:homeController.testList[index].id.toString() );
                                          homeController.getComments(id:homeController.testList[index].id.toString() );

                                          Get.to(VideoViewDetail(data:homeController.testList[index],));
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 150,
                                              width: 102,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: AppColor.primaryColor)
                                              ),

                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child:CachedNetworkImage(
                                                  placeholder: (context, url) =>  Center(
                                                    child: SpinKitThreeBounce(
                                                        size: 16,
                                                        color: AppColor.primaryColor
                                                    ),
                                                  ),
                                                  imageUrl:
                                                  homeController.testList[index].image==null?"":
                                                  homeController.testList[index].image.toString(),
                                                  height: 150,
                                                  width: 102,
                                                  fit: BoxFit.cover,

                                                  errorWidget: (context, url, error) => Image.asset(
                                                    "assets/images/pers.png",
                                                    fit: BoxFit.cover,
                                                    height: 150,
                                                    width: 102,
                                                  ),
                                                ),




                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    width:Get.width*0.24,
                                                    child: AppText(
                                                      title: homeController.testList[index].firstName,
                                                      size: 12,
                                                      maxLines: 2,
                                                      textAlign: TextAlign.start,


                                                      fontWeight: FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(height: 6,),
                                                  Row(
                                                    children: [
                                                      Image.asset("assets/images/like.png",
                                                      height: 10,
                                                        width: 10,
                                                      ),
                                                      SizedBox(width: 3,),
                                                      AppText(
                                                        title:
                                                        homeController.testList[index].likes==null?"0":
                                                        homeController.testList[index].likes.toString(),
                                                        size: 10,
                                                        maxLines: 1,
                                                        textAlign: TextAlign.start,


                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 6,),
                                                      Image.asset("assets/images/com.png",
                                                        height: 10,
                                                        width: 10,
                                                      ),
                                                      SizedBox(width: 3,),
                                                      AppText(
                                                        title:  homeController.testList[index].comments==null?"0":
                                                        homeController.testList[index].comments.toString(),
                                                        size: 10,
                                                        maxLines: 1,
                                                        textAlign: TextAlign.start,


                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }):Column(
                                  children: [
                                    SizedBox(height: Get.height*0.34,),
                                    Center(child: AppText(title: "No Testimonials Data!",
                                      color: AppColor.blackColor.withOpacity(0.7),
                                      size: 16,
                                      fontWeight: FontWeight.w500,
                                    ))
                                  ],
                                );
                            }
                        ),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
