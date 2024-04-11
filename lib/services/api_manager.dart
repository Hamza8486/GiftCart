import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/component/verification.dart';
import 'package:giftcart/util/translation_keys.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:giftcart/app/auth/controller.dart';
import 'package:giftcart/app/auth/forget/view/otp.dart';
import 'package:giftcart/app/auth/login.dart';
import 'package:giftcart/app/auth/model/store_model.dart';
import 'package:giftcart/app/auth/partner_signup/business_info.dart';
import 'package:giftcart/app/auth/province_model.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/model/account.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/model/all_user_slots.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/model/comment_model.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/model/like_model.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/model/my_ads_model.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/model/my_slots.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/model/payment_model.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/model/province_user_model.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/model/slot_history_model.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/model/stat_model.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/model/testmonials.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/model/transaction_model.dart';
import 'package:giftcart/app/bottom_tabs/dashboard/model/winners_model.dart';
import 'package:giftcart/app/bottom_tabs/profile/model/notification_model.dart';
import 'package:giftcart/app/bottom_tabs/profile/model/profile_model.dart';
import 'package:giftcart/app/bottom_tabs/profile/model/support_model.dart';
import 'package:giftcart/app/bottom_tabs/profile/model/user_store.dart';
import 'package:giftcart/app/bottom_tabs/profile/model/winner_chat_model.dart';
import 'package:giftcart/app/bottom_tabs/wallet/controller/wallet_controller.dart';
import 'package:giftcart/app/bottom_tabs/wallet/model/wallet_model.dart';
import 'package:giftcart/app/coupon_app_rewards/model/rewards_model.dart';
import 'package:giftcart/app/coupon_app_rewards/view/coupon_app_rewards.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';
import 'package:giftcart/app/home/home_view.dart';
import 'package:giftcart/app/vendor_home/controller/vendor_controller.dart';
import 'package:giftcart/app/vendor_home/vendor_home.dart';
import 'package:giftcart/app/vendor_home/vendor_tabs/profile/model/accoount_model.dart';
import 'package:giftcart/app/vendor_home/vendor_tabs/profile/model/business_profile_model.dart';
import 'package:giftcart/util/constant.dart';
import 'package:giftcart/util/toast.dart';
import 'package:giftcart/widgets/helper_function.dart';


class ApiManger extends GetConnect {






  static Future<GetProvinceModel?> getProvince() async {
    print("reuqets_url_________________________________");
    print(AppConstants.baseURL+AppConstants.getProvince);
    var response = await http.get(
        Uri.parse(AppConstants.baseURL+AppConstants.getProvince),


      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
    );
    print(response.request?.url);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetProvinceModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<NewStoreModel?> getStoreAllModel() async {
    var response = await http.get(
      Uri.parse(AppConstants.baseURL+AppConstants.getAllStore),


      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
    );
    print(response.request?.url);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return NewStoreModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }









  static Future<UserStoreModel?> getUserStore() async {
    var response = await http.get(
      Uri.parse(AppConstants.baseURL+AppConstants.userStore),

      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',

      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return UserStoreModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }




  static Future<FaqModel?> getFaq() async {
    var response = await http.get(
      Uri.parse(AppConstants.baseURL+AppConstants.faq),

      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return FaqModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }
  static Future<FaqModel?> getFaq1() async {
    var response = await http.get(
      Uri.parse(AppConstants.baseURL+AppConstants.faq),

      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(VendorController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return FaqModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  registerResponse({required BuildContext context}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'full_name': Get.put(AuthController()).fullNameController.text,
        'email': Get.put(AuthController()).emailRegController.text,
        'password': Get.put(AuthController()).passRegController.text,
        'occupation': Get.put(AuthController()).occuController.text,
         'code': Get.put(AuthController()).referralController.text,
        'role':"Individual",
        'phone_number': Get.put(AuthController()).mobileController.text,
        'province': Get.put(AuthController()).provinceId.toString(),
        'device_token': "device1234885",
      });
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.register,
        data: data,
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",


          })
      );
      debugPrint(response.realUri.toString());
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 ||response.statusCode == 201) {

         Get.put(AuthController()).updateLoader(false);
        Get.put(AuthController()).clear();
        flutterToastSuccess(msg: "Account Register Successfully, Please Login");
         Get.to(
             LoginView(email:Get.put(AuthController()).emailRegController.text ,
             pass: Get.put(AuthController()).passRegController.text,
               login: "true",
             ));
        print(response.data);

      }

    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoader(false);
      print(e.response?.data.toString());
      flutterToast(msg: e.response?.data["response"]["message"].toString());
    }
  }


  editStoreResponse({context,name,phone,province,}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'full_name': name.toString(),
          'phone_number': phone.toString(),
          'province': province.toString(),
          Get.put(VendorController()).file==null?"":
          'logo':
          Get.put(VendorController()).file == null
              ? "":
          await dio.MultipartFile.fromFile(

              Get.put(VendorController()).file!.path),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().patch(
            AppConstants.baseURL + AppConstants.storeEditProfile,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Token ${Get.put(VendorController()).token.value}"


            })
        );
        if (response.statusCode == 200 ||response.statusCode == 201) {


          flutterToastSuccess(msg: "Profile Update Successfully");

          Get.put(VendorController()).getBusinessProfileData();
          Get.put(VendorController()).updateLoader(false);
          Get.back();
          Get.put(VendorController()).file=null;

        }
        else if(response.statusCode==202){
          flutterToast(msg: response.data.toString());
          Get.put(VendorController()).updateLoader(false);

        }
      } on dio.DioError catch (e) {
        Get.put(VendorController()).updateLoader(false);

        flutterToast(msg: e.response?.data.toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      Get.put(VendorController()).updateLoader(false);
      flutterToast(msg: e.response?.data.toString());
      log(e.toString());
    }
  }

  registerBusinessResponse({required BuildContext context}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'full_name': Get.put(AuthController()).fullNameController.text,
        'email': Get.put(AuthController()).emailRegController.text,
        'role':"Business",
        'password': Get.put(AuthController()).passRegController.text,
        'occupation': "",
        'code': "",
        'phone_number': Get.put(AuthController()).mobileController.text,
        'province': Get.put(AuthController()).provinceId.toString(),
        'device_token': "device1234885",
      });
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.register,
          data: data,
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",


          })
      );
      debugPrint(response.realUri.toString());
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 ||response.statusCode == 201) {
        //refferalResponse(context: context,token: )
        Get.put(AuthController()).updateLoader(false);
        // Get.put(AuthController()).clear();
        Get.to(OtpScreen(

        ));
        flutterToastSuccess(msg: "Please verify email address");


      }

    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoader(false);
      print(e.response?.data.toString());
      flutterToast(msg: e.response?.data["response"]["message"].toString());
    }
  }


  verifyEmail({required BuildContext context,code}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'code': code.toString(),
        'email': Get.put(AuthController()).emailRegController.text,

      });
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.verifyEmail,
          data: data,
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",


          })
      );
      debugPrint(response.realUri.toString());
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 ||response.statusCode == 201) {
        Get.put(AuthController()).clearBusiness();
        Get.put(AuthController()).updateVerifyLoader(false);
        Get.off(BusinessInformation());

        flutterToastSuccess(msg: "Please complete your profile");


      }

    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateVerifyLoader(false);
      print(e.response?.data.toString());
      flutterToast(msg: e.response?.data["response"]["message"].toString());
    }
  }



  sendMessage({required BuildContext context,text,text1}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'title':text1.toString(),
        'message':text.toString(),
        'email':Get.put(HomeController()).email.value,
        'phone':Get.put(HomeController()).phone.value,

      });
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.contac,
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"


          })
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        //refferalResponse(context: context,token: )
        Get.put(HomeController()).updateAddSlot(false);
        Get.put(AuthController()).clear();
        flutterToastSuccess(msg: "Request Submitted Successfully");
        print(response.data);

      }
      else if(response.statusCode==202){
        Get.put(HomeController()).updateAddSlot(false);
        flutterToast(msg: response.data["error"].toString());
      }
    } on dio.DioError catch (e) {
      Get.put(HomeController()).updateAddSlot(false);
      print(e.response?.data.toString());
      flutterToast(msg: e.response?.data["error"].toString());
    }
  }


  businessRegister({context}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'full_name': Get.put(AuthController()).fullNameController.text,
          'email': Get.put(AuthController()).emailRegController.text,
          'store_name': Get.put(AuthController()).storeNameController.text,
          'store_address': Get.put(AuthController()).addressController.text,
          'mobile': Get.put(AuthController()).mobileController.text,
          'lat': Get.put(AuthController()).lat.value,
          'lng': Get.put(AuthController()).lng.value,
          'store_license_id': "11222333",
          'store_city': Get.put(AuthController()).provinceId.toString(),
          'password': Get.put(AuthController()).passRegController.text,
          Get.put(AuthController()).file==null?"":
          'store_pic':
          Get.put(AuthController()).file == null
              ? "":
          await dio.MultipartFile.fromFile(

              Get.put(AuthController()).file!.path),
          Get.put(AuthController()).file1==null?"":
          'store_license_picture':
          Get.put(AuthController()).file1 == null
              ? "":
          await dio.MultipartFile.fromFile(

              Get.put(AuthController()).file1!.path),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.storeRegister,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",


            })
        );
        print(AppConstants.baseURL + AppConstants.storeRegister);
        if (response.statusCode == 200) {


          Get.put(AuthController()).updateLoader(false);
          Get.put(AuthController()).clear();
          flutterToastSuccess1(msg: "Account Register Successfully");
         Get.offAll(LoginView());
          print(response.data);

        }
        else if(response.statusCode==202){
          Get.put(AuthController()).updateLoader(false);
          flutterToast(msg: response.data["error"].toString());

        }
      } on dio.DioError catch (e) {
        Get.put(AuthController()).updateLoader(false);
        flutterToast(msg: e.response?.data["error"].toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoader(false);
      flutterToast(msg: e.response?.data["error"].toString());
    }
  }



  addStore({context}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'full_name': Get.put(VendorController()).name.value,
          'store_name': Get.put(AuthController()).storeNameController.text,
          'store_address': Get.put(AuthController()).addressController.text,
          'mobile': Get.put(AuthController()).mobileController.text,
          'lat': Get.put(AuthController()).lat.value,
          'lng': Get.put(AuthController()).lng.value,
          'store_license_id': "11222333",
          'store_city': Get.put(AuthController()).provinceId.toString(),
          Get.put(AuthController()).file==null?"":
          'store_pic':
          Get.put(AuthController()).file == null
              ? "":
          await dio.MultipartFile.fromFile(

              Get.put(AuthController()).file!.path),
          Get.put(AuthController()).file1==null?"":
          'store_license_picture':
          Get.put(AuthController()).file1 == null
              ? "":
          await dio.MultipartFile.fromFile(

              Get.put(AuthController()).file1!.path),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.addStore,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",

              HttpHeaders.authorizationHeader: "Bearer ${Get.put(VendorController()).token.value}"


            })
        );
        if (response.statusCode == 200) {


          Get.put(AuthController()).updateLoader(false);
          Get.put(AuthController()).clear();
          flutterToastSuccess1(msg: "Store Created Successfully");
          Get.back();
          print(response.data);

        }
        else if(response.statusCode==202){
          Get.put(AuthController()).updateLoader(false);
          flutterToast(msg: response.data["error"].toString());

        }
      } on dio.DioError catch (e) {
        Get.put(AuthController()).updateLoader(false);
        flutterToast(msg: e.response?.data["error"].toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoader(false);
      flutterToast(msg: e.response?.data["error"].toString());
    }
  }


  userStore({context}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'full_name': Get.put(HomeController()).name.value,
          'store_name': Get.put(AuthController()).storeNameController.text,
          'store_address': Get.put(AuthController()).addressController.text,
          'mobile': Get.put(AuthController()).mobileController.text,
          'lat': Get.put(AuthController()).lat.value,
          'lng': Get.put(AuthController()).lng.value,
          'store_license_id': "11222333",
          'store_city': Get.put(AuthController()).provinceId.toString(),
          Get.put(AuthController()).file==null?"":
          'store_pic':
          Get.put(AuthController()).file == null
              ? "":
          await dio.MultipartFile.fromFile(

              Get.put(AuthController()).file!.path),
          Get.put(AuthController()).file1==null?"":
          'store_license_picture':
          Get.put(AuthController()).file1 == null
              ? "":
          await dio.MultipartFile.fromFile(

              Get.put(AuthController()).file1!.path),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.add_User_Store,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",

              HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"


            })
        );
        if (response.statusCode == 200) {

          Get.put(HomeController()).getStoreData();
          Get.put(AuthController()).updateLoader(false);
          Get.put(AuthController()).clear();
          flutterToastSuccess1(msg: "Store Created Successfully");
          Get.back();
          print(response.data);

        }
        else if(response.statusCode==202){
          Get.put(AuthController()).updateLoader(false);
          flutterToast(msg: response.data["error"].toString());

        }
      } on dio.DioError catch (e) {
        Get.put(AuthController()).updateLoader(false);
        flutterToast(msg: e.response?.data["error"].toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoader(false);
      flutterToast(msg: e.response?.data["error"].toString());
    }
  }







  loginResponse({required BuildContext context,email,password,token}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'email': email.toString(),
        'password':password.toString(),

        'device_id': token.toString(),
      });
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.login,
          data: data,
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",


          })
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        print(response.data);
        if(response.data["response"]["data"]["role"]=="Business"){
          HelperFunctions.saveInPreference(
              "token", response.data["response"]['access_token'].toString());

          HelperFunctions.saveInPreference(
              "name", response.data["response"]['data']['full_name'].toString());

          HelperFunctions.saveInPreference(
              "email", response.data["response"]['data']['email'].toString());


          HelperFunctions.saveInPreference(
              "phone", response.data["response"]['data']['phone_number'].toString());
          HelperFunctions.saveInPreference(
              "type", "business");

          Get.offAll(VendorHome());

        }
        else{
          HelperFunctions.saveInPreference(
              "token", response.data["response"]['access_token'].toString());

          HelperFunctions.saveInPreference(
              "name", response.data["response"]['data']['full_name'].toString());

          HelperFunctions.saveInPreference(
              "email", response.data["response"]['data']['email'].toString());


          HelperFunctions.saveInPreference(
              "phone", response.data["response"]['data']['phone_number'].toString());
          HelperFunctions.saveInPreference(
              "type", "user");

          HelperFunctions.saveInPreference(
              "image",
              response.data["response"]['data']["logo"]==null?""
                  :            response.data["response"]['data']["logo"].toString());
          Get.offAll(Home());

        }







        Get.put(AuthController()).updateLoginLoader(false);
      }

    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoginLoader(false);
      print(e.response?.data.toString());
      if(e.response?.data["response"]["message"].toString()=="Profile not complete!"){
        flutterToast(msg: e.response?.data["response"]["message"].toString());
        email = Get.put(AuthController()).emailRegController.text;
        Get.put(AuthController()).clearBusiness();
        Get.to(BusinessInformation());

      }
      else{
        flutterToast(msg: e.response?.data["response"]["message"].toString());


      }

    }
  }



  socialLoginResponse({required BuildContext context,email,name,token}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'email': email.toString(),
        'full_name':name.toString(),

        'device_id': token.toString(),
      });
      print("Data::::: ${data.fields}");
      var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.social_login,
          data: data,
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",


          })
      );
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        print(response.data);
        if(response.data["response"]["data"]["role"]=="Business"){
          HelperFunctions.saveInPreference(
              "token", response.data["response"]['access_token'].toString());

          HelperFunctions.saveInPreference(
              "name", response.data["response"]['data']['full_name'].toString());

          HelperFunctions.saveInPreference(
              "email", response.data["response"]['data']['email'].toString());


          HelperFunctions.saveInPreference(
              "phone",
              response.data["response"]['data']['phone_number']==null?"":
              response.data["response"]['data']['phone_number'].toString());
          HelperFunctions.saveInPreference(
              "type", "business");

          Get.offAll(VendorHome());

        }
        else{
          HelperFunctions.saveInPreference(
              "token", response.data["response"]['access_token'].toString());

          HelperFunctions.saveInPreference(
              "name", response.data["response"]['data']['full_name'].toString());

          HelperFunctions.saveInPreference(
              "email", response.data["response"]['data']['email'].toString());


          HelperFunctions.saveInPreference(
              "phone",
              response.data["response"]['data']['phone_number']==null?"":
              response.data["response"]['data']['phone_number'].toString());
          HelperFunctions.saveInPreference(
              "type", "user");

          HelperFunctions.saveInPreference(
              "image",
              response.data["response"]['data']["logo"]==null?""
                  :            response.data["response"]['data']["logo"].toString());
          Get.offAll(Home());

        }
        flutterToast(msg: "Successful Login");






        Get.put(AuthController()).updateSocialLogin(false);
      }

    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateSocialLogin(false);
      print(e.response?.data.toString());
      if(e.response?.data["response"]["message"].toString()=="Profile not complete!"){
        flutterToast(msg: e.response?.data["response"]["message"].toString());
        email = Get.put(AuthController()).emailRegController.text;
        Get.put(AuthController()).clearBusiness();
        Get.to(BusinessInformation());

      }
      else{
        flutterToast(msg: e.response?.data["response"]["message"].toString());


      }

    }
  }

  editUserResponse({context,name,phone,province,}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'full_name': name.toString(),
          'occupation': phone.toString(),
          'province': province.toString(),
          Get.put(HomeController()).file==null?"":
          'logo':
          Get.put(HomeController()).file == null
              ? "":
          await dio.MultipartFile.fromFile(

              Get.put(HomeController()).file!.path),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().patch(
            AppConstants.baseURL + AppConstants.editProfile,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"


            })
        );
        if (response.statusCode == 200 ||response.statusCode == 201) {


          flutterToastSuccess(msg: "Profile Update Successfully");
          HelperFunctions.saveInPreference(
              "name", response.data["response"]['data']['full_name'].toString());
          Get.put(HomeController()).updateFirstName(
              response.data["response"]['data']['full_name'].toString());

          Get.put(HomeController()).getProfileData();
          Get.put(HomeController()).updateLoader(false);
          Get.back();
          Get.put(HomeController()).file=null;

        }
        else if(response.statusCode==202){
          flutterToast(msg: response.data.toString());
          Get.put(HomeController()).updateLoader(false);

        }
      } on dio.DioError catch (e) {
        Get.put(HomeController()).updateLoader(false);

        flutterToast(msg: e.response?.data.toString());
        // log("e.response");


      }
    } on dio.DioError catch (e) {
      Get.put(HomeController()).updateLoader(false);
      flutterToast(msg: e.response?.data.toString());
      log(e.toString());
    }
  }







  AddSLots(
      {
        required List prodQuantity,
        required BuildContext context}) async {

      try {
        dio.FormData data = dio.FormData.fromMap({
          'slot_data':  jsonEncode(prodQuantity),

        });

        print(jsonEncode(prodQuantity));
        print("Data::::: ${data.fields}");




        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.addSLOT,
            data: data,

            options: dio.Options(

                headers: {
                  HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"

                }));
        print(response.toString());
        if (response.statusCode == 200 || response.statusCode == 201) {

          Get.put(HomeController()).getProvDataData();

          Get.put(HomeController()).getSlotData(id: "");
          Get.put(HomeController()).getTransData();
          flutterToastSuccess(msg: "Slots Add Successfully");
          Get.put(HomeController()).updateAddSlot(false);
          Get.put(HomeController()).slotAddList.clear();
          print(response.data.toString());

        }

      } on dio.DioError catch (e) {

        print(e.response?.data.toString());
        flutterToast(msg: e.response?.data["response"]["message"].toString());
        Get.put(HomeController()).updateAddSlot(false);
      }
    }






  logoutApi() async {

    try {






      var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.logout,


          options: dio.Options(

              headers: {
                HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"

              }));
      print(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {


        print(response.data);

      }

    } on dio.DioError catch (e) {

      print(e.response?.data);
    }
  }

  logoutApi1() async {

    try {






      var response = await dio.Dio().post(
          AppConstants.baseURL + AppConstants.logout,


          options: dio.Options(

              headers: {
                HttpHeaders.authorizationHeader: "Token ${Get.put(VendorController()).token.value}"

              }));
      print(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {


        print(response.data);

      }

    } on dio.DioError catch (e) {

      print(e.response?.data);
    }
  }

  slotVView(
      {
      String id = ""

      }) async {

    try {
      var response = await dio.Dio().post(
          "${AppConstants.baseURL + AppConstants.scratchCoupon}${id.toString()}/",

          options: dio.Options(

              headers: {
                HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"

              }));
      print(response.realUri.path.toString());
      print(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {



        Get.put(HomeController()).getSlotData(id: "",isLoadings: false);
        Get.put(HomeController()).getStatHis(id: "",day: "");


      }

    } on dio.DioError catch (e) {

    }
  }


  static Future<getMySlots?> getMySlotsAll({id=""}) async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.getSlot}?province=${id.toString()}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return getMySlots.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }


  static Future<AllUserSlotsModel?> allUserModel() async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.all_users}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return AllUserSlotsModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  static Future<GetCommentModel?> getCommentAll({id=""}) async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.get_comment}${id.toString()}/"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );
    print(response.request?.url);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetCommentModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<PaymentProofModel?> getPaymentProfModel() async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.payHistory}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );
    print(response.request?.url);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return PaymentProofModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<PaymentProofModel?> getPaymentProfModelBus() async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.payHistory}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(VendorController()).token.value}"
      },
    );
    print(response.request?.url);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return PaymentProofModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }






  static Future<MyAdsModel?> getAllAdsModel() async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.my_ads}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );
    print(response.request?.url);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return MyAdsModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<MyAdsModel?> getAllBusinessAdsModel() async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.my_ads}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(VendorController()).token.value}"
      },
    );
    print(response.request?.url);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return MyAdsModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }




  static Future<MyAdsModel?> getAllUserAds() async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.my_ads_all}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
    );
    print(response.request?.url);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return MyAdsModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  static Future<GeLikeModel?> getLikeModel({id=""}) async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.get_like}${id.toString()}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );
    print(response.request?.url);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GeLikeModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }


  static Future<WinnersChatModel?> getMessageALL({id=""}) async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.getMessage}${id.toString()}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );
    print(response.request?.url);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return WinnersChatModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<SlotHistoryModel?> getSlotHistory({id=""}) async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.getHistory}?province=${id.toString()}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );
    print(response.request?.url);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return SlotHistoryModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }


  static Future<GetStatsModel?> getStatHistory({String id="",String day=""}) async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.getStats}?filter_by=$day&province=$id"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );
    print(response.request?.url);

    if (response.statusCode == 200 ||response.statusCode == 201) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetStatsModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<GetNotificationModel?> getNotification() async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.getNotification}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );
    print(response.request?.url);

    if (response.statusCode == 200 ||response.statusCode == 201) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetNotificationModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  forgetResponse({context, email}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'email': email,
      });
      var response = await dio.Dio().post(
        AppConstants.baseURL + AppConstants.forget,
        data: data,
      );
      if (response.statusCode == 200||response.statusCode == 201) {
        print(response.data.toString());
        Get.back();
        Get.put(AuthController()).updateForgetLoader(false);


        flutterToast(msg: "Password has been reset and sent to your email!");
      }

    } on dio.DioError catch (e) {
      print(e.response?.data.toString());
      Get.put(AuthController()).updateForgetLoader(false);
      flutterToast(msg: e.response?.data["response"]["message"].toString());
      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }












  static Future<GetProfileModel?> getProfileModel() async {
    var response = await http.get(
      Uri.parse(AppConstants.baseURL+AppConstants.getProfile),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader:
        "Token ${Get.put(HomeController()).token.value}"
      },
    );
    print(response.request?.url.toString());

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetProfileModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<BusinessProfileModel?> getBusinessProfileModel() async {
    var response = await http.get(
      Uri.parse(AppConstants.baseURL+AppConstants.getBusinessProfile),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader:
        "Token ${Get.put(VendorController()).token.value}"
      },
    );
    print(response.request?.url.toString());

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return BusinessProfileModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }
  claimReward({name,phone,email,id,addrss,XFile?file,String bc=""}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'first_name': name.toString(),
          'last_name': ".",
          'phone_number': phone.toString(),
          'address': addrss.toString(),
          'email': email,
           'video':
          file == null
              ? ""
              : await dio.MultipartFile.fromFile(
              file.path),
          'image':
          Get.put(HomeController()).claimProfile == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(HomeController()).claimProfile!.path),

        });

        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");

        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.claimReward,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"


            })

        );
        print(response.realUri.toString());
        if (response.statusCode == 200 || response.statusCode == 201) {

          Get.put(HomeController()).updateIsClaim(false);
          print(response.data);
          print(response.data);
          print(response.data);
         // Get.put(HomeController()).getAllTest(id: "");
          Get.put(HomeController()).getProfileData();


          Get.put(HomeController()).videoFile=null;
          Get.put(HomeController()).claimProfile=null;
          Get.off(VerificationView(phone: phone.toString(),id: id.toString(),address:address.toString(),));

          flutterToastSuccess(msg: "Claim request submitted! Please wait admin approval");

        }

      } on dio.DioError catch (e) {
        Get.put(HomeController()).updateIsClaim(false);
        print( e.response.toString());
       // flutterToast(msg: e.response?.data["response"].toString());
      }
    } on dio.DioError catch (e) {
      print( e.response.toString());
      Get.put(HomeController()).updateIsClaim(false);
     // flutterToast(msg: e.response?.data["response"].toString());
    }
  }


  claimScratch({ context, id}) async {
    try {
      var response = await dio.Dio().get(
        "${AppConstants.baseURL}${AppConstants.scratch}?slot_id=${id.toString()}",
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"


          })

      );
      print(response.toString());
      if (response.statusCode == 200) {
        Get.put(HomeController()).getSlotData(id: "");
        print(response.data.toString());

      }
      else if(response.statusCode==202){
        print(response.data.toString());

        Get.put(AuthController()).updateVerifyLoader(false);
      }
    } on dio.DioError catch (e) {

      print(e.response?.data.toString());
    }
  }
  static Future<TestMonialsModel?> getTest({id=""}) async {
    var response = await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.testmonials}?province=${id.toString()}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return TestMonialsModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }




  static Future<GetWinnersModel?> getWinners() async {
    var response = await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.getWinners}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetWinnersModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }






  addBankAccountResp({context,name,iban,title,}) async {

      try {
        dio.FormData data = dio.FormData.fromMap({
          'name': name.toString(),
          'iban': iban.toString(),
          'account_number': title.toString(),
        });
        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.addAccount,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"


            })
        );
        if (response.statusCode == 200) {


          flutterToastSuccess(msg: "Add Successfully");
          Get.put(HomeController()).getAccountData();
          Get.back();

        }
        else if(response.statusCode==202){
          flutterToast(msg: response.data.toString());
          Get.put(HomeController()).updateLoader(false);

        }

    } on dio.DioError catch (e) {
      Get.put(HomeController()).updateLoader(false);
      flutterToast(msg: e.response?.data.toString());
      log(e.toString());
    }
  }



  refferalResponse({ context,token}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'refer_code': Get.put(AuthController()).referralController.text,
      });
      var response = await dio.Dio().post(
          "${AppConstants.baseURL}${AppConstants.referrlCode}",
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${token.toString()}"


          })

      );
      print(response.toString());
      if (response.statusCode == 200) {
        Get.put(AuthController()).referralController.clear();

      }
      else if(response.statusCode==202){

      }
    } on dio.DioError catch (e) {

      print(e.response?.data.toString());
    }
  }


  addPaymentWalet({ amount,id}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'client_secret':id.toString(),
        'amount':amount.toString(),
      });
      print(data.fields);
      print(data.fields);
      var response = await dio.Dio().post(
          "${AppConstants.baseURL}${AppConstants.addPayment}",
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"


          })

      );
      print(data.fields);
      print(data.fields);
      print(response.toString());
      if (response.statusCode == 200) {
        Get.put(PaymentController()).updateCheckLoader(false);
        Get.put(PaymentController()).priceController.clear();
        Get.put(PaymentController()).updateCheckPayment("");
        Get.put(PaymentController()).updatePaymentId("");
        print(response.data.toString());
        flutterToastSuccess(msg: "Payment added successfully");
        Get.put(HomeController()).getTransData();

      }
    } on dio.DioError catch (e) {
      Get.put(PaymentController()).updateCheckLoader(false);
      print(e.response?.data.toString());
    }
  }



  addInvoice({ amount,required BuildContext context}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'coins':amount.toString(),
      });
      print(data.fields);
      print(data.fields);
      var response = await dio.Dio().post(
          "${AppConstants.baseURL}${AppConstants.add_invoice}",
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"


          })

      );
      print(data.fields);
      print(data.fields);
      print(response.toString());
      if (response.statusCode == 200) {
        Get.put(PaymentController()).updateRedeemLoader(false);
        Get.put(HomeController()).updateCoins("");

        print(response.data.toString());
        Get.back();
        flutterToastSuccess(msg: "Coins redeem successfully!");
        showModalBottomSheet(
            backgroundColor:
            Colors.transparent,
            isScrollControlled:
            true,
            isDismissible: true,
            context: context,
            builder: (context) =>
                RedeemSuccessfull(


                ));
        Get.put(HomeController()).getInvoiceData();

      }
    } on dio.DioError catch (e) {
      Get.put(PaymentController()).updateRedeemLoader(false);
      print(e.response?.data.toString());
    }
  }



  useReferrelCode({ code,required BuildContext context}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'code':code.toString(),
      });
      print(data.fields);
      print(data.fields);
      var response = await dio.Dio().post(
          "${AppConstants.baseURL}${AppConstants.user_refrell}",
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"


          })

      );
      print(data.fields);
      print(data.fields);
      print(response.toString());
      if (response.statusCode == 200) {
        Get.put(HomeController()).updateApplyRef(false);
        Get.put(HomeController()).getProfileData();


        print(response.data.toString());

        flutterToastSuccess(msg: "Referrel apply successfully!");


      }
    } on dio.DioError catch (e) {
      Get.put(HomeController()).updateApplyRef(false);
      flutterToastSuccess(msg: e.response?.data["response"]["message"]);
      print(e.response?.data.toString());
    }
  }




  addPaymentStore({ amount,id}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'slug':id.toString(),
        'amount':amount.toString(),
      });
      print(data.fields);
      print(data.fields);
      var response = await dio.Dio().post(
          "${AppConstants.baseURL}${AppConstants.paymentStore}",
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"


          })

      );
      print(data.fields);
      print(data.fields);
      print(response.toString());
      if (response.statusCode == 200 ||response.statusCode == 201) {
        Get.put(PaymentController()).updateStorePayment(false);
        flutterToastSuccess(msg: "Transaction added successfully");
        Get.put(HomeController()).getProfileData();
        Get.offAll(Home());

      }
    } on dio.DioError catch (e) {
      Get.put(PaymentController()).updateStorePayment(false);
      flutterToastSuccess(msg: e.response?.data["response"]["message"].toString());
      print(e.response?.data.toString());
    }
  }


  sendMessageWinner({ text,String id =""}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'text':text.toString(),

      });

      print(data.fields);
      print(data.fields);
      var response = await dio.Dio().post(
          "${AppConstants.baseURL}${AppConstants.sendMessage}$id/",
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"


          })

      );
      print(response.realUri.toString());

      print(response.toString());
      if (response.statusCode == 200 ||response.statusCode == 201) {
        print(response?.data.toString());
        Get.put(HomeController()).addMessageLoader(false);
        Get.put(HomeController()).getWinnerData();
        Get.put(HomeController()).messageCheckLoader(true);
        Get.put(HomeController()).getWinnerChar(
          id: id.toString()
        );

      }
    } on dio.DioError catch (e) {

      Get.put(HomeController()).addMessageLoader(false);
      print(e.response?.data.toString());
    }
  }



  static Future<GetWalletModel?> getWalletModel() async {
    var response = await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.getPayment}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetWalletModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }


  static Future<GetRewardsModel?> getRewardsModel() async {
    var response = await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.get_invoice}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );
    print(response.request?.url.toString());

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetRewardsModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  static Future<MyTransactionModel?> getTrans() async {
    var response = await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.myTrans}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return MyTransactionModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }


  static Future<AccountListModel?> getAccount() async {
    var response = await http.get(
      Uri.parse("https://mr-corp.ca/api/${AppConstants.getAccount}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return AccountListModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }


  static Future<VendorAccountModel?> getAccountVendor() async {
    var response = await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.getAccount}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(VendorController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return VendorAccountModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  static Future<VendorAccountModel?> getAccountVendor1() async {
    var response = await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.getAccount}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return VendorAccountModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }



  postCommentsModel({context, String id='',String text=''}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'text': text.toString(),

      });

      var response = await dio.Dio().post(
        "${AppConstants.baseURL + AppConstants.postComment}$id/",
        data: data,
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"

          })
      );
      print(response.realUri);
      print(response.realUri);
      if (response.statusCode == 200||response.statusCode == 201) {
        print(response.data.toString());
        Get.put(HomeController()).getCommentList.clear();
        Get.put(HomeController()).getComments(id: id.toString());
        Get.put(HomeController()).updateComment(false);
      }

    } on dio.DioError catch (e) {
      Get.put(HomeController()).updateComment(false);
      print(e.response?.data.toString());
      print(e.response);
    }
  }

  createAds({context, String title="",String offerType="",String offerTypeValue="",
    String description="", String address="",bool isWebsite=true,bool isWhatsapp=false,
    String website="",    String whatsapp="",String addDay="",
    String budget="",  String startDate="",String endDate="",String date="",
    bool schedule=false,
    File ?file

  }) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'title': title.toString(),
          'offer_type':offerType,
          'offer_type_value': offerTypeValue,
          'description': description,
          'address': address,
          'end_time': endDate,
          'is_website': isWebsite,
          'is_whatsapp': isWhatsapp,
          'website': website,
          'whatsapp': whatsapp,
          'ad_day': addDay,
          'budget': budget,
          'is_scheduled': schedule,
          'start_time': startDate,
          'ad_date': date,
          'image':
          file == null
              ? ""
              : await dio.MultipartFile.fromFile(
              file.path),


        });

        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.createAd,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"


            })

        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          print( response?.data.toString());
          Get.back();
          Get.put(HomeController()).updateAdLoader(false);
          Get.put(HomeController()).getAdsData();
          Get.put(AuthController()).getAllAdsData();
          flutterToast(msg: "Ad created successful!");



        }

      } on dio.DioError catch (e) {
        Get.put(HomeController()).updateAdLoader(false);
        print( e.response.toString());
      }
    } on dio.DioError catch (e) {
      Get.put(HomeController()).updateAdLoader(false);
      print( e.response.toString() );
    }
  }




  createBusAds({context, String title="",String offerType="",String offerTypeValue="",
    String description="", String address="",bool isWebsite=true,bool isWhatsapp=false,
    String website="",    String whatsapp="",String addDay="",
    String budget="",  String startDate="",String endDate="",String date="",
    bool schedule=false,
    File ?file

  }) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'title': title.toString(),
          'offer_type':offerType,
          'offer_type_value': offerTypeValue,
          'description': description,
          'address': address,
          'end_time': endDate,
          'is_website': isWebsite,
          'is_whatsapp': isWhatsapp,
          'website': website,
          'whatsapp': whatsapp,
          'ad_day': addDay,
          'budget': budget,
          'is_scheduled': schedule,
          'start_time': startDate,
          'ad_date': date,
          'image':
          file == null
              ? ""
              : await dio.MultipartFile.fromFile(
              file.path),


        });

        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.createAd,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Token ${Get.put(VendorController()).token.value}"


            })

        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          print( response?.data.toString());
          Get.back();
          Get.put(VendorController()).updateAdLoader(false);
          Get.put(VendorController()).getAdsData();
          Get.put(AuthController()).getAllAdsData();
          flutterToast(msg: "Ad created successful!");



        }

      } on dio.DioError catch (e) {
        Get.put(VendorController()).updateAdLoader(false);
        print( e.response.toString());
      }
    } on dio.DioError catch (e) {
      Get.put(VendorController()).updateAdLoader(false);
      print( e.response.toString() );
    }
  }



  paymentProof({context, String title="",
    File ?file,
    File ?file1

  }) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'amount': title.toString(),

          'bill_copy':
          file == null
              ? ""
              : await dio.MultipartFile.fromFile(file.path),
          'payment_copy':
          file1 == null
              ? ""
              : await dio.MultipartFile.fromFile(
              file1.path

          )



        });

        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.paymentProof
            ,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"


            })

        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          print( response?.data.toString());
          Get.put(HomeController()).getProfileData();
          Get.back();
          Get.put(HomeController()).updatePaymentProof(false);
          Get.put(HomeController()).getPayHisData();
          Get.put(AuthController()).getAllAdsData();
          flutterToast(msg: "Payment proof submit successful!");



        }

      } on dio.DioError catch (e) {
        flutterToast(msg:e.response?.data["response"]["message"].toString());
        Get.put(HomeController()).updatePaymentProof(false);
        print( e.response?.data["response"]["message"].toString());
      }
    } on dio.DioError catch (e) {
      flutterToast(msg:e.response?.data["response"]["message"].toString());
      Get.put(HomeController()).updatePaymentProof(false);
      print( e.response.toString() );
    }
  }




  likeTestMonial({context, String id=''}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'testimanial': id.toString(),

      });

      var response = await dio.Dio().post(
          "${AppConstants.baseURL + AppConstants.like_video}",
          data: data,
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"

          })
      );
      print(response.realUri);
      print(response.realUri);
      if (response.statusCode == 200||response.statusCode == 201) {
        print(response.data.toString());
        Get.put(HomeController()).getLikeTestMonial(id: id.toString());
      }

    } on dio.DioError catch (e) {

      print(e.response?.data.toString());
      print(e.response);
    }
  }

  unLikeTestMonial({context, String id=''}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'testimanial': id.toString(),

      });

      var response = await dio.Dio().delete(
          "${AppConstants.baseURL + AppConstants.like_video}",
          data: data,
          options: dio.Options(headers: {HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"

          })
      );
      print(response.realUri);
      print(response.realUri);
      if (response.statusCode == 200||response.statusCode == 201) {
        print(response.data.toString());
        Get.put(HomeController()).getLikeTestMonial(id: id.toString());
      }

    } on dio.DioError catch (e) {

      print(e.response?.data.toString());
      print(e.response);
    }
  }

  storeCreate({context,

  }) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'name':  Get.put(AuthController()).storeName.text,
          'description':Get.put(AuthController()).storeDes.text,
          'contact': Get.put(AuthController()).storeNumber.text,
          'address': Get.put(AuthController()).storeAddress.text,
          'email':
          Get.put(AuthController()).verifyEmailCon.value.isEmpty?
          Get.put(AuthController()).emailRegController.text:Get.put(AuthController()).verifyEmailCon.value,
          'logo':
          Get.put(AuthController()).storeLogoFile == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(AuthController()).storeLogoFile!.path),
          'banner':
          Get.put(AuthController()).storeBannerFile == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(AuthController()).storeBannerFile!.path),
          'term':
          Get.put(AuthController()).fileService == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(AuthController()).fileService!.path),
          'policy':
          Get.put(AuthController()).returnPolicy == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(AuthController()).returnPolicy!.path),
          'resolution':
          Get.put(AuthController()).dispute == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(AuthController()).dispute!.path),
          'business_info':
          Get.put(AuthController()).businessReg == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(AuthController()).businessReg!.path),


        });

        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().post(
            AppConstants.baseURL + AppConstants.storeCreate,
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",


            })

        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          print( response?.data.toString());
          flutterToast(msg: "Account created successfully!");
          Get.offAll(LoginView());
          Get.put(AuthController()).clearBusiness();
          Get.put(AuthController()).updateLoader(false);


        }

      } on dio.DioError catch (e) {
        Get.put(AuthController()).updateLoader(false);
        print( e.response.toString());
      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoader(false);
      print( e.response.toString() );
    }



  }



  updateStore({context,


  }) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'name':  Get.put(AuthController()).storeName.text,
          'description':Get.put(AuthController()).storeDes.text,
          'contact': Get.put(AuthController()).storeNumber.text,
          'address': Get.put(AuthController()).storeAddress.text,
          'email':
          Get.put(AuthController()).verifyEmailCon.value.isEmpty?
          Get.put(AuthController()).emailRegController.text:Get.put(AuthController()).verifyEmailCon.value,
          'logo':
          Get.put(AuthController()).storeLogoFile == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(AuthController()).storeLogoFile!.path),
          'banner':
          Get.put(AuthController()).storeBannerFile == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(AuthController()).storeBannerFile!.path),



        });

        print("Data::::: ${data.fields}");
        print("Data::::: ${data.fields}");
        var response = await dio.Dio().patch(
           "${AppConstants.baseURL + AppConstants.editStore}${Get.put(VendorController()).profileAllData?.data?.store?.id.toString()}/",
            data: data,
            options: dio.Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Token ${Get.put(VendorController()).token.value}"


            })

        );
        print(response.realUri.toString());
        if (response.statusCode == 200 || response.statusCode == 201) {
          print( response?.data.toString());
          flutterToast(msg: "Store updated successfully!");
          Get.back();
          Get.put(VendorController()).getBusinessProfileData();
          Get.put(AuthController()).updateLoader(false);


        }

      } on dio.DioError catch (e) {
        Get.put(AuthController()).updateLoader(false);
        print( e.response.toString());
      }
    } on dio.DioError catch (e) {
      Get.put(AuthController()).updateLoader(false);
      print( e.response.toString() );
    }



  }



  updateTime({ start,end}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'open_time':start.toString(),
        'end_time':end.toString(),
      });
      print(data.fields);
      print(data.fields);
      var response = await dio.Dio().patch(
          "${AppConstants.baseURL}${AppConstants.updateStoreTime}",
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Token ${Get.put(VendorController()).token.value}"


          })

      );
      print(data.fields);
      print(data.fields);
      print(response.toString());
      if (response.statusCode == 200) {
        Get.put(VendorController()).getBusinessProfileData();
        Get.back();

        flutterToastSuccess(msg: "Time updated Successfully");
        Get.put(VendorController()).updateTimeLoader(false);

      }
    } on dio.DioError catch (e) {
      Get.put(VendorController()).updateTimeLoader(false);
      print(e.response?.data.toString());
    }
  }


  addBank({ card,iban,account}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'card_name':card.toString(),
        'ibn_no':iban.toString(),
        'account_no':account.toString(),
      });
      print(data.fields);
      print(data.fields);
      var response = await dio.Dio().post(
          "${AppConstants.baseURL}${AppConstants.addBank}",
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Token ${Get.put(VendorController()).token.value}"


          })

      );
      print(data.fields);
      print(data.fields);
      print(response.toString());
      if (response.statusCode == 200 ||response.statusCode == 201) {
        Get.put(VendorController()).getAccountData();
       Get.back();


        flutterToastSuccess(msg: "Account added successfully");
        Get.put(VendorController()).updateBankLoader(false);

      }
    } on dio.DioError catch (e) {
      Get.put(VendorController()).updateBankLoader(false);
      print(e.response?.data.toString());
    }
  }


  addBank1({ transit,userName,account,address,instNum}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'username':userName.toString(),
        'transit_number':transit.toString(),
        'institution_number':instNum.toString(),
        'address':address.toString(),
        'account_no':account.toString(),

      });
      print(data.fields);
      print(data.fields);
      var response = await dio.Dio().post(
          "${AppConstants.baseURL}${AppConstants.addBank}",
          data: data,
          options: dio.Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"


          })

      );
      print(data.fields);
      print(data.fields);
      print(response.toString());
      if (response.statusCode == 200 ||response.statusCode == 201) {
        Get.put(HomeController()).getAccountData();
        Get.back();


        flutterToastSuccess(msg: "Account added successfully");
        Get.put(HomeController()).updateLoader(false);

      }
    } on dio.DioError catch (e) {
      Get.put(HomeController()).updateLoader(false);
      print(e.response?.data.toString());
    }
  }

  static Future<GetProvinceUserModel?> getProvUserModel() async {

    var response =   await http.get(
      Uri.parse("${AppConstants.baseURL}${AppConstants.provinceUser}"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: "Token ${Get.put(HomeController()).token.value}"
      },
    );

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("response.body");
      print(response.body);
      return GetProvinceUserModel.fromJson(jsonString);
    } else {
      log(response.statusCode.toString());

      //show error message
      return null;
    }
  }

  }
