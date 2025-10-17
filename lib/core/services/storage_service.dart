import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // Token management
  Future<void> saveAccessToken(String token) async {
    await _prefs.setString(ApiConstants.accessTokenKey, token);
  }

  Future<String?> getAccessToken() async {
    return _prefs.getString(ApiConstants.accessTokenKey);
  }

  Future<void> removeAccessToken() async {
    await _prefs.remove(ApiConstants.accessTokenKey);
  }

  // User data management
  Future<void> saveUserData(String userData) async {
    await _prefs.setString(ApiConstants.userDataKey, userData);
  }

  Future<String?> getUserData() async {
    return _prefs.getString(ApiConstants.userDataKey);
  }

  Future<void> removeUserData() async {
    await _prefs.remove(ApiConstants.userDataKey);
  }

  // Login status
  Future<void> setLoggedIn(bool value) async {
    await _prefs.setBool(ApiConstants.isLoggedInKey, value);
  }

  Future<bool> isLoggedIn() async {
    return _prefs.getBool(ApiConstants.isLoggedInKey) ?? false;
  }

  // Clear all data (logout)
  Future<void> clearAll() async {
    await _prefs.remove(ApiConstants.accessTokenKey);
    await _prefs.remove(ApiConstants.userDataKey);
    await _prefs.remove(ApiConstants.isLoggedInKey);
  }
}

