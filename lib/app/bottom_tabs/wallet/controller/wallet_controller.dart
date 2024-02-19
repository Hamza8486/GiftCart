import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mr_bet/services/api_manager.dart';
import 'package:mr_bet/util/toast.dart';


class PaymentController extends GetxController{

  var cardType = "".obs;

  var checkPayment="".obs;
  var checkLoader=false.obs;
  updateCheckLoader(val){
    checkLoader.value=val;
    update();
  }
  updateCheckPayment(val){
    checkPayment.value=val;
    update();
  }
  var priceController =  TextEditingController();

  var PaymentId="".obs;
  updatePaymentId(val){
    PaymentId.value=val;
    update();
  }
  var index = 1.obs;

  var storePayment=false.obs;

  updateStorePayment(val){
    storePayment.value
        =val;

    update();
  }

  var isPayment=false.obs;
  var isPaymentSucess=false.obs;
  updatePayment(val){
    isPayment.value=val;
    update();
  }
  updatePaymentSucess(val){
    isPaymentSucess.value=val;
    update();
  }

  increment() {
    index++;
    update();
  }
  var totalPrice = "".obs;
  updateTotalPrice(val){
    totalPrice.value=val;
    update();
  }

  setIndex(indexType) {
    index.value = indexType;
    update();
  }

  decrement() {
    --index;
    update();
  }

  var addCard = "".obs;

  addUpdate(val){
    addCard.value = val;
  }

  cardUpdate(val){
    cardType.value = val;

  }







  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);

      if (paymentIntentData != null) {
        var gPay= const PaymentSheetGooglePay(
            merchantCountryCode: "cad",
            currencyCode: "cad",
            testEnv: true
        );
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                merchantDisplayName: 'Ikay',
                customerId: paymentIntentData!['customer'],
                paymentIntentClientSecret: paymentIntentData!['client_secret'],
                customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
                style: ThemeMode.dark,
                googlePay: gPay
            ));

        print(paymentIntentData);

        displayPaymentSheet(totalFee: amount);

      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }


  displayPaymentSheet({totalFee}) async {
    try {
      updateCheckLoader(false);
      await Stripe.instance.presentPaymentSheet().then((value) {
        paymentIntentData = null;
        print("This is value");
        print(PaymentId.value.toString());

        updateCheckLoader(true);
        ApiManger().addPaymentWalet(
          id: PaymentId.value.toString(),
          amount: checkPayment.value.toString()

        );




      }).onError((error, stackTrace) {
        print("Payment Declined");
        flutterToast(msg: "Payment Declined");
        throw Exception(error);

      });
    } on StripeException catch (e) {
      print("Payment Declined");
      flutterToast(msg: "Payment Declined");
      print('Error is:---> $e');

    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer ${dotenv.env['STRIPE_SECRET']}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print(response.body);
      if(response.statusCode==200){
        var jsonString=jsonDecode(response.body);

        print("This is respnonse");
        print(jsonString["id"].toString());
        updatePaymentId(jsonString["id"].toString());
        print(response.body);
        updatePayment(false);

        return jsonDecode(response.body);

      }
      else{
        updatePayment(false);
        return jsonDecode(response.body);
      }


    } catch (err) {
      updatePayment(false);
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    print(a);
    return a.toString();
  }
}