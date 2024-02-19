import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/login.dart';
import 'package:mr_bet/app/home/home_view.dart';
import 'package:mr_bet/app/onboarding/view.dart';
import 'package:mr_bet/app/vendor_home/vendor_home.dart';
import 'package:mr_bet/widgets/helper_function.dart';

hideKeyBoard(BuildContext context){
  FocusScope.of(context).unfocus();
}

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {




  String type = "";


  @override
  void initState() {

    super.initState();
    HelperFunctions.getFromPreference("type").then((value) {
      setState(() {
        type = value;
      });
      print("This is token email${type.toString()}");
      log(type);
      moveToNext();
    });
  }

  void moveToNext() {
    Timer(const Duration(seconds: 3), () {
      if (type == "user") {
        Get.offAll(()=>Home(),
            transition: Transition.cupertinoDialog
        );
      }
        else if(type == "business"){
        Get.offAll(()=>VendorHome(),
            transition: Transition.cupertinoDialog
        );
      }

     else {
        Get.offAll(()=>OnBoardingView(),
            transition: Transition.cupertinoDialog
        );

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    hideKeyBoard(context);
    return Scaffold(

        body: Center(
          child: Image.asset("assets/images/logo.gif",
            height: 164,
            width: 214,
          ),
        ));
  }
}
