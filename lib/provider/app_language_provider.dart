
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
  String _appLanguage = 'en';

  String get appLanguage => _appLanguage;

  initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _appLanguage = prefs.getString('language') ?? 'en';
    notifyListeners();
  }

  changeLanguage(String newLanguage) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', newLanguage);
    _appLanguage = newLanguage;
    notifyListeners();
  }
}
