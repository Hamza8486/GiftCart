import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/app/auth/controller.dart';
import 'package:mr_bet/util/theme.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:mr_bet/util/translation_keys.dart';
import 'package:mr_bet/widgets/app_text.dart';
import 'package:mr_bet/widgets/helper_function.dart';


Widget bottomSheet({onCamera ,onGallery}) {
  return DraggableScrollableSheet(
    initialChildSize: 0.27,
    minChildSize: 0.27,
    maxChildSize: 0.27,
    builder: (_, controller) => Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Padding(
        padding:  EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                InkWell(
                    onTap: onGallery,
                    child: iconCreation(
                        Icons.insert_photo, AppColor.primaryColor, gallery.tr)),
                SizedBox(width: Get.width*0.2,),
                InkWell(
                    onTap: onCamera,
                    child: iconCreation(
                        Icons.camera_alt,AppColor.primaryColor , camera.tr)),
              ],
            ),
          ],
        ),
      ),
    ),
  );


}

Widget iconCreation(IconData icons, Color color, String text) {
  return Column(
    children: [
      CircleAvatar(
        radius: 24,
        backgroundColor: color,
        child: Icon(
          icons,
          // semanticLabel: "Help",
          size: 22,
          color: Colors.white,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      AppText(
          title: text,
          color: AppColor.primaryColor,
          fontWeight: FontWeight.w500,
          size: 15)
    ],
  );
}

class ImagePick extends StatefulWidget {
  ImagePick({
    Key? key,this.text
  }) : super(key: key);
  var text;
  @override
  State<ImagePick> createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  Function ? onChange;
  void pickImage()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc','png'],

    ).then((value) {
      if(value!= null )
      {
        Navigator.pop(context);
        Get.put(AuthController()).file1 = File(value.paths.first!
        );
        setState(() {

        });
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap:(){
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (builder) =>
                    bottomFileSheet(onCamera: () {
                      Navigator.pop(context);
                      HelperFunctions.pickImage(
                          ImageSource.camera)
                          .then((value) {
                        setState(() {
                          Get.put(AuthController()).file =
                          value!;
                        });
                      });
                    }, onGallery: pickImage

                    ));
          },
          child: Container(
              height: Get.height * 0.047,
              width: Get.width * 0.3,
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(7)),
              child:  Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: AppText(
                    title: widget.text,
                    color: AppColor.whiteColor,
                    size: AppSizes.size_11,
                    fontFamily: AppFont.medium,
                  ),
                ),
              )


          ),
        ),
        Get.put(AuthController()).file1 == null?Container():
        SizedBox(
          height: Get.height * 0.01,
        ),
        Get.put(AuthController()).file1 == null?Container():
        GestureDetector(
          onTap: (){
            Get.put(AuthController()).file1 = null;
          },
          child: AppText(
            title: Get.put(AuthController()).file1?.path.split('/file_picker/').last??"",
            color: AppColor.blackColor,
            size: AppSizes.size_12,
            fontFamily: AppFont.medium,
          ),
        ),
      ],
    );
  }
}

Widget bottomFileSheet({onCamera ,onGallery}) {
  return DraggableScrollableSheet(
    initialChildSize: 0.25,
    minChildSize: 0.25,
    maxChildSize: 0.25,
    builder: (_, controller) => Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Padding(
        padding:  EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                InkWell(
                    onTap: onGallery,
                    child: iconCreation(
                        Icons.insert_photo, AppColor.primaryColor, file.tr)),
                SizedBox(width: Get.width*0.2,),
                InkWell(
                    onTap: onCamera,
                    child: iconCreation(
                        Icons.camera_alt,AppColor.primaryColor , camera.tr)),
              ],
            ),
          ],
        ),
      ),
    ),
  );


}