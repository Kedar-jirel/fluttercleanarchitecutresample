import 'dart:io';
import 'package:get_it/get_it.dart';
import 'core/app/app_config.dart';
import 'main_common.dart';
import 'package:flutter/material.dart';



//release apk
// flutter build apk --split-per-abi -t lib/main.dart --flavor production

//release appbundle
// flutter build appbundle --split-per-abi -t lib/main.dart --flavor production

// firebase appdistribution:distribute build/app/outputs/flutter-apk/app-armeabi-v7a-dev-release.apk --app 1:1078473061065:android:fdecc994b38330f05a1318 --release-notes "Test" --groups "b-assured-provider-qa-team"


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String flavorName = "prod";
  // configureInjection(Env.production);
  GetIt.I<AppConfig>().initalize(
    appName: 'PROD',
    flavorName: flavorName,
    baseUrl: "baseUrl",
    imageBaseUrl: "imageUrl",
    port: 32203,
    eSewaClientId: "",
    eSewaClientSecret: "",
  );
  HttpOverrides.global = MyHttpOverrides();
  await mainCommon();
}
