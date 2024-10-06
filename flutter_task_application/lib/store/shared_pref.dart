import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static Future<void> setUser(
      String name, String email, String role, String token, int uid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('NAME', name);
    pref.setString('EMAIL', email);
    pref.setString('ROLE', role);
    pref.setString('TOKEN', token);
    pref.setInt('UID', uid);
  }

  static Future<Map<dynamic, dynamic>> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return {
      'NAME': pref.getString('NAME')!,
      'EMAIL': pref.getString('EMAIL')!,
      'ROLE': pref.getString('ROLE')!,
      'TOKEN': pref.getString('TOKEN')!,
      'UID': pref.getInt('UID')!,
    };
  }
}
