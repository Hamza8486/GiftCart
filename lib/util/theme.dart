import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_button.dart';

class AppColor {

 static const primaryColor = Color(0xFFF03C3D);
 static const primaryColor1 = Color(0xFFFD7E85);
 static const blueColor = Color(0xFF007BFF);
 static const blueColor1 = Color(0xFF002F61);

 static const yellowColor = Color(0xFFFF8800);
 static const yellowColor1 = Color(0xFFD77400);


 static const greenColor = Color(0xFF00C853);
 static const greenColor1 = Color(0xFF007731);

  static const grey2Color = Color(0xFF606060);
  static const grey5Color = Color(0xFF686868);
  static const grey3Color = Color(0xFF707070);
  static const grey4Color = Color(0xFFE5E5E5);
  static const lightBlue =  Color(0xff80C2FF);

  static const borderColorField = Color(0xFFC4C4C4);
  static Color tabsColor = const Color(0xffF7F7F7);
  static Color greyColors = const Color(0xff808080);
  static Color greyColors1 = const Color(0xffDDDDDD);

  static const whiteColor = Colors.white;
  static Color get gray => const Color(0xff786F72);
  static Color get grey => const Color(0xff9DB2CE);
  static Color get greys => const Color(0xffEEEEEE);

  static const lightAppColor2 = Color(0xFFBAD3FC);
  static const redLight = Color(0xFFFFDEE2);
  static const lightRed = Color(0xFFFFCDCC);

  static const boxAppColor = Color(0xFFBAD3FC);
 static const blackLightColor =Color(0xFF434343);
  static const blackColor = Color(0xFF000000);
  static const tabColor = Color(0xFF9DB2CE);
 static const greyLightColor =Color(0xFF929292);
 static const greyLightColor2 =Color(0xFF949494);
  static Color catBorderColors = const Color(0xffD8D1D1);
  static const boldBlackColor = Color(0xFF212121);
  static const headColor = Color(0xFFF0F0F0);
  static const textGreyColor = Color(0xFF9099A8);
  static const grey4 = Color(0xFFA4A4A4 );
  static const greyColor = Colors.grey;
  static const transParent = Colors.transparent;


 static Gradient Home_GRADIENT = const LinearGradient(
   begin: Alignment.topCenter,
   end: Alignment.bottomCenter,
   colors: [
     Color(0xfffa7175),
     Color(0xfff65255),
   ],
 );


}

class AppSizes {
  static double size_10 = Get.height / 81.2;
  static double size_11 = Get.height / 73.8;
  static double size_12 = Get.height / 67.7;
  static double size_13 = Get.height / 62.5;
  static double size_14 = Get.height / 58;
  static double size_15 = Get.height / 54.1;
  static double size_16 = Get.height / 50.8;
  static double size_17 = Get.height / 47.8;
  static double size_18 = Get.height / 45.1;
  static double size_19 = Get.height / 42.7;
  static double size_20 = Get.height / 40.6;
  static double size_21 = Get.height / 38.7;
  static double size_22 = Get.height / 36.9;
  static double size_23 = Get.height / 35.3;
  static double size_24 = Get.height / 33.8;
  static double size_25 = Get.height / 32.5;
  static double size_26 = Get.height / 31.2;
  static double size_27 = Get.height / 30.1;
  static double size_28 = Get.height / 29;
  static double size_29 = Get.height / 28;
  static double size_30 = Get.height / 27.1;
}




class AppPaddings {
  static EdgeInsets mainPadding = EdgeInsets.only(
      right: Get.width * 0.04,left: Get.width * 0.04, top: Get.height * 0.025, bottom: Get.height * 0.01);


  static EdgeInsets mainHomePadding = EdgeInsets.only(
      left: Get.width * 0.04,right: Get.width * 0.04, top: Get.height * 0.04);
  static EdgeInsets mainHorizontal = EdgeInsets.symmetric(
      horizontal: Get.width * 0.04);
  static EdgeInsets mainVertical = EdgeInsets.symmetric(
      vertical: Get.height * 0.025);
}

void showLoadingIndicator({required BuildContext context}) {
  showDialog(
    barrierDismissible: false,
    useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          height: 65,width: 65,

          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),     color: Colors.white,),
          child: Container(

            height: 25,width: 25,color: Colors.transparent,child:   Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.black26,
              valueColor: AlwaysStoppedAnimation<Color>(
                  AppColor.primaryColor //<-- SEE HERE

              ),
                // strokeWidth: 5,
          ),
            ),),
        ),
      );
    },
  );
}
class AppFont {
  static String regular = "regular";
  static String medium = "medium";
  static String bold = "bold";
  static String semi = "semi";

}
showAlertDialog(
    {required BuildContext context,
      required String text,
      required VoidCallback yesOnTap,
      bool isBoth = true}) {
  // set up the buttons
  Widget cancelButton = AppButton(
      buttonName: yes.tr,
      buttonWidth: 100,
      buttonHeight: 40,
      buttonRadius: BorderRadius.circular(10),
      buttonColor: AppColor.primaryColor,
      textColor: Colors.white.withOpacity(0.8),
      onTap: yesOnTap);
  Widget continueButton = AppButton(
      buttonName: no.tr,
      buttonWidth: 100,
      buttonHeight: 40,
      buttonRadius: BorderRadius.circular(10),
      buttonColor: Colors.transparent,
      textColor: AppColor.boldBlackColor,
      borderColor: AppColor.primaryColor,
      onTap: () {
        Get.back();
      });
  AlertDialog alert = AlertDialog(
    content: Text(text,style: TextStyle(color: AppColor.boldBlackColor,fontFamily: AppFont.medium),),
    actions: [
      cancelButton,
      isBoth ? continueButton : Container(),
    ],
    actionsPadding: EdgeInsets.only(bottom: 10,right: 10,left: 10),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
void showLoading({required BuildContext context}) {
  showDialog(
    barrierDismissible: false,
    useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(

          height: 40,width: 40,color: Colors.transparent,child:    Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white.withOpacity(0.8),
            valueColor: const AlwaysStoppedAnimation<Color>(
                AppColor.primaryColor //<-- SEE HERE

            ),
            // strokeWidth: 5,
          ),
        ),),
      );
    },
  );
}