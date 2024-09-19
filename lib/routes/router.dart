import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:astronacci_test_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:astronacci_test_app/presentation/pages/edit_profile_page.dart';
import 'package:astronacci_test_app/presentation/pages/forgot_password_page.dart';
import 'package:astronacci_test_app/presentation/pages/home_page.dart';
import 'package:astronacci_test_app/presentation/pages/login_page.dart';
import 'package:astronacci_test_app/presentation/pages/profile_page.dart';
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
        final UserEntity user = state.extra as UserEntity;
        return HomePage(user: user);
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
    GoRoute(
      path: _Paths.profilePath,
      name: Routes.profileRoute,
      builder: (BuildContext context, GoRouterState state) {
        final UserEntity user = state.extra as UserEntity;
        return ProfilePage(user: user);
      },
    ),
    GoRoute(
      path: _Paths.editProfilePath,
      name: Routes.editProfileRoute,
      builder: (BuildContext context, GoRouterState state) {
        final UserEntity user = state.extra as UserEntity;
        return EditProfilePage(user: user);
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
  static const profilePath = '/profile';
  static const editProfilePath = '/edit-profile';
}

abstract class Routes {
  Routes._();
  static const splashscreenRoute = _Paths.splashscreenPath;
  static const homepageRoute = _Paths.homepagePath;
  static const loginRoute = _Paths.loginPath;
  static const registerRoute = _Paths.registerPath;
  static const forgotPasswordRoute = _Paths.forgotPasswordPath;
  static const profileRoute = _Paths.profilePath;
  static const editProfileRoute = _Paths.editProfilePath;
}
