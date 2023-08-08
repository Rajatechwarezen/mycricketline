import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = true;

  bool get isDarkTheme => _isDarkTheme;

  Future<void> toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;

    notifyListeners();

    final LocalStorage storage = new LocalStorage('my_theme_storage');
    await storage.setItem('isDarkTheme', _isDarkTheme);
  }

  Future<void> loadThemePreference() async {
    final LocalStorage storage = new LocalStorage('my_theme_storage');
    await storage.ready;

    _isDarkTheme = storage.getItem('isDarkTheme') ?? false;
    notifyListeners();
  }
}
