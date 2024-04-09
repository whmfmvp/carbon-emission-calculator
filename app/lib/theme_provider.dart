import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  Color _themeColor = Colors.white; // 默认颜色

  Color get themeColor => _themeColor;

  set themeColor(Color color) {
    _themeColor = color;
    notifyListeners();
    saveThemeColor(color);
  }

  // 保存颜色到SharedPreferences
  saveThemeColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeColor', color.value);
  }

  // 从SharedPreferences加载颜色
  loadThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    _themeColor = Color(prefs.getInt('themeColor') ?? Colors.white.value);
    notifyListeners();
  }
}
