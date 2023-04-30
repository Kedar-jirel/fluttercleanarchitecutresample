import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'core/app/app_config.dart';
import 'core/router/router.dart';
import 'core/store/session_manager.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  final appConfig = GetIt.I<AppConfig>()..fetchServerConfigSetting();
  GetIt.I.registerSingleton<AppRouter>(AppRouter());
  runApp(
    appConfig.appName != "PROD"
          ? Directionality(
              textDirection: TextDirection.rtl,
              // child: Banner(
              //   location: BannerLocation.topEnd,
              //   color: appConfig.color!,
              //   message: appConfig.flavorName!,
              //   textDirection: TextDirection.rtl,
              child: Phoenix(
                child: MyApp(),
              ),
              // ),
            )
          : Phoenix(
              child: MyApp(),
            ),
  );
}

class MyApp extends StatefulWidget {
  MyApp() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.doubleBounce
      ..maskType = EasyLoadingMaskType.clear
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..userInteractions = false;
  }

  static void setLocale(BuildContext context, Locale locale) {
    log("setting locale ${locale.toString()}");
    _AppState state = context.findAncestorStateOfType<_AppState>()!;
    state.setState(() {
      state.locale = locale;
    });
  }

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  Locale? locale;
  bool localeLoaded = false;

  final AppRouter? appRouter = GetIt.I<AppRouter>();

  @override
  void initState() {
    super.initState();
    this._loadLocale().then((value) {
      setState(() {
        this.localeLoaded = true;
        this.locale = value;
        log("locale is  ${locale.toString()}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.localeLoaded == false) {
      return MaterialApp(
        color: Colors.white,
        home: Container(),
      );
    } else {
      return MaterialApp.router(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.cyan,
            accentColor:  Colors.cyan,
            fontFamily: "Poppins",
            colorScheme: ColorScheme.light(primary:  Colors.cyan,)),
        // localizationsDelegates: [
        //   local.AppLocalizationsDelegate(),
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate
        // ],
        supportedLocales: [
           Locale("EN", ""),
           Locale("NP", "")
        ],
        locale: locale,
        builder: EasyLoading.init(),
        routerDelegate: AutoRouterDelegate(appRouter!),
        routeInformationParser: appRouter!.defaultRouteParser(),
      );
    }
  }

  Future<Locale> _loadLocale() async {
    String languageKey = await SessionManager().getLanguage();
    log("_Load Locale langguage code $languageKey");

    return Locale(languageKey == 'NE' ? "NP" : "EN", "");
  }
}
