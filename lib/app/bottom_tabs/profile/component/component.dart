  import 'package:flutter/material.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_text.dart';

Widget textProfile({text,text1,Color?color,Color?textColor}){
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText(
        title: text,
        size: 15,

        fontWeight: FontWeight.w500,
        color: color??AppColor.blackColor,
      ),
      SizedBox(height: 5,),
      AppText(
        title: text1,
        size: 13,

        fontWeight: FontWeight.w500,
        color: textColor??AppColor.greyLightColor,
      ),
    ],
  );
  }