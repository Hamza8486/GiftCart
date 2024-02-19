
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_bet/app/auth/model/store_model.dart';
import 'package:mr_bet/app/auth/province_model.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/my_ads_model.dart';
import 'package:mr_bet/services/api_manager.dart';

class AuthController extends GetxController {
  File ?file;
  File ?file1;

  var verifyEmailCon = "".obs;
  upddateEmailVerrify(val){
    verifyEmailCon.value=val;
    update();
  }


  var nameProvince = "".obs;
  updateNameProv(val){
    nameProvince.value=val;
    update();
  }
  var isVisible = true.obs;
  var isVisible1 = true.obs;
  var isVisible2 = true.obs;
  var provinceId;
  TextEditingController addressController = TextEditingController();
  var loader = false.obs;
  var lat="".obs;
  var lng="".obs;
  updateLat(val){
    lat.value=val;
    update();

  }
  updateLng(val){
    lng.value=val;
    update();

  }
  var loaderLogin = false.obs;
  var loaderForget = false.obs;
  var loaderResend = false.obs;
  var loaderVerify = false.obs;
  var loaderPassword = false.obs;
  List<String> provinceAllList = [];
  updateForgetLoader(val){
    loaderForget.value = val;
    update();}
  updateResendLoader(val){
    loaderResend.value = val;
    update();}
  updateVerifyLoader(val){
    loaderVerify.value = val;
    update();}
  updatePasswordLoader(val){
    loaderPassword.value = val;
    update();}






  updateLoader(val){
    loader.value = val;
    update();}
  updateLoginLoader(val){
    loaderLogin.value = val;
    update();


  }
  var countryName="".obs;
  updateVisibleStatus() {
    isVisible.toggle();
    update();
  }


  updateCoName(val){
    countryName.value = val;
    update();
  }

  updateVisible1Status() {
    isVisible1.toggle();
    update();
  }
  updateVisible2Status() {
    isVisible2.toggle();
    update();
  }





  TextEditingController emailController = TextEditingController();
  TextEditingController emailForgetController = TextEditingController();
  TextEditingController verifyCodeForgetController = TextEditingController();
  TextEditingController passController = TextEditingController();


  TextEditingController emailRegController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passRegController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeAddressController = TextEditingController();
  TextEditingController occuController = TextEditingController();
  TextEditingController referralController = TextEditingController();


  RxBool isCheck = false.obs;
  updateCheck(val) {
    isCheck.value = val;
    update();
  }

  RxBool isCheck2 = false.obs;
  updateCheck2(val) {
    isCheck2.value = val;
    update();
  }

  RxBool isCheck3 = false.obs;
  updateCheck3(val) {
    isCheck3.value = val;
    update();
  }



  @override
  Future<void> onInit() async {
    super.onInit();
    getProvinceData();
    getStoreData();
    getAllAdsData();
  }

  var provinceList = <Province>[].obs;

  getProvinceData() async {
    try {

      update();

      var profData = await ApiManger.getProvince();
      if (profData != null) {
        provinceList.value = profData.response?.data as dynamic;
        for (int i = 0; i < profData.response!.data!.length; i++) {
          provinceAllList
              .add(profData.response!.data![i].name.toString());
        }
        print(
            "This is province ${profData.response?.data}");
      } else {

        update();
      }
    } catch (e) {

      update();
      debugPrint(e.toString());
    } finally {

      update();
    }
    update();
  }

  clearForget(){
    verifyCodeForgetController.clear();
    emailForgetController.clear();
     isVisible = true.obs;
     isVisible1 = true.obs;
     isVisible2 = true.obs;
     updateVerifyLoader(false);
     updateResendLoader(false);
     updatePasswordLoader(false);
     updateForgetLoader(false);
  }

  var email=''.obs;
  var password=''.obs;
  updateEmail(val){
    email.value=val;
  }
  updatePass(val){
    password.value=val;
  }

  clear(){
    fullNameController.clear();
    occuController.clear();
    storeNameController.clear();
    storeAddressController.clear();
    updateCheck(false);
    updateCheck2(false);
    updateLng("");
    updateLat("");
    file=null;
    file1=null;
    isVisible = true.obs;
    isVisible1 = true.obs;
    isVisible2 = true.obs;
    updateLoginLoader(false);
    updateLoader(false);

    mobileController.clear();
    provinceId=null;
  }


  var storeName=TextEditingController();
  var storeDes=TextEditingController();
  var storeNumber=TextEditingController();
  var storeAddress=TextEditingController();
  var termsService=TextEditingController();
  var returnPol=TextEditingController();
  var disResol=TextEditingController();
  var busRegInformation=TextEditingController();
  File ? storeLogoFile;
  File ? storeBannerFile;
  File?fileService;
  File?returnPolicy;
  File?dispute;
  File?businessReg;

  clearBusiness(){
    storeName.clear();
    storeDes.clear();
    storeNumber.clear();
    storeAddress.clear();
    termsService.clear();
    returnPol.clear();
    disResol.clear();
    busRegInformation.clear();
    storeLogoFile=null;
    storeBannerFile=null;
    fileService=null;
    returnPolicy=null;
    dispute=null;
    businessReg=null;
  }

  var storeReg=false.obs;
  updateStoreReg(val){
    storeReg.value=val;
    update();
  }



  var getStoreList = <StoreDataModel>[].obs;
var storeLoader = false.obs;
  getStoreData() async {
    try {
      storeLoader(true);
      update();

      var profData = await ApiManger.getStoreAllModel();
      if (profData != null) {
        getStoreList.value = profData.response?.data as dynamic;
        storeLoader(false);
        print(
            "This is province ${profData.response?.data}");
      } else {
        storeLoader(false);
        update();
      }
    } catch (e) {
      storeLoader(false);
      update();
      debugPrint(e.toString());
    } finally {
      storeLoader(false);
      update();
    }
    update();
  }


  var getAllAdsList = <MyAllModelData>[].obs;
  var allAdsLoader = false.obs;

  getAllAdsData() async {
    try {
      allAdsLoader(true);
      update();


      var profData = await ApiManger.getAllUserAds();
      if (profData != null) {
        getAllAdsList.value = profData.response?.data as dynamic;
        print(
            "This is my comments ${ profData.response?.data}");
      } else {
        allAdsLoader(false);
        update();
      }
    } catch (e) {

      allAdsLoader(false);
      update();
      debugPrint(e.toString());
    } finally {
      allAdsLoader(false);
      update();
    }
    update();
  }
}