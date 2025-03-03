import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warsha_counter/core/locator/locator.dart';
import 'package:warsha_counter/core/router/page_transitions.dart';
import 'package:warsha_counter/cubit/counter/counter_cubit.dart';
import 'package:warsha_counter/view/login.dart';
import 'package:warsha_counter/view/register.dart';

import '../../cubit/auth_status/auth_status_cubit.dart';
import '../../cubit/login/login_cubit.dart';
import '../../cubit/register/register_cubit.dart';
import '../../view/home.dart';
import '../../view/splash.dart';
import '../utils/routes.dart';

class AppRouter {
  const AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesManager.initialRoute:
        return PageTransitionManager.fadeTransition(
          BlocProvider(
            create: (_) => locator<AuthStatusCubit>(),
            child: const SplashScreen(),
          ),
        );
      case RoutesManager.login:
        return PageTransitionManager.fadeTransition(
          BlocProvider(
            create: (_) => locator<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case RoutesManager.register:
        return PageTransitionManager.materialSlideTransition(
          BlocProvider(
            create: (_) => locator<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );
      case RoutesManager.home:
        return PageTransitionManager.materialSlideTransition(
          BlocProvider(
            create: (_) => locator<CounterCubit>(),
            child: HomeScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
