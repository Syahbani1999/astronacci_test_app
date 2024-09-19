import 'package:astronacci_test_app/presentation/pages/forgot_password_page.dart';
import 'package:astronacci_test_app/presentation/pages/home_page.dart';
import 'package:astronacci_test_app/presentation/pages/login_page.dart';
import 'package:astronacci_test_app/presentation/pages/register_page.dart';
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
    GoRoute(
      path: _Paths.homepagePath,
      name: Routes.homepageRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: _Paths.registerPath,
      name: Routes.registerRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterPage();
      },
    ),
    GoRoute(
      path: _Paths.forgotPasswordPath,
      name: Routes.forgotPasswordRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const ForgotPasswordPage();
      },
    ),
    GoRoute(
      path: _Paths.loginPath,
      name: Routes.loginRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
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
  static const registerPath = '/register';
  static const forgotPasswordPath = '/forgot-password';
}

abstract class Routes {
  Routes._();
  static const splashscreenRoute = _Paths.splashscreenPath;
  static const homepageRoute = _Paths.homepagePath;
  static const loginRoute = _Paths.loginPath;
  static const registerRoute = _Paths.registerPath;
  static const forgotPasswordRoute = _Paths.forgotPasswordPath;
}
