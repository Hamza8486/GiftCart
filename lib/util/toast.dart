import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:shimmer/shimmer.dart';

Future<bool?> flutterToast({msg}) {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 0,
  );
}

Future<bool?> flutterToastSuccess({msg}) {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 0,
  );
}

Future<bool?> flutterToastSuccess1({msg}) {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 0,
  );
}

Future<bool> showExit({context, onTap}) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: 95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doYouWantToLogout.tr,
                  style: TextStyle(
                      color: AppColor.blackColor, fontFamily: AppFont.medium),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: Text(no.tr, style: TextStyle(color: Colors.black)),
                    )),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                            primary: AppColor.primaryColor),
                        child: Text(
                          yes.tr,
                          style: TextStyle(color: AppColor.whiteColor),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

Future<bool> deleteAddress({context, onTap}) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doYouWantToDelete.tr,
                  style: TextStyle(
                      color: AppColor.blackColor,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: Text(no.tr, style: TextStyle(color: Colors.black)),
                    )),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                            primary: AppColor.primaryColor),
                        child: Text(
                          yes.tr,
                          style: TextStyle(color: AppColor.whiteColor),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

Future<bool> showExitPopup(context, index, onChange) async {
  if (index == 0) {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doYouWantToExit.tr,
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child:
                            Text(no.tr, style: TextStyle(color: Colors.black)),
                      )),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.primaryColor),
                          child: Text(
                            yes.tr,
                            style: TextStyle(color: AppColor.whiteColor),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  } else {
    onChange(0);
    return false;
  }
}

Widget loader() {
  return Column(
    children: [
      SizedBox(
        height: Get.height * 0.35,
      ),
      Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.black26,
        valueColor:
            AlwaysStoppedAnimation<Color>(AppColor.primaryColor //<-- SEE HERE

                ),
      )),
    ],
  );
}

Widget noData({double? height}) {
  return Column(children: [
    SizedBox(height: height ?? Get.height * 0.25),
    SvgPicture.asset(
      "assets/images/notfound.svg",
      height: Get.height * 0.038,
    ),
    SizedBox(height: Get.height * 0.01),
    Center(
        child: AppText(
      title: noRecordFound.tr,
      size: Get.height * 0.015,
      color: AppColor.blackColor,
      fontFamily: AppFont.medium,
      fontWeight: FontWeight.w600,
    )),
    SizedBox(height: Get.height * 0.01),
  ]);
}

Shimmer getShimmerLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 100,
          width: 100,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 18.0,
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 14.0,
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 14.0,
                color: Colors.white,
              ),
            ],
          ),
        )
      ],
    ),
  );
}
