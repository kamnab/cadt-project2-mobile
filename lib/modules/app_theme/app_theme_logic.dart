import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppThemeLogic extends ChangeNotifier {
  int _themeIndex = 0; //0: light, 1: dark, 2: system
  int get themeIndex => _themeIndex;

  final _storage = const FlutterSecureStorage();
  final _key = "AppThemeLogic";

  Future<void> readTheme() async {
    String themeIndexString = await _storage.read(key: _key) ?? "0";
    _themeIndex = int.parse(themeIndexString);
    notifyListeners();
  }

  Future<void> changeToLight() async {
    _themeIndex = 0;
    _storage.write(key: _key, value: _themeIndex.toString());
    notifyListeners();
  }

  Future<void> changeToDark() async {
    _themeIndex = 1;
    _storage.write(key: _key, value: _themeIndex.toString());
    notifyListeners();
  }

  Future<void> changeToSystem() async {
    _themeIndex = 2;
    _storage.write(key: _key, value: _themeIndex.toString());
    notifyListeners();
  }
}
