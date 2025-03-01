import 'package:flutter/material.dart';
import 'package:warsha_counter/core/router/page_transitions.dart';

import '../../view/splash.dart';
import '../utils/routes.dart';

class AppRouter {
  const AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesManager.initialRoute:
        return PageTransitionManager.fadeTransition(const SplashScreen());

      default:
        return null;
    }
  }
}
