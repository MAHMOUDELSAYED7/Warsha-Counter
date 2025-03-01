import 'package:flutter/material.dart';
import 'package:warsha_counter/core/router/page_transitions.dart';
import 'package:warsha_counter/view/login.dart';
import 'package:warsha_counter/view/register.dart';

import '../../view/splash.dart';
import '../utils/routes.dart';

class AppRouter {
  const AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesManager.initialRoute:
        return PageTransitionManager.fadeTransition(const SplashScreen());
      case RoutesManager.login:
        return PageTransitionManager.fadeTransition(const LoginScreen());
      case RoutesManager.register:
        return PageTransitionManager.fadeTransition(const RegisterScreen());

      default:
        return null;
    }
  }
}
