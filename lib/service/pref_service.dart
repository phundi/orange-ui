import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static Future<bool?> getLoginText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin");
  }

  static Future<void> setLoginText(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogin", value);
  }

  static Future<String?> getFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("fullName");
  }

  static Future<void> setFullName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("fullName", value);
  }

  static Future<String?> getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("address");
  }

  static Future<void> setAddress(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("address", value);
  }

  static Future<String?> getBioText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("bioText");
  }

  static Future<void> setBioText(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("bioText", value);
  }

  static Future<int?> getAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("age");
  }

  static Future<void> setAge(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("age", value);
  }

  static Future<String?> getGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("gender");
  }

  static Future<void> setGender(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("gender", value);
  }

  static Future<bool?> getFirstProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("firstProfile");
  }

  static Future<void> setFirstProfile(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("firstProfile", value);
  }

  static Future<List<String>?> getProfileImageList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? list = prefs.getStringList("firstProfile");
    return list;
  }

  static Future<void> setProfileImageList(List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("firstProfile", value);
  }

  static Future<String?> getInstagramString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("instagram");
  }

  static Future<void> setInstagramString(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("instagram", value);
  }

  static Future<String?> getYoutubeString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("youtube");
  }

  static Future<void> setYoutubeString(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("youtube", value);
  }
}
