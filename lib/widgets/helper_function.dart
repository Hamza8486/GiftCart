// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_text.dart';


import 'package:shared_preferences/shared_preferences.dart';


class HelperFunctions {


  static Future<File?> pickImage(ImageSource imageSource) async {
    File imageFile;
    final file = await ImagePicker().pickImage(source: imageSource,imageQuality: 25);
    if (file != null) {
      imageFile = File(file.path);
      return imageFile;
    } else {
      print("No image selected");
    }
    return null;
  }


  static saveInPreference(String preName, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(preName, value);
    print('Bismillah: In save preference function');
  }

  static Future<String> getFromPreference(String preName) async {
    String returnValue = "";

    final prefs = await SharedPreferences.getInstance();
    returnValue = prefs.getString(preName) ?? "";
    return returnValue;
  }



  Future<bool>  clearPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    return true;
  }
}

Future<bool> signout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  return true;
}

Widget loader({double?height}){
  return Column(
    children: [
      SizedBox(
        height:height?? Get.height * 0.35,
      ),
       Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.black26,
            valueColor: AlwaysStoppedAnimation<Color>(
                AppColor.primaryColor //<-- SEE HERE

            ),
          )),
    ],
  );
}
Widget noData({double?height}){
  return Column(children: [
    SizedBox(height:height?? Get.height * 0.23),
    SvgPicture.asset(
      "assets/images/notfound.svg",
      height: Get.height * 0.038,
    ),
    SizedBox(height: Get.height * 0.01),
    Center(
        child: AppText(
          title: noRecordFound.tr,
          size: Get.height * 0.014,
          color: AppColor.blackColor,
          fontFamily: AppFont.medium,
          fontWeight: FontWeight.w500,
        )),
    SizedBox(height: Get.height * 0.01),
  ]);
}

