
// ignore: avoid_classes_with_only_static_members
abstract class Session {

  Future<void> saveUserToken({required String token});


  Future<String?> getCurrentToken();

  Future<String?> getUserRole();

  Future<bool> isAuthenticated();

  Future<void> clearUserSession();

  // Future<User?> getCurrentUser();

  Future<bool> saveFcmToken({required String token});

  Future<void> saveNotificationCount(int count);

  Future<String?> getFcmToken();
  Future<String> getDeviceToken();
  Future<void> setFingerPrintEnabled(bool enabled);

  Future<bool> isFingerPrintEnabled();
  Future<String?> getLoginToken();

  Future<bool> isUserLoginFirstTime();

  Future<void> setUserLoginFirstTime();

  Future<void> setRemembered(bool value);

  Future<bool> isRemembered();

  Future<void> setRememberedUserName(String username);

  Future<String?> getRememberedUserName();

  Future<void> setRememberedPassword(String password);

  Future<String?> getRememberedPassword();

  Future<String> getLanguage();

  Future<bool>  getIsGuestSession();

  Future<void>  setIsGuestSession(bool isGuestSession);

}
