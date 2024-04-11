

import 'package:get/get.dart';
import 'package:giftcart/app/home/controller/home_controller.dart';

class AppConstants {

  //static  String baseURL = 'https://slot-app-8c4916a05b3c.herokuapp.com/api/';
  static  String baseURL = 'https://api.mr-corp.ca/api/';
  static const String getProvince = 'get_province';
  static const String faq = 'get_faq';
  static const String register = 'register/';
  static const String businessRegister = 'register/';
  static const String verifyEmail = 'verify_email/';
  static const String contac = 'ContactUs';
  static const String forget = 'forgot_password/';
  static const String login = 'login/';
  static const String social_login = 'social_login/';
  static const String addSLOT = 'confirm_slots/';
  static const String getSlot = 'get_slots';
  static const String getProfile = 'get_profile';
  static const String editProfile = 'edit_profile/';
  static const String claimReward = 'claim_reward/';
  static const String scratch = 'couponScratch';
  static const String testmonials = 'get_testimonials';
  static const String getWinners = 'winners';
  static const String referrlCode = 'referUser';
  static const String addPayment = 'add_payment/';
  static const String getPayment = 'getwallet';
  static const String get_invoice = 'get_invoice/';
  static const String add_invoice = 'redeem_coins/';
  static const String user_refrell = 'use_referel_code/';
  static const String myTrans = 'get_transaction_history/';
  static const String getAccount = 'get_bank_account/';
  static const String all_users = 'province_users/';
  static const String delAccount = 'delAccount';
  static const String addAccount = 'addAccount/';
  static const String userStore = 'getAllStore';
  static const String getHistory = 'get_slots_history/';
  static const String getStats = 'user_slots_stats';
  static const String getNotification = 'user_notifications';
  static const String scratchCoupon = 'scratch_slot/';
  static const String postComment = 'post_comment/';
  static const String get_comment = 'get_comments/';
  static const String my_ads = 'user_ads/';
  static const String my_ads_all = 'all_user_ads/';
  static const String like_video = 'like_testimanial/';
  static const String get_like = 'get_single_testimanial/';
  static const String getBusinessProfile = 'get_profile';
  static const String createAd = 'create_ad/';
  static const String storeCreate = 'create_storeinfo/';
  static const String editStore = 'edit_storeinfo/';
  static const String addBank = 'add_bank_account/';
  static const String paymentStore = 'payment_to_store/';
  static const String payHistory = 'payment_history/';
  static const String sendMessage = 'send_message/';
  static const String getAllStore = 'get_all_store';
  static const String getMessage = 'get_message/';
  static const String logout = 'logout_profile/';
  static const String updateStoreTime = 'update_store_time/.';
  static const String storeEditProfile = 'edit_profile/';
  // api/scratch_slot/slot_id/.


  static const String storeRegister = 'storeSignup';
  static const String addStore = 'Addstore';
  static const String add_User_Store = 'AddUserstore';
  static const String getStore = 'getBussinessStore';
  static const String paymentProof = 'apply_payment_proof/';
  static const String provinceUser = 'province_users/';

  static bool isNotification = false;
  static String bidSlug = "";
  static String FCM_TOKEN = "";




  static String wa_url() {
    return "whatsapp://send?text="

        "${Get.put(HomeController()).referCode.value.toString()}    Use this code"
       ;
  }


}
