import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import 'package:mr_bet/app/bottom_tabs/component/component.dart';
import 'package:mr_bet/app/home/controller/home_controller.dart';

import 'package:mr_bet/util/theme.dart';

class FaqView extends StatelessWidget {
  const FaqView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            body: Column(children: [
              TopBar(onTap1: (){},onTap: (){
                Get.back();
              },text: "FAQ",
                  image: "assets/icons/share.svg",color: AppColor.whiteColor
              ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () {
                    return
                      Get.put(HomeController()).faqLoading.value?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: Get.height * 0.35),
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
                      ):


                      ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: Get.put(HomeController()).faqList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                          child: ExpandBox(
                            text:
                            Get.put(HomeController()).faqList[index].question,
                            text1: Get.put(HomeController()).faqList[index].answer,
                          ),
                        );
                      },
                    );
                  }
                )
              ],
            ),
          ))
        ])),
      ],
    );
  }
}


// ignore_for_file: prefer_const_constructors



class ExpandBox extends StatelessWidget {
  ExpandBox({Key? key,this.text,this.text1}) : super(key: key);


  var text;
  var text1;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Obx(
          () => Container(
        width: width,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Color(0xffF65356).withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: Get.height*0.008,horizontal: Get.width*0.02),
            child: ExpansionTile(
              title:  Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff3B3B3B),
                ),
              ),
              trailing: Get.put(HomeController()).expand.value == true
                  ? const Icon(Icons.arrow_drop_up, color: AppColor.primaryColor)
                  : const Icon(Icons.arrow_drop_down, color: AppColor.primaryColor),
              onExpansionChanged: (bool val) {
                Get.put(HomeController()).expand.value = val;
              },

              children:  [
                ListTile(
                  title: Text(
                    text1,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.blackColor,

                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
