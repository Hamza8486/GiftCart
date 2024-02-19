import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/theme.dart';
import '../../util/toast.dart';
import '../../widgets/app_text.dart';

class ReferContactItem extends StatelessWidget {
  const ReferContactItem(this.contact, this.code, {super.key});

  final Contact contact;
  final String code;

  _textMe(String phone) async {
    if (Platform.isAndroid) {
      var uri = "sms:+" +
          phone +
          "?body=Here%20is%20referal%20code" +
          code.toString();
      await launch(uri);
    } else if (Platform.isIOS) {
      // iOS
      const uri = 'sms:0039-222-060-888&body=hello%20there';
      await launch(uri);
    }
  }

  whatsapp(String phone, String message) async {
    var contact = "+" + phone;
    var androidUrl = "whatsapp://send?phone=$contact&text=" + message;
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse(message)}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      flutterToast(msg: "Whatsapp not installed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: Get.height * 0.05,
                  width: Get.height * 0.05,
                  decoration: BoxDecoration(
                      color: AppColor.lightBlue,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: AppText(
                      title: contact.displayName[0],
                      size: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.04,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title: contact.displayName,
                      size: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.blackColor,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    AppText(
                      title: contact.phones.isNotEmpty
                          ? contact.phones.first.number
                          : "",
                      size: 12,
                      fontFamily: AppFont.regular,
                      fontWeight: FontWeight.w500,
                      color: AppColor.greyLightColor2,
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                InkResponse(
                  onTap: () {
                    _textMe(contact.phones.first.number);
                  },
                  child: Image.asset(
                    "assets/images/wh.png",
                    height: 25,
                    width: 25,
                  ),
                ),
                SizedBox(width: 20),
                InkResponse(
                  onTap: () {
                    whatsapp(contact.phones.first.number,
                        "Hi this is your referal code " + code);
                  },
                  child: Image.asset(
                    "assets/images/mess.png",
                    height: 25,
                    width: 25,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
