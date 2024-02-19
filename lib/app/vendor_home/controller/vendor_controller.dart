
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/my_ads_model.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/payment_model.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/profile/model/accoount_model.dart';
import 'package:mr_bet/app/vendor_home/vendor_tabs/profile/model/business_profile_model.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/widgets/helper_function.dart';



class VendorController extends GetxController {
  var referCode="".obs;
  updateReferCode(val){
    referCode.value=val;
    update();
  }
  var accountLoading = false.obs;

  var accountList = <AllDataAccount>[].obs;
  getAccountData() async {
    try {

      accountLoading(true);
      update();

      var profData = await ApiManger.getAccountVendor();
      if (profData != null) {
        accountList.value =
        profData.response?.data as dynamic;

      } else {
        accountLoading(false);
        update();
      }
    } catch (e) {

      accountLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      accountLoading(false);
      update();
    }
    update();
  }
  var adLoader = false.obs;
  var adBankLoader = false.obs;
  var timeLoader = false.obs;
  updateAdLoader(val){
    adLoader.value=val;
    update();
  }
  updateBankLoader(val){
    adBankLoader.value=val;
    update();
  }
  updateTimeLoader(val){
    timeLoader.value=val;
    update();
  }
  var getAdsList = <MyAllModelData>[].obs;
  var userAdsLoader = false.obs;

  getAdsData() async {
    try {
      userAdsLoader(true);
      update();


      var profData = await ApiManger.getAllBusinessAdsModel();
      if (profData != null) {
        getAdsList.value = profData.response?.data as dynamic;
        print(
            "This is my comments ${ profData.response?.data}");
      } else {
        userAdsLoader(false);
        update();
      }
    } catch (e) {

      userAdsLoader(false);
      update();
      debugPrint(e.toString());
    } finally {
      userAdsLoader(false);
      update();
    }
    update();
  }



  var token = "".obs;
  var email = "".obs;
  var phone = "".obs;
  var type = "".obs;
  var name = "".obs;
  File ?file;

  @override
  Future<void> onInit() async {



    HelperFunctions.getFromPreference("name").then((value) {
      name.value = value;
      print(name.value.toString());

      update();
    });

    HelperFunctions.getFromPreference("email").then((value) {
      email.value = value;

      update();
    });

    HelperFunctions.getFromPreference("type").then((value) {
      type.value = value;

      update();
    });
    HelperFunctions.getFromPreference("phone").then((value) {
      phone.value = value;

      update();
    });
    HelperFunctions.getFromPreference("token").then((value) {
      token.value = value;
      getBusinessProfileData();
      getAccountData();
      getPayHisData();
      getAdsData();

      print(token.toString());


      print(token.value.toString());
      update();
    });



    super.onInit();

  }

  var loader = false.obs;
  var loaderProfile = false.obs;
  updateLoader(val){
    loader.value
        =val;
    update();
  }
  updateProfileLoader(val){
    loaderProfile.value
    =val;
    update();
  }
  BusinessProfileResponse? profileAllData;
  getBusinessProfileData() async {
    try {
      updateProfileLoader(true);

      update();

      var profData = await ApiManger.getBusinessProfileModel();
      if (profData != null) {
        profileAllData = profData.response ;
        updateReferCode(profData.response?.data?.refer.toString());

        print(
            "This is my profile ${profData.response?.data}");
        updateProfileLoader(false);

        update();
      } else {

        updateProfileLoader(false);

        update();
      }
    } catch (e) {


      updateProfileLoader(false);

      update();

    } finally {

      updateProfileLoader(false);

      update();
    }
    updateProfileLoader(false);

    update();
  }

  var getProofList = <PaymentProofAllData>[].obs;
  var allPaymentLoader = false.obs;

  getPayHisData() async {
    try {
      allPaymentLoader(true);
      update();


      var profData = await ApiManger.getPaymentProfModelBus();
      if (profData != null) {
        getProofList.value = profData.response?.data as dynamic;
        print(
            "This is my payment ${ profData.response?.data}");
      } else {
        allPaymentLoader(false);
        update();
        update();
      }
    } catch (e) {

      allPaymentLoader(false);
      update();
      update();
      debugPrint(e.toString());
    } finally {
      allPaymentLoader(false);
      update();
      update();
    }
    update();
  }


}

