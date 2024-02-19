import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/util/theme.dart';
import 'package:mr_bet/widgets/app_button.dart';
import 'package:mr_bet/widgets/app_text.dart';



class ScannerSheet extends StatefulWidget {
  const ScannerSheet({Key? key}) : super(key: key);


  @override
  State<ScannerSheet> createState() => _ScannerSheetState();
}

class _ScannerSheetState extends State<ScannerSheet> {

  @override
  Widget build(BuildContext context) {

    var size = Get.size;
    return DraggableScrollableSheet(
      initialChildSize:0.8,
      minChildSize:0.8,
      maxChildSize:0.8,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.transParent,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: Get.height*0.3,),
                  Container(
                    width: Get.width,
                    color: AppColor.grey2Color,
                    height: Get.height*0.36,
                    child: Column(
                      children: [
                        SizedBox(height: Get.height*0.24,),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: Get.width*0.08),
                          child: AppButton(buttonName: cancel.tr, buttonColor: AppColor.whiteColor, textColor: AppColor.grey2Color.withOpacity(0.7), onTap: (){
                            Get.back();
                          },
                          buttonHeight: Get.height*0.055,
                            buttonWidth: Get.width,
                            buttonRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              ),
              Positioned(
                top: Get.height*0.15,
                child:  Container(height: Get.height*0.35,
                width: Get.width,
                decoration: BoxDecoration(color: Colors.white,
                    shape: BoxShape.circle
                ),
              ),)
            ],
          ),
        ),
      ),
    );
  }


}


Widget addButton({onTap, color}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(10),
      border: Border.all(color:AppColor.primaryColor,

      width: 1.5)
      ),
      height: Get.height * 0.054,
      width: Get.height * 0.055,
      child: Center(
        child: Icon(Icons.add_circle_sharp,
        color: color,
        ),
      ),
    ),
  );
}