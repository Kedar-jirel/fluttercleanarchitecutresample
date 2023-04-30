import 'dart:convert';
import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

import '../../domain/repository/auth/auth_repo.dart';
import '../../domain/repository/auth/i_auth_repo.dart';

class AppConfig {
  static String TAG = "SETTINGS";

  String? appName;
  String? flavorName;
  String? baseUrl;
  String? imageBaseUrl;
  int? port;
  Color? color;
  late String eSewaClientId;
  late String eSewaClientSecret;
  Map<String, dynamic>? _appConfigMap = Map();

  AppConfig();

  void initalize({
    required String appName,
    required String flavorName,
    required String baseUrl,
    required int port,
    Color? color,
    required String eSewaClientId,
    required String eSewaClientSecret,
    required String imageBaseUrl,
  }) {
    this.appName = appName;
    this.flavorName = flavorName;
    this.baseUrl = baseUrl;
    this.imageBaseUrl = imageBaseUrl;
    this.port = port;
    this.color = color;
    this.eSewaClientId = eSewaClientId;
    this.eSewaClientSecret = eSewaClientSecret;

    // aliceInterceptor =
    //     Alice(showNotification: true, showInspectorOnShake: false);
  }

  setRouter() {
    // aliceInterceptor.setNavigatorKey();
  }

  String getApiUrl() {
    if (flavorName == "loc") {
      return '$baseUrl${port != null ? ":$port" : ""}/v1';
    }
    return "$baseUrl/v1";
  }

  String? getBaseUrl() {
    return baseUrl;
  }

  String? getImageBaseUrl() {
    return imageBaseUrl;
  }

  Future<void> fetchServerConfigSetting() async {
    final rxPrefs = RxSharedPreferences(SharedPreferences.getInstance());
    AuthRepo _authRepo = GetIt.I<IAuthRepo>() as AuthRepo;
    try {
      var config = await _authRepo.fetchServerConfig();
      _appConfigMap = config;
      rxPrefs.setString(TAG, jsonEncode(_appConfigMap));
    } catch (e) {
      print("${e}");
    }
  }

  Future<Map<String, dynamic>?> getAppConfig() async {
    final rxPrefs = RxSharedPreferences(SharedPreferences.getInstance());
    String? jsonString = await rxPrefs.getString(TAG);
    _appConfigMap = jsonDecode(jsonString!);
    return _appConfigMap;
  }

  Future<Map<String, dynamic>?> getappConfigMap() async {
    final rxPrefs = RxSharedPreferences(SharedPreferences.getInstance());
    String? jsonString = await rxPrefs.getString(TAG);
    if (jsonString != null) {
      _appConfigMap = jsonDecode(jsonString);
      return _appConfigMap;
    } else {
      // AuthRepo _authRepo = GetIt.I<IAuthRepo>() as AuthRepo;
      // var config = await _authRepo.fetchServerConfig();
      // _appConfigMap = config;
      // rxPrefs.setString(TAG, jsonEncode(_appConfigMap));
      return _appConfigMap;
    }
  }
}
