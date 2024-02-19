import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/comment_model.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/like_model.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/my_ads_model.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/my_slots.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/payment_model.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/slot_model.dart';
import 'package:mr_bet/app/bottom_tabs/dashboard/model/transaction_model.dart';
import 'package:mr_bet/app/bottom_tabs/profile/model/profile_model.dart';
import 'package:mr_bet/app/bottom_tabs/profile/model/user_store.dart';
import 'package:mr_bet/app/bottom_tabs/profile/model/winner_chat_model.dart';
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/widgets/helper_function.dart';




class HomeController extends GetxController {

  var slotAddList=<AddSlotModel>[].obs;

  var showPopUp=false.obs;
  updatePopup(val){
    showPopUp.value=val;

    update();
  }
  var isValue = false.obs;
  RxBool expand = false.obs;
  var isLoading = false.obs;

  var paymentProof = false.obs;
  updatePaymentProof(val){
    paymentProof.value=val;
    update();
  }
  var adLoader = false.obs;
  updateAdLoader(val){
    adLoader.value=val;
    update();
  }
  var isValue1 = false.obs;
  var checkLoader=false.obs;
  updateCheckLoader(val){
    checkLoader.value=val;
    update();
  }
  File?file;
  File?file1;

  var priceController = TextEditingController();
  var isValue2 = true.obs;
  var loader = false.obs;
  updateFirstName(val) {
    name.value = val;
    update();
  }

  updatePhone(val) {
    phone.value = val;
    update();
  }
  updateLoader(val){
    loader.value=val;
    update();
  }
  var profileId="".obs;
  updateProfileId(val){
    profileId.value=val;
    update();
  }
  var imageLoader = false.obs;
  var totalEarning="".obs;
  var rewardEarning="".obs;
  updateToatlEaening(val){
    totalEarning.value=val;
    update();
  }
  updateRewardEarning(val){
    rewardEarning.value=val;
    update();
  }
  updateImageLoader(val){
    imageLoader.value=val;
    update();
  }
  var totalPrice="".obs;
  var image="".obs;
  updateProfileImage(val){
    image.value=val;
    update();

  }
  var referCode="".obs;
  updateReferCode(val){
    referCode.value=val;
    update();
  }


  var isClaim = false.obs;
  updateIsClaim(val){
    isClaim.value=val;
    update();
  }

  XFile?videoFile;
  File ?  myProfile;
  File ?  claimProfile;
  updateTotalPrice(val){
    totalPrice.value=val;
    update();

  }

  var slotProfileId="".obs;
  updateProfileSlot(val){
    slotProfileId.value=val;
    update();
  }

  var selectProvince="".obs;
  var isSelectProvince="".obs;
  updateProvincesName(val){
    selectProvince.value=val;
    update();
  }

  updateIsSelectProvince(val){
    isSelectProvince.value=val;
    update();
  }

  updateValue1(val) {
    isValue1.value = val;

    update();
  }
  updateValue2(val) {
    isValue2.value = val;

    update();
  }
  updateValue(val) {
    isValue.value = val;

    update();
  }
  var provinceId;
  var phone = "".obs;
  var token = "".obs;
  var email = "".obs;
  var type = "".obs;
  var name = "".obs;
  var selectOption = "3".obs;
  var selectOptionName = "grocery".obs;
  var provinceName="".obs;
  var province1Name="".obs;
  var slot="".obs;
  var typeSelect="".obs;
  updateProvinceName(val){
    provinceName.value=val;
    update();

  }
  updateProvince1Name(val){
    province1Name.value=val;
    update();

  }
  updateTypeSelect(val){
    typeSelect.value=val;
    update();

  }
  updateSlotName(val){
    slot.value=val;
    update();

  }

  var updateSelectValue=false.obs;
  updateSelect(val){
    updateSelectValue.value=val;

  }
  updateSelectName(val){
    selectOptionName.value=val;

  }



  updateSelectOption(val){
    selectOption.value=val;
    update();

  }
  TextEditingController nameController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
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
    HelperFunctions.getFromPreference("phone").then((value) {
      phone.value = value;

      update();
    });
    HelperFunctions.getFromPreference("type").then((value) {
      type.value = value;

      update();
    });
    HelperFunctions.getFromPreference("token").then((value) {
      token.value = value;
      getProfileData();
      getPayHisData();
      getAdsData();
      getSlotData(id: "");
      getTransData();



      print(token.value.toString());
      update();
    });



    super.onInit();

  }





  var getSlot1 = <SlotDataNew>[].obs;

  var isLoading1 = false.obs;

  updateAddSlot(val){
    slotAdd.value=val;
    update();
  }

  ProfileDataModel? profileAllData;
  getProfileData() async {
    try {


      update();

      var profData = await ApiManger.getProfileModel();
      if (profData != null) {
         profileAllData = profData.response ;
        updateProfileSlot(profData.response?.data?.claimReward==false?"":profData.response?.data?.toString());
        updateProfileImage(profData.response?.data?.logo==null?"":profData.response?.data?.logo.toString());
        updateReferCode(profData.response?.data?.referelCode.toString()==null?"":profData.response?.data?.referelCode.toString());
        updateToatlEaening(profData.response?.data?.reward==null?"0":profData.response?.data?.reward.toString());
         updateRewardEarning(profData.response?.data?.gift==null?"0":profData.response?.data?.gift.toString());
        updateProfileId(profData.response?.data?.id==0?"0":profData.response?.data?.id.toString());
        print(
            "This is my profile ${profData.response?.data}");
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




  var getSlot = <SlotDataNew>[].obs;
  var slotAdd = false.obs;
  getSlotData({String id="",bool isLoadings=true}) async {
    try {
      if(isLoadings=true){
        isLoading(true);
        update();
      }
      else{
        isLoading(false);
        update();
      }


      var profData = await ApiManger.getMySlotsAll(id: id);
      if (profData != null) {
        getSlot.value = profData.response?.data as dynamic;
        print(
            "This is my Slots ${ profData.response?.data}");
      } else {
        isLoading(false);
        update();
      }
    } catch (e) {

      isLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      isLoading(false);
      update();
    }
    update();
  }




  var testLoading = false.obs;
  var testList = [].obs;

  getAllTest({id=""}) async {
    try {

      testLoading(true);
      update();

      var profData = await ApiManger.getTest(id: id.toString());
      if (profData != null) {
        testList.value = profData.response?.data as dynamic;

        print(
            "This is my Slots ${profData.response?.data}");
      } else {
        testLoading(false);
        update();
      }
    } catch (e) {

      testLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      testLoading(false);
      update();
    }
    update();
  }




  var slotLoading = false.obs;
  var slotHistList = [].obs;

  getSlotHis({id=""}) async {
    try {

      slotLoading(true);
      update();

      var profData = await ApiManger.getSlotHistory(id: id.toString());
      if (profData != null) {
        slotHistList.value = profData.response?.data as dynamic;

        print(
            "This is my Slots ${profData.response?.data}");
      } else {
        slotLoading(false);
        update();
      }
    } catch (e) {

      slotLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      slotLoading(false);
      update();
    }
    update();
  }






  var statLoading = false.obs;
  var statHistList = [].obs;

  getStatHis({id="",day=""}) async {
    try {

      statLoading(true);
      update();

      var profData = await ApiManger.getStatHistory(id: id.toString(),day: day);
      if (profData != null) {
        statHistList.value = profData.response?.data as dynamic;
        updateTotalPrice(
            profData.response?.totalPrice==null?"0":
            profData.response?.totalPrice.toString());

        print(
            "This is my Slots ${profData.response?.data}");
      } else {
        statLoading(false);
        update();
      }
    } catch (e) {

      statLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      statLoading(false);
      update();
    }
    update();
  }




  var notiLoading = false.obs;
  var notiList = [].obs;

  getNotiHis() async {
    try {

      notiLoading(true);
      update();

      var profData = await ApiManger.getNotification();
      if (profData != null) {
        notiList.value = profData.response?.data as dynamic;


        print(
            "This is my notification ${profData.response?.data}");
      } else {
        notiLoading(false);
        update();
      }
    } catch (e) {

      notiLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      notiLoading(false);
      update();
    }
    update();
  }





  var winnerValue = false.obs;
  var winnerList = [].obs;

  getWinnerData() async {
    try {

      winnerValue(true);
      update();

      var profData = await ApiManger.getWinners();
      if (profData != null) {
        winnerList.value = profData.response?.data as dynamic;

        print(
            "This is my Slots ${profData.response?.data}");
      } else {
        winnerValue(false);
        update();
      }
    } catch (e) {

      winnerValue(false);
      update();
      debugPrint(e.toString());
    } finally {
      winnerValue(false);
      update();
    }
    update();
  }







  var totalAmountWallet="0".obs;
  updateTotalAmount(val){
    totalAmountWallet.value=val;
    update();

  }




  var transactionLoadingValue = false.obs;
  var transList = <MyTransactionAllData>[].obs;
  getTransData() async {
    try {

      transactionLoadingValue(true);
      update();

      var profData = await ApiManger.getTrans();
      if (profData != null) {
        transList.value =
        profData.response?.data as dynamic;
        updateTotalAmount(
            profData==null?"0":
            profData.response?.balance==null?"0":
            profData.response?.balance==0?"0": profData.response?.balance.toString());

      } else {
        transactionLoadingValue(false);
        update();
      }
    } catch (e) {

      transactionLoadingValue(false);
      update();
      debugPrint(e.toString());
    } finally {
      transactionLoadingValue(false);
      update();
    }
    update();
  }



  var accountLoading = false.obs;

  var accountList = [].obs;
  getAccountData() async {
    try {

      accountLoading(true);
      update();

      var profData = await ApiManger.getAccount();
      if (profData != null) {
        accountList.value =
        profData.amount as dynamic;

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




  var faqLoading = false.obs;

  var faqList = [].obs;
  getFaqData() async {
    try {

      faqLoading(true);
      update();

      var profData = await ApiManger.getFaq();
      if (profData != null) {
        faqList.value =
        profData.response?.data as dynamic;

      } else {
        faqLoading(false);
        update();
      }
    } catch (e) {

      faqLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      faqLoading(false);
      update();
    }
    update();
  }




  var storeLoading = false.obs;

  var storeList = <Stores>[].obs;
  getStoreData() async {
    try {

      storeLoading(true);
      update();

      var profData = await ApiManger.getUserStore();
      if (profData != null) {
        storeList.value =
        profData.stores as dynamic;


      } else {
        storeLoading(false);
        update();
      }
    } catch (e) {

      storeLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      storeLoading(false);
      update();
    }
    update();
  }


  var groceryId="".obs;
  updateGroceryId(val){
    groceryId.value=val;
    update();
  }


  getAllBetData() async {
    try {


      update();

      var profData = await ApiManger.getBetApi();
      if (profData != null) {
        updateGroceryId(profData.data?[0].id.toString());
        print("This is bet Id${profData.data?[0].id.toString()}");



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


  var getCommentList = <AllCommentData>[].obs;
  var allCommentLoader = false.obs;
  var commentUpdate = false.obs;
  updateComment(val){
    commentUpdate.value=val;
    update();
  }
  getComments({String id="",bool isLoadings=true}) async {
    try {
      if(isLoadings=true){
        allCommentLoader(true);
        update();
      }
      else{
        allCommentLoader(false);
        update();
      }


      var profData = await ApiManger.getCommentAll(id: id);
      if (profData != null) {
        getCommentList.value = profData.response?.data as dynamic;
        print(
            "This is my comments ${ profData.response?.data}");
      } else {
        allCommentLoader(false);
        update();
      }
    } catch (e) {

      allCommentLoader(false);
      update();
      debugPrint(e.toString());
    } finally {
      allCommentLoader(false);
      update();
    }
    update();
  }

  var likeStatus=false.obs;
   updateLikeStatus(val){
     likeStatus.value=val;
     update();
   }

  LikeResponse ? likeResponse;
  getLikeTestMonial({String id=""}) async {
    try {



      var profData = await ApiManger.getLikeModel(id: id);
      if (profData != null) {
        updateLikeStatus(profData.response?.data?.isLiked);
        likeResponse = profData.response as dynamic;
        print(
            "This is my like ${ profData.response}");
      } else {

      }
    } catch (e) {


      debugPrint(e.toString());
    } finally {

    }
    update();
  }



  var getAdsList = <MyAllModelData>[].obs;
  var userAdsLoader = false.obs;

  getAdsData() async {
    try {
      userAdsLoader(true);
      update();


      var profData = await ApiManger.getAllAdsModel();
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







  var getProofList = <PaymentProofAllData>[].obs;
  var allPaymentLoader = false.obs;

  getPayHisData() async {
    try {
      allPaymentLoader(true);
      update();


      var profData = await ApiManger.getPaymentProfModel();
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





  var messageLoader=false.obs;
  var messageCheckLoader=false.obs;
  var addMessageLoader=false.obs;


  WinnerChatAllModelDData ? winnersChatModel;
  getWinnerChar({String id=""}) async {
    try {

      messageLoader(true);
      update();

      var profData = await ApiManger.getMessageALL(id: id);
      if (profData != null) {

        winnersChatModel = profData.response as dynamic;
        print(
            "This is my like ${ profData.response}");

        messageLoader(false);
        update();
      } else {
        messageLoader(false);
        update();
      }
    } catch (e) {

      messageLoader(false);
      update();
      debugPrint(e.toString());
    } finally {
      messageLoader(false);
      update();
    }
    update();
  }




  var getAllUser = [].obs;
  var allLoader = false.obs;
  getSlotUserData() async {
    try {
      allLoader(true);
      update();


      var profData = await ApiManger.allUserModel();
      if (profData != null) {
        getAllUser.value = profData as dynamic;

      } else {
        isLoading(false);
        update();
      }
    } catch (e) {

      isLoading(false);
      update();
      debugPrint(e.toString());
    } finally {
      isLoading(false);
      update();
    }
    update();
  }

}

