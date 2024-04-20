import 'package:shared_preferences/shared_preferences.dart';

class DataProvider {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveTransportationData({
    required String q4,
    required String q5,
    required String q6,
  }) async {
    await _prefs.setString('transportation_q4', q4);
    await _prefs.setString('transportation_q5', q5);
    await _prefs.setString('transportation_q6', q6);
  }

  static Future<Map<String, String>> loadTransportationData() async {
    final q4 = _prefs.getString('transportation_q4') ?? '';
    final q5 = _prefs.getString('transportation_q5') ?? '';
    final q6 = _prefs.getString('transportation_q6') ?? '';

    return {
      'q4': q4,
      'q5': q5,
      'q6': q6,
    };
  }

  static Future<void> saveUsageData({
    required String category,
    required String q1,
    required String q2,
    required String q3,
  }) async {
    await _prefs.setString('${category}_q1', q1);
    await _prefs.setString('${category}_q2', q2);
    await _prefs.setString('${category}_q3', q3);
  }

  static Future<Map<String, String>> loadUsageData({required String category}) async {
    final q1 = _prefs.getString('${category}_q1') ?? '';
    final q2 = _prefs.getString('${category}_q2') ?? '';
    final q3 = _prefs.getString('${category}_q3') ?? '';

    return {
      'q1': q1,
      'q2': q2,
      'q3': q3,
    };
  }
}
