import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static SharedPreferences? _preferences;
  static const _key = "data";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setData(List<String> data) async {
    return await _preferences!.setStringList(_key, data);
  }

  static List<String>? getData() {
    return _preferences!.getStringList(_key);
  }

  static void removeData() => _preferences!.remove(_key);
}
