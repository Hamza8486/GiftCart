import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_bet/app/auth/login.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';
final Shader linearGradient = const LinearGradient(
  colors: <Color>[Color(0xffF33F41), Color(0xffFB6D72)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
class OnBoardingView extends StatelessWidget {
   OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [

              Image.asset("assets/icons/layer.png",
              fit: BoxFit.cover,

                width: Get.width,
              )



            ],
          ),
          Padding(
            padding:  EdgeInsets.only(bottom: Get.height*0.02),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    "MR | Corporation",
                    style: GoogleFonts.poppins(
                      textStyle : TextStyle(

                          fontSize: 23,

                          fontWeight: FontWeight.w500,
                          foreground: Paint()..shader = linearGradient),

                    )),
                SizedBox(height: Get.height*0.015,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                  child: Center(
                    child: AppText(
                      title:"At the heart of our business is a commitment to redefining your grocery experience. By offering premium grocery services, we aim to simplify your shopping needs, ensuring quality products are delivered to your doorstep.",
                      color: AppColor.gray,
                      textAlign: TextAlign.center,

                      size: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: Get.height*0.025),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                  child: AppButton(buttonName: "Get started", buttonColor: AppColor.primaryColor, textColor: AppColor.whiteColor, onTap: (){
                    Get.to(LoginView(),
                    transition: Transition.native
                    );
                  },
                  fontWeight: FontWeight.w600,
                    textSize: 16,
                    buttonRadius: BorderRadius.circular(10),
                    buttonWidth: Get.width,
                  ),
                )


              ],
            ),
          ),
        ],
      ),
    );
  }
}
