import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/constants/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AppConfigProvider extends ChangeNotifier {
  SharedPreferences? sharedPreferences;
  String? locale;

  AppConfigProvider(this.sharedPreferences);

  bool isEnglish() => locale == AppConst.enLocale;

  void changeLanguage(String selectedLocale) {
    if (locale == selectedLocale) return;
    locale = selectedLocale;
    setLocale(selectedLocale); // Notify listeners to update the UI
    notifyListeners();
  }

  Future<void> setLocale(String locale) async {
    await sharedPreferences?.setString(AppConst.localeKey, locale);
  }

  void getLocale()  {
    locale =
        sharedPreferences?.getString(AppConst.localeKey) ?? AppConst.enLocale;
  }
}
