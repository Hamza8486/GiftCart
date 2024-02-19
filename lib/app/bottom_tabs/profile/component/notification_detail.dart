import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';

import 'package:timeago/timeago.dart' as timeago;
class NotificationDetail extends StatefulWidget {
  const NotificationDetail({super.key});

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  int _current = 0;
  List<String> bannerList = [
    'assets/images/mans.png',
    'assets/images/mans.png',
    'assets/images/mans.png',

    // Add more image paths as needed
  ];
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(onTap1: (){},onTap: (){
            Get.back();
          },text: "Notification Detail",
              image: "assets/icons/share.svg",color: AppColor.whiteColor
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12,),
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

                                        Color(0xffD9D9D9)),
                                  ),
                                );
                              }).toList(),
                            )),

                      ],
                    ),
                    SizedBox(height: 25,),
                    AppText(
                        title: "Exclusive offer for you!",
                        size: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackColor),
                    SizedBox(height: 10,),
                    AppText(
                        title: "Indulge in the ultimate culinary experience with our restaurant offer notifications! Receive a symphony of exclusive deals, seasonal specials, and enticing discounts, including irresistible buy-one-get-one offers. Elevate your dining journey as our notifications bring a banquet of savings directly to you, ensuring every meal is a celebration of flavors and value",
                        size: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.greyLightColor2),





                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppButton(
                buttonWidth: Get.width,
                buttonRadius: BorderRadius.circular(10),
                buttonName: "Order now",
                fontWeight: FontWeight.w500,
                textSize:16,
                buttonColor: AppColor.primaryColor,
                textColor: AppColor.whiteColor,
                onTap: (){}),
          ),
          SizedBox(
            height: Get.height * 0.016,
          ),

        ],
      ),
    );
  }
}
