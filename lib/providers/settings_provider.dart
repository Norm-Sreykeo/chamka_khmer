import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const _kNotifyOrder = 'settings.notifyOrder';
  static const _kNotifyPromo = 'settings.notifyPromo';
  static const _kNotifyNewProduct = 'settings.notifyNewProduct';
  static const _kDarkMode = 'settings.darkMode';
  static const _kLanguageIndex = 'settings.languageIndex';

  SharedPreferences? _prefs;

  bool _notifyOrder = true;
  bool _notifyPromo = true;
  bool _notifyNewProduct = true;
  bool _darkMode = false;
  int _languageIndex = 0;

  bool get notifyOrder => _notifyOrder;
  bool get notifyPromo => _notifyPromo;
  bool get notifyNewProduct => _notifyNewProduct;
  bool get darkMode => _darkMode;
  int get languageIndex => _languageIndex;

  ThemeMode get themeMode => _darkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();

    _notifyOrder = _prefs?.getBool(_kNotifyOrder) ?? _notifyOrder;
    _notifyPromo = _prefs?.getBool(_kNotifyPromo) ?? _notifyPromo;
    _notifyNewProduct = _prefs?.getBool(_kNotifyNewProduct) ?? _notifyNewProduct;
    _darkMode = _prefs?.getBool(_kDarkMode) ?? _darkMode;
    _languageIndex = _prefs?.getInt(_kLanguageIndex) ?? _languageIndex;

    notifyListeners();
  }

  Future<void> setNotifyOrder(bool v) async {
    _notifyOrder = v;
    await _prefs?.setBool(_kNotifyOrder, v);
    notifyListeners();
  }

  Future<void> setNotifyPromo(bool v) async {
    _notifyPromo = v;
    await _prefs?.setBool(_kNotifyPromo, v);
    notifyListeners();
  }

  Future<void> setNotifyNewProduct(bool v) async {
    _notifyNewProduct = v;
    await _prefs?.setBool(_kNotifyNewProduct, v);
    notifyListeners();
  }

  Future<void> setDarkMode(bool v) async {
    _darkMode = v;
    await _prefs?.setBool(_kDarkMode, v);
    notifyListeners();
  }

  Future<void> setLanguageIndex(int v) async {
    _languageIndex = v;
    await _prefs?.setInt(_kLanguageIndex, v);
    notifyListeners();
  }
}
