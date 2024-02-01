import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprotbuzz/core/utilis/my_strings.dart';
import 'package:sprotbuzz/data/model/language_models.dart';


class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(MyStrings.languages[0].languageCode,
     MyStrings.languages[0].countryCode);

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  List<LanguageModel> _languages = [];
  Locale get locale => _locale;
  List<LanguageModel> get languages => _languages;

  void loadCurrentLanguage() {
    // only gets called during installation or rebooting
    _locale = Locale(sharedPreferences.getString(MyStrings.LANGUAGE_CODE) ??
        MyStrings.languages[0].languageCode,
        sharedPreferences.getString(MyStrings.COUNTRY_CODE) ??
            MyStrings.languages[0].countryCode);

    for (int index = 0; index < MyStrings.languages.length; index++) {
      if (MyStrings.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(MyStrings.languages);
    update();
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    update();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(
      MyStrings.LANGUAGE_CODE, locale.languageCode);
    sharedPreferences.setString(MyStrings.COUNTRY_CODE, locale.countryCode!);
  }

}

