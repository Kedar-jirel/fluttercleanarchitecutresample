import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import 'i_session.dart';

class SessionManager extends Session {
  SharedPreferences? _sharedPreferences;
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() {
    return _instance;
  }

  SessionManager._internal();

  Future<SharedPreferences> getPref() async {
    return _sharedPreferences ?? await SharedPreferences.getInstance();
  }

  @override
  Future<String?> getCurrentToken() async {
    try {
      final SharedPreferences preferences = await getPref();
      final String? token = preferences.getString(tokenKey);
      return token;
    } on Exception {
      rethrow;
    }
  }

  // @override
  // Future<void> saveCredentials({required String token, required User user}) async {
  //   try {
  //     print("saving user and token  \t $token");
  //     final SharedPreferences preferences = await getPref();
  //     await Future.wait([
  //       //  preferences.setString(roleKey, user.role),
  //       // preferences.setString(tokenKey, token),
  //       // preferences.setBool(isAuthenticatedKey, true),
  //       // preferences.setString(userKey, jsonEncode(user.toJson()))
  //     ]);
  //   } on Exception {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<void> saveUser({required User user}) async {
  //   try {
  //     final SharedPreferences preferences = await getPref();
  //     await Future.wait([preferences.setString(userKey, jsonEncode(user.toJson()))]);
  //   } on Exception {
  //     rethrow;
  //   }
  // }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final SharedPreferences preferences = await getPref();
      final bool? isAuthenticated = preferences.getBool("key");
      if (isAuthenticated == null) {
        return false;
      }
      return isAuthenticated;
    } on Exception {
      return false;
    }
  }

  @override
  Future<void> clearUserSession({bool fromChangePassword = false}) async {
    // try {
    //   final SharedPreferences preferences = await getPref();
    //   final v = await preferences.get(tokenKey);
    //   final i = await preferences.get(isAuthenticatedKey);
    //   print("  values :  $i \n   $v  ");
    //
    //   if (fromChangePassword) {
    //     await preferences.setBool(rememberedMeKey, false);
    //     await preferences.remove(rememberedPasswordKey);
    //     await preferences.remove(rememberedUserNameKey);
    //   }
    //   // await preferences.clear();
    //   await preferences.remove(isAuthenticatedKey);
    //   await preferences.remove(tokenKey);
    //   await preferences.remove(isConfiguredKey);
    //   await preferences.remove(userKey);
    // } on Exception {
    //   rethrow;
    // }
  }
  //
  // @override
  // Future<User?> getCurrentUser() async {
  //   try {
  //     final SharedPreferences preferences = await getPref();
  //     final String? currentUser = preferences.getString(userKey);
  //     if (currentUser != null && currentUser.isNotEmpty) {
  //       return compute(responseToUser, jsonDecode(currentUser));
  //     }
  //     return null;
  //   } on Exception {
  //     rethrow;
  //   }
  // }
  //
  @override
  Future<bool> saveFcmToken({required String token}) async {
    try {
      print("Saving Fcm Token :\n   $token  \n ########### ");
      final SharedPreferences preferences = await getPref();
      final String? currentToken = preferences.getString(fcmTokenKey);
      if (currentToken != null && token == currentToken) {
        return false;
      }
      await preferences.setString(fcmTokenKey, token);
      return true;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<String?> getUserRole() async {
    // try {
    //   final SharedPreferences preferences = await getPref();
    //   return preferences.getString(roleKey);
    // } on Exception {
    //   rethrow;
    // }
  }

  @override
  Future<String?> getFcmToken() async {
    final SharedPreferences preferences = await getPref();
    final String? fcmtoken = preferences.getString(fcmTokenKey);
    return fcmtoken;
  }

  @override
  Future<void> saveUserToken({required String token}) async {
    try {
      final SharedPreferences preferences = await getPref();
//       await Future.wait([
//         //  preferences.setString(roleKey, user.role),
//         preferences.setString(tokenKey, token),
//         preferences.setBool(isAuthenticatedKey, true),
// //        preferences.setString(userKey, jsonEncode(user.toJson()))
//       ]);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> saveNotificationCount(int count) async {
    // try {
    //   final SharedPreferences preferences = await getPref();
    //   await preferences.setInt(notificationCountKey, count);
    // } on Exception {
    //   rethrow;
    // }
  }

  @override
  Future<void> setUserLoginFirstTime() async {
    // try {
    //   final SharedPreferences pref = await getPref();
    //   pref.setBool(firstTimeLoginKey, false);
    // } on Exception {
    //   rethrow;
    // }
  }

  Future<void> saveDeviceToken(String token) async {
    try {
      print("saving biometeric token  \t $token");
      final SharedPreferences preferences = await getPref();
      await Future.wait([
        preferences.setString(fingerPrint_token, token),
        preferences.setBool(fingerPrintKey, true),
        preferences.setBool(firstTimeLoginKey, true)
      ]);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<String> getDeviceToken() async {
    try {
      final SharedPreferences pref = await getPref();
      final String value = pref.getString(fingerPrint_token) ?? "";
      return value;
    } on Exception {
      return "";
    }
  }

  @override
  Future<String?> getLoginToken() async {
    // bool isEnabled = await isFingerPrintEnabled();
    return getCurrentToken();
    // return isEnabled ? getCurrentToken() : getCurrentToken();
  }

  @override
  Future<bool> isFingerPrintEnabled() async {
    try {
      final SharedPreferences pref = await getPref();
      final bool value = pref.getBool(fingerPrintKey) ?? false;
      return value;
    } on Exception {
      return false;
    }
  }

  @override
  Future<bool> isUserLoginFirstTime() async {
    try {
      final SharedPreferences pref = await getPref();
      final bool value = pref.getBool(firstTimeLoginKey) ?? true;
      return Future.value(value);
    } on Exception {
      return Future.value(true);
    }
  }

  @override
  Future<void> setFingerPrintEnabled(bool enabled) async {
    try {
      final SharedPreferences pref = await getPref();
      pref.setBool(fingerPrintKey, enabled);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<String?> getRememberedUserName() async {
    try {
      final SharedPreferences pref = await getPref();
      final String? value = pref.getString(rememberedUserNameKey);
      return value;
      // return value.isEmptyString() ? key_lang_en : value;
    } on Exception {
      return "";
    }
  }

  @override
  Future<void> setRememberedUserName(String username) async {
    try {
      final SharedPreferences pref = await getPref();
      pref.setString(rememberedUserNameKey, username);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<bool> isRemembered() async {
    try {
      final SharedPreferences pref = await getPref();
      final bool? value = pref.getBool(rememberedMeKey);
      return value ?? false;
    } on Exception {
      return false;
    }
  }

  @override
  Future<void> setRemembered(bool value) async {
    try {
      final SharedPreferences pref = await getPref();
      pref.setBool(rememberedMeKey, value);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<String?> getRememberedPassword() async {
    try {
      final SharedPreferences pref = await getPref();
      final String? value = pref.getString(rememberedPasswordKey);
      return value;
    } on Exception {
      return "";
    }
  }

  @override
  Future<void> setRememberedPassword(String password) async {
    try {
      final SharedPreferences pref = await getPref();
      pref.setString(rememberedPasswordKey, password);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<String> getLanguage() async {
    try {
      final SharedPreferences pref = await getPref();
      final String? value = pref.getString(languageKey);
      return value ??'EN';
    } on Exception {
      return 'EN';
    }
  }

  @override
  Future<void> saveSelectedLanguage({required String selectedLanguage}) async {
    try {
      print("saving selected language  \t $selectedLanguage");

      final SharedPreferences preferences = await getPref();
      await Future.wait([
        preferences.setString(languageKey, selectedLanguage),
      ]);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<bool> getIsGuestSession()  async {
    try {
      final SharedPreferences pref = await getPref();
       bool? value = pref.getBool(keyGuestSession);
       value ??= false;
      return Future.value(value);
    } on Exception {
      return Future.value(false);
    }
  }

  @override
  Future<void> setIsGuestSession(bool isGuestSession) async {
    try {
      final SharedPreferences pref = await getPref();
      pref.setBool(keyGuestSession, isGuestSession);
    } on Exception {
      rethrow;
    }
  }

  void saveUserProfile(String userProfile) async{
    try {
      final SharedPreferences pref = await getPref();
      pref.setString(keyUserProfile, userProfile);
    } on Exception {
      rethrow;
    }
  }

  Future<String?> getUserProfile()  async {
      final SharedPreferences pref = await getPref();
      return  pref.getString(keyUserProfile);
  }

}
