// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'package:mr_bet/app/bottom_tabs/component/component.dart';
// import 'package:mr_bet/app/bottom_tabs/profile/component/component.dart';
// import 'package:mr_bet/util/theme.dart';
// import 'package:mr_bet/widgets/app_button.dart';
// import 'package:mr_bet/widgets/app_text.dart';
//
//
// class Verification extends StatelessWidget {
//   const Verification({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//
//         children: [
//           TopBar(onTap1: (){},onTap: (){
//             Get.back();
//           },text: "Verification",
//               image: "assets/icons/share.svg",color: AppColor.primaryColor
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: Get.height*0.025,),
//                     AppText(
//                       title: "Your Personal Details:",
//                       size: AppSizes.size_16,
//                       fontFamily: AppFont.semi,
//                       fontWeight: FontWeight.w700,
//                       color: AppColor.primaryColor,
//                     ),
//                     SizedBox(height: Get.height*0.015,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             textProfile("Your Name: Zain Ishtiaq"),
//                             SizedBox(height: Get.height*0.012,),
//                             textProfile("Phone No: +912 300 7896"),
//                           ],
//                         ),
//                         Image.asset("assets/icons/scan.png",
//                         height: Get.height*0.05,)
//                       ],
//                     ),
//                     SizedBox(height: Get.height*0.014,),
//                     textProfile("Confirmation No: XXXX-XXXX-XXXX-XXXX"),
//                     SizedBox(height: Get.height*0.014,),
//                     textProfile("Address: Salamat Pura Bus Stop, G.T Rd, Lahore"),
//                     SizedBox(height: Get.height*0.014,),
//                     textProfile("BC ID: XXXX-XXXX"),
//                     SizedBox(height: Get.height*0.03,),
//                     AppText(
//                       title: "Wining Prize Details:",
//                       size: AppSizes.size_16,
//                       fontFamily: AppFont.semi,
//                       fontWeight: FontWeight.w700,
//                       color: AppColor.primaryColor,
//                     ),
//                     SizedBox(height: Get.height*0.014,),
//                     textProfile("Prize: Maruti Suzuki Car"),
//                     SizedBox(height: Get.height*0.014,),
//                     textProfile("Car Colour: Grey"),
//                     SizedBox(height: Get.height*0.014,),
//                     textProfile("Car Modal: 2021"),
//                     SizedBox(height: Get.height*0.014,),
//                     textProfile("Pickup Address: Salamat Pura Bus Stop, G.T Rd"),
//                     SizedBox(height: Get.height*0.014,),
//                     textProfile("Pickup Date: 19-Feb-2023"),
//                     SizedBox(height: Get.height*0.014,),
//                     textProfile("Contact Us: +912 300 7896"),
//                     SizedBox(height: Get.height*0.014,),
//                     textProfile("Email at: Email@gmail.com"),
//                     SizedBox(height: Get.height*0.025,),
//                     Container(
//                       decoration: BoxDecoration(
//                           color: AppColor.redLight,
//                           borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: AppColor.primaryColor)
//                       ),
//                       child:Padding(
//                           padding:  EdgeInsets.symmetric(horizontal: 12,vertical: 10),
//                           child:   Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               AppText(
//                                 title: "Note:  ",
//                                 size: AppSizes.size_13,
//                                 color: AppColor.boldBlackColor,
//                                 fontFamily: AppFont.medium,
//
//
//                               ),
//
//                               Expanded(
//                                 child: AppText(
//                                   title: "Delivery of item depend on subject availability.",
//                                   size: AppSizes.size_13,
//                                   color: AppColor.boldBlackColor,
//                                   fontFamily: AppFont.medium,
//
//
//                                 ),
//                               ),
//                             ],
//                           )
//                       ) ,
//                     ),
//                     SizedBox(height: Get.height*0.035,),
//                     Padding(
//                       padding:  EdgeInsets.symmetric(horizontal: Get.width*0.07),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: AppButton(buttonName: "Save to gallery", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor, onTap: (){},
//                               buttonRadius: BorderRadius.circular(30),
//                               buttonWidth: Get.width,
//                               buttonHeight: Get.height*0.055,
//                             ),
//                           ),
//                           SizedBox(width: Get.width*0.03,),
//                           Expanded(
//                             child: AppButton(buttonName: "Print File", buttonColor: AppColor.whiteColor, textColor: AppColor.blackColor, onTap: (){},
//                               borderColor: AppColor.greyColors,
//                               buttonRadius: BorderRadius.circular(30),
//                               buttonWidth: Get.width,
//                               buttonHeight: Get.height*0.055,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
