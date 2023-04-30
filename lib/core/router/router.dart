import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cleaanarchitecturesample/modules/login/login_page.dart';
import 'package:flutter/material.dart';


part 'router.gr.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  // AutoRoute(page: Splash, initial: true),
  AutoRoute(page: SignInPage),
])
class AppRouter extends _$AppRouter {
}
