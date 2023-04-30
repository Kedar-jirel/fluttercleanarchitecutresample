import 'package:auto_route/auto_route.dart';
import 'package:cleaanarchitecturesample/core/router/router.dart';

import '../store/session_manager.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final bool isLoggedIn = await SessionManager().isAuthenticated();
    if (isLoggedIn) {
      resolver.next(true);
    } else {
      router.push(SignInPageRoute());
    }
  }
}
