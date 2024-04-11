import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftcart/util/toast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:screenshot/screenshot.dart';
import 'package:giftcart/app/bottom_tabs/component/component.dart';
import 'package:giftcart/app/bottom_tabs/component/drawer.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';
import 'package:giftcart/util/theme.dart';
import 'package:giftcart/widgets/app_button.dart';
import 'package:giftcart/widgets/app_text.dart';
import 'package:pdf/widgets.dart' as pw;

class VerificationView extends StatefulWidget {
  VerificationView({Key? key, this.id, this.phone, this.confirm, this.address})
      : super(key: key);

  var phone;
  var address;
  var id;
  var confirm;

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _screenshotController = ScreenshotController();
  Future<Uint8List> generatePdf() async {
    // Create a PDF document
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Your PDF Content Here'),
          );
        },
      ),
    );

    // Save the PDF as bytes
    return pdf.save();
  }
  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Screenshot(
        controller: _screenshotController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(
              onTap1: () {
                print("object");
              },
              onTap: () {
                Get.back();
              },
              text: "Verification",
              image: "assets/icons/share.svg",
              color: Colors.white
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      AppText(
                        title: "Your Personal Details:",
                        size: 16,
                        fontWeight: FontWeight.w700,
                        color:Color(0xffF33F41),
                      ),
                      Container(height: 2,
                        width: 50,
                        decoration: BoxDecoration(
                            color:Color(0xffF33F41),
                            borderRadius: BorderRadius.circular(2)
                        ),
                      ),
                      SizedBox(height: 24,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                      () {
                                    return AppText(
                                      title: "Your Name : ${homeController.name.value}",
                                      size:  homeController.email.value.isEmpty?14:
                                      14,
                                      fontWeight: FontWeight.w500,
                                      color:Color(0xff808080),
                                    );
                                  }
                              ),
                              SizedBox(height: 16,),
                              AppText(
                                title: "Phone No : ${widget.phone.toString()}",
                                size: 14 ,
                                fontWeight: FontWeight.w500,
                                color:Color(0xff808080),
                              ),
                            ],
                          ),
                          Image.asset("assets/icons/confirm.png",
                            width: 82,
                            height: 49,
                          )
                        ],
                      ),
                      SizedBox(height: 16,),
                      AppText(
                        title: "Confirmation No : 000${homeController.profileAllData?.data?.id.toString()}",
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color:Color(0xff808080),
                      ),
                      SizedBox(height: 16,),
                      AppText(
                        title: "Address : ${widget.address.toString()}",
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color:Color(0xff808080),
                      ),
                      SizedBox(height: 16,),
                      AppText(
                        title: "BC ID : ${widget.id.toString()}",
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color:Color(0xff808080),
                      ),
                      SizedBox(height: 30,),
                      AppText(
                        title: "Wining Prize Details :",
                        size: 16,
                        fontWeight: FontWeight.w700,
                        color:Color(0xffF33F41),
                      ),
                      Container(height: 2,
                        width: 50,
                        decoration: BoxDecoration(
                            color:Color(0xffF33F41),
                            borderRadius: BorderRadius.circular(2)
                        ),
                      ),
                      SizedBox(height: 24,),
                      AppText(
                        title: "Prize:  One Year Grocery Gift.",
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color:Color(0xff808080),
                      ),
                      SizedBox(height: 16,),
                      AppText(
                        title: "Contact Us : ${widget.phone.toString()}",
                        size: 14,
                        fontWeight: FontWeight.w500,
                        color:Color(0xff808080),
                      ),
                      SizedBox(height: 16,),
                      Obx(
                              () {
                            return AppText(
                              title: "Email at : ${homeController.email.value}",
                              size:
                              homeController.email.value.isEmpty?15:
                              14,
                              fontWeight: FontWeight.w500,
                              color:Color(0xff808080),
                            );
                          }
                      ),
                      SizedBox(height: 90,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 25),
        child: Row(
          children: [
            Expanded(
              child: AppButton(
                buttonName: "Save to gallery",
                buttonColor: AppColor.primaryColor,
                textColor: AppColor.whiteColor,
                onTap: () => _saveToGallery(context),
                buttonRadius: BorderRadius.circular(100),
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: AppButton(
                buttonName: "Print File",
                buttonColor: AppColor.whiteColor,
                textColor: AppColor.blackColor,
                onTap: () => _printFile(context),
                buttonRadius: BorderRadius.circular(100),
                gard: false,
                borderColor: Color(0xffC4C4C4),
                buttonWidth: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveToGallery(BuildContext context) async {
    // Capture the screenshot
    final imageBytes = await _screenshotController.capture();

    // Save the image to the gallery
    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(imageBytes!));

    // Check if the image was successfully saved
    if (result['isSuccess']) {
      // Show success snackbar message
      flutterToast(msg: "Image saved to gallery");
    } else {

    }
  }
  void _printFile(BuildContext context) async {
    // Capture the screenshot
    final imageBytes = await _screenshotController.capture();

    // Save the image to the gallery
    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(imageBytes!));

    // Check if the image was successfully saved
    if (result['isSuccess']) {
      // Show success snackbar message
      flutterToast(msg: "Saved to gallery for printing");
    } else {

    }
  }

}
