import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';



class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  bool isLoading=true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(onTap1: (){},onTap: (){
            Get.back();
          },text: "Privacy Policy",
              image: "assets/icons/share.svg",color: AppColor.whiteColor
          ),

          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                  child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageFinished: (finish) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    initialUrl: 'https://slot-app-8c4916a05b3c.herokuapp.com/get_general/policy/',
                  ),
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
    );
  }
}

