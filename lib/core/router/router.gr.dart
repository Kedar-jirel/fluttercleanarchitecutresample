// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {_$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    // SplashRoute.name: (routeData) {
    //   return AdaptivePage<dynamic>(routeData: routeData, child: Splash());
    // },

    SignInPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(routeData: routeData, child: SignInPage());
    },
    // ServiceListPageRoute.name: (routeData) {
    //   final args = routeData.argsAs<ServiceListPageRouteArgs>(
    //       orElse: () => const ServiceListPageRouteArgs());
    //   return AdaptivePage<dynamic>(
    //       routeData: routeData,
    //       child: ServiceListPage(
    //           appBarTitle: args.appBarTitle,
    //           callback: args.callback,
    //           dashboardServiceTypeList: args.dashboardServiceTypeList,
    //           dashboardServiceSubTypeList: args.dashboardServiceSubTypeList,
    //           dashboardGridType: args.dashboardGridType));
    // },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashRoute.name, path: '/'),
        RouteConfig(SignInPageRoute.name, path: '/login'),
        // RouteConfig(ServiceListPageRoute.name, path: '/service-list-page'),
  ];
}

/// generated route for
/// [Splash]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [SignInPage]
class SignInPageRoute extends PageRouteInfo<void> {
  const SignInPageRoute() : super(SignInPageRoute.name, path: '/login');

  static const String name = 'SignInPageRoute';
}



// /// generated route for
// /// [ServiceListPage]
// class ServiceListPageRoute extends PageRouteInfo<ServiceListPageRouteArgs> {
//   ServiceListPageRoute(
//       {dynamic appBarTitle,
//       Function? callback,
//       List<ServiceType>? dashboardServiceTypeList,
//       List<ServiceSubType>? dashboardServiceSubTypeList,
//       DashboardGridType? dashboardGridType})
//       : super(ServiceListPageRoute.name,
//             path: '/service-list-page',
//             args: ServiceListPageRouteArgs(
//                 appBarTitle: appBarTitle,
//                 callback: callback,
//                 dashboardServiceTypeList: dashboardServiceTypeList,
//                 dashboardServiceSubTypeList: dashboardServiceSubTypeList,
//                 dashboardGridType: dashboardGridType));
//
//   static const String name = 'ServiceListPageRoute';
// }
//
// class ServiceListPageRouteArgs {
//   const ServiceListPageRouteArgs(
//       {this.appBarTitle,
//       this.callback,
//       this.dashboardServiceTypeList,
//       this.dashboardServiceSubTypeList,
//       this.dashboardGridType});
//
//   final dynamic appBarTitle;
//
//   final Function? callback;
//
//   final List<ServiceType>? dashboardServiceTypeList;
//
//   final List<ServiceSubType>? dashboardServiceSubTypeList;
//
//   final DashboardGridType? dashboardGridType;
//
//   @override
//   String toString() {
//     return 'ServiceListPageRouteArgs{appBarTitle: $appBarTitle, callback: $callback, dashboardServiceTypeList: $dashboardServiceTypeList, dashboardServiceSubTypeList: $dashboardServiceSubTypeList, dashboardGridType: $dashboardGridType}';
//   }
// }

/// generated route for
/// [ServiceSubTypeListingPage]

