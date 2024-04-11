import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../util/translation_keys.dart';
import '../../../../../util/theme.dart';
import '../../../../../widgets/app_text.dart';

class RedeemInfoBottomSheet extends StatefulWidget {
  const RedeemInfoBottomSheet({super.key});

  @override
  State<RedeemInfoBottomSheet> createState() => _RedeemInfoBottomSheetState();
}

class _RedeemInfoBottomSheetState extends State<RedeemInfoBottomSheet> {
  bool isLoading=true;
  final _key = UniqueKey();
  @override

  Widget build(BuildContext context) {
    return
      DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.92,
      maxChildSize: 0.92,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/slide.png",
                    scale: 3,
                  )
                ],
              ),
              SizedBox(height: Get.height * 0.03),
               AppText(
                  title: howDoesItWork.tr,
                  size: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackColor),
              SizedBox(height: Get.height * 0.025),
              Expanded(
                child: Stack(
                  children: [
                    WebView(
                      key: _key,
                      javascriptMode: JavascriptMode.unrestricted,
                      onPageFinished: (finish) {
                        setState(() {
                          isLoading = false;
                        });
                      },
                      initialUrl: 'https://admin.mr-corp.ca/help/Afffiliate',
                    ),
                    isLoading ? Container(
                        height: Get.height,
                        width: Get.width,
                        color: Colors.white,
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(
                              height: Get.height * 0.35,
                            ),
                            Center(
                              child: Container(
                                height: 57,width: 57,

                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                                  color: AppColor.primaryColor,),
                                child:  Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      backgroundColor: Colors.white,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColor.primaryColor.withOpacity(0.5) //<-- SEE HERE

                                      ),
                                      // strokeWidth: 5,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))
                        : Stack(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
