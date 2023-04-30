import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../core/app/app_config.dart';
import '../core/store/session_manager.dart';
import '../domain/entities/auth_header.dart';
import '../domain/response/api_response.dart';
import 'network_exceptions.dart';

class ApiBaseHelper {
  late Dio _dio;
  String? currentToken;
  String selectedLanguage = 'EN';

  ApiBaseHelper() {
    final BaseOptions options = BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
    );
    _dio = Dio(options);
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    _dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      final ConnectivityResult result =
          await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.none) {
        return handler.reject(DioError(
            type: DioErrorType.response,
            error: NoInternetException(
                message: "You are not connected to internet."),
            requestOptions: options));
      }
      currentToken = await SessionManager().getCurrentToken();
      selectedLanguage = await SessionManager().getLanguage();
      print("current token is $currentToken");

      print(" #############  \n  FCM TOKEN");
      print(await SessionManager().getFcmToken());
      print("\n #############");
      if (currentToken != null) {
        options.headers['X-XSRF-TOKEN'] = '$currentToken';
        await SessionManager()
            .saveSelectedLanguage(selectedLanguage: selectedLanguage);
      }
      options.headers['LOCALIZED-LAN'] = '$selectedLanguage';
      options.headers['Content-Type'] = 'application/json';

      // Position? pos = await GetIt.I<LocationServices>().getPositions();
      AuthHeader authHeader = AuthHeader(
          deviceId: await getDeviceId(),
          token: await SessionManager().getFcmToken(),
          lat:  0.0,
          long:  0.0,
          deviceType: Platform.operatingSystem);

      options.headers['DEVICE-AUTH'] = jsonEncode(authHeader.toJson());
      print("auth header encoded \n ");
      print(jsonEncode(authHeader.toJson()));

      options.baseUrl = GetIt.I<AppConfig>().getApiUrl();
      handler.next(options);
    }, onResponse: (Response response, handler) async {
      final ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      if (response.headers['X-XSRF-TOKEN'] != null) {
        String headerToken = response.headers.value("X-XSRF-TOKEN")!;
        await SessionManager().saveUserToken(token: headerToken);
      }
      return handler.next(response);
    }, onError: (DioError error, handler) async {
      handler.next(error);
    }));

    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true));
    // _dio.interceptors
    //     .add(GetIt.I<AppConfig>().getAliceInterceptor().getDioInterceptor());
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(url, queryParameters: params);
      debugPrint("get response: ${response.toString()}");

      return response.data;
    } on DioError catch (e) {
      throw await _handleError(e);
    }
  }

  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding,
  }) async {
    print("Url:" + url);
    print("Body:");
    print(body);

    try {
      final response = await _dio.post(url, data: body);
      return response.data;
    } on DioError catch (e) {
      throw await _handleError(e);
    }
  }

  Future<dynamic> patch(String url,
      {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    try {
      final response = await _dio.patch(url, data: body);
      return response.data;
    } on DioError catch (e) {
      throw await _handleError(e);
    }
  }

  Future<dynamic> put(String url,
      {Map<String, String>? headers,
      dynamic body,
      Encoding? encoding,
      bool formDataMode = false,
      FormData? formData}) async {
    if (formDataMode) {
      try {
        final response = await _dio.put(url, data: formData);
        return response.data;
      } on DioError catch (e) {
        throw await _handleError(e);
      }
    } else {
      try {
        final response = await _dio.put(url, data: body);
        return response.data;
      } on DioError catch (e) {
        throw await _handleError(e);
      }
    }
  }

  Future<AppException> _handleError(dynamic error) async {
    if (error.type == DioErrorType.connectTimeout) {
      return ConnectionTimeout();
    } else if (error.type == DioErrorType.receiveTimeout) {
      return ReceiveTimeout();
    } else if (error.error is SocketException) {
      return FetchDataException(message: 'Could not connect to the server');
    } else if (error.error is UnauthorisedException) {
      if (await SessionManager().isAuthenticated()) {
        await SessionManager().clearUserSession();
        // GetIt.I
        //     .get<AppRouter>()
        //     .pushAndPopUntil(abc.SignInPageRoute(), predicate: (_) => false);
      }
      return UnauthorisedException(message: error.error.message);
    } else if (error.type == DioErrorType.response) {
      print("#####");
      if (error.response != null) {
        if (error.response!.statusCode == 401) {
          return UnauthorisedException(
              message: "Session Expired",
              statusCode: error.response!.statusCode);
        } else if (error.response!.statusCode == 404) {
          return ResourceNotFoundException(
              message: "Invalid Url", statusCode: error.response!.statusCode);
        } else if (error.response!.statusCode == 422) {
          final ApiResponse ar = ApiResponse.fromJson(error.response!.data);
          switch (ar.message) {
            case "Invalid Token":
              return UnauthorisedException(
                  message: "Unauthenticated. Please re-login",
                  statusCode: error.response!.statusCode);
          }
        } else if (error.response!.statusCode == 500) {
          debugPrint(error.response!.data["message"].toString());
          return FetchDataException(
              message: "Internal Server Error",
              statusCode: error.response!.statusCode);
        } else if (error.response!.statusCode! >= 500) {
          // debugPrint(error.response!.data["message"].toString());
          return FetchDataException(
              message: "Internal Server Error",
              statusCode: error.response!.statusCode);
        } else {
          return FetchDataException(
              message: error.response!.data["message"],
              error: error,
              statusCode: error.response!.statusCode);
        }
      } else {
        return FetchDataException(
            message: "No Internet Connection", statusCode: 500);
      }
    }
    return AppException(message: error.error.toString());
  }

  void debugError(DioError error) {
    print('++++++++++++++++++++++++++++++++++++++ \n');
    print(error.response);
    print("\n");
    print(error.type);
    print("\n");
    print(error.toString());
    print('\n++++++++++++++++++++++++++++++++++++++\n ');
  }

  void printCase(int value) {
    print('++++++++++++++++++++++++++++++++++++++ \n');
    print(value);
    print('\n++++++++++++++++++++++++++++++++++++++\n ');
  }

  getDeviceId() {}
}
