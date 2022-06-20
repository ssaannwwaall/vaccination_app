import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsCurrentUser {
  static const String _userName = 'userName';

  static Future saveUserName(String name) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_userName, name);
      return true;
    } catch (e) {
      print("name saving error $e.toString()");
      return null;
    }
  }

  static Future getUserName() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? value = prefs.getString(_userName);
      print(value);
      print(' current vaccinator name');
      print(value);
      return value;
    } catch (e) {
      print(' current vaccinator name exception...');
      print(e.toString());
      return null;
    }
  }
}
