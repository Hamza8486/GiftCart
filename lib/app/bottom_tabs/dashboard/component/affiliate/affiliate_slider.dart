import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../util/translation_keys.dart';
import '../../../../../util/theme.dart';
import '../../../../../widgets/app_text.dart';

class AffiliateSliderItem extends StatelessWidget {
  const AffiliateSliderItem(
    this.item, {
    super.key,
  });

  final String item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/logo_man.png",
                        width: 31,
                        height: 22,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      specialOffer.tr,
                      style: GoogleFonts.italianno(
                          textStyle: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 5),
                        child: AppText(
                          title: fiftyOff.tr,
                          size: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    AppText(
                      title: onAllOrders.tr,
                      size: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Image.asset(
                  "assets/images/chat.png",
                  width: 104,
                  height: 32,
                )
              ],
            ),
          ),
          Stack(
            children: [
              Image.asset(
                item.toString(),
              ),
              Positioned(
                  top: 12,
                  right: 12,
                  child: Image.asset(
                    "assets/images/spoo.png",
                    width: 92,
                    height: 20,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
