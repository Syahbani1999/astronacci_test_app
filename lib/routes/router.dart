import 'package:astronacci_test_app/presentation/pages/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: _Paths.splashscreenPath,
      name: Routes.splashscreenRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
  ],
  initialLocation: _Paths.splashscreenPath,
  debugLogDiagnostics: true,
  routerNeglect: true,
);

abstract class _Paths {
  _Paths._();
  static const splashscreenPath = '/';
  static const homepagePath = '/home';
  static const loginPath = '/login';
}

abstract class Routes {
  Routes._();
  static const splashscreenRoute = _Paths.splashscreenPath;
  static const homepageRoute = _Paths.homepagePath;
  static const loginRoute = _Paths.loginPath;
}
