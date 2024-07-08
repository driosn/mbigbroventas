import 'package:shared_preferences/shared_preferences.dart';

final class StorageHelper {
  SharedPreferences? prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static String usernameKey = 'username';
  static String passwordKey = 'password';

  Future<void> saveUsernameAndPassword(String username, String password) async {
    await prefs!.setString(usernameKey, username);
    await prefs!.setString(passwordKey, password);
  }

  (String?, String?) getUsernameAndPassword() {
    final username = prefs!.getString(usernameKey);
    final password = prefs!.getString(passwordKey);

    return (username, password);
  }

  Future<void> clearUsernameAnPassword() async {
    await prefs!.remove(usernameKey);
    await prefs!.remove(passwordKey);
  }
}

final StorageHelper storageHelper = StorageHelper();
