import 'package:shared_preferences/shared_preferences.dart';

class GiftCartApp {
  static SharedPreferences? prefs;
  static String selectedLocale = "en";

  static getInstance() async {
    prefs = await SharedPreferences.getInstance();
    selectedLocale = prefs?.getString('locale') ?? 'en';
  }

 static updateLocale(String languageCode) async{
    await prefs?.setString('locale', languageCode);
    selectedLocale = languageCode;
  }
}
