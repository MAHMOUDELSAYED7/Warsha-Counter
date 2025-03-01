import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warsha_counter/core/utils/extensions/extensions.dart';
import 'package:warsha_counter/core/utils/routes.dart';

import '../cubit/auth_status/auth_status_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  void _redirect() {
    Future<void>.delayed(
      const Duration(seconds: 3),
      () => context.cubit<AuthStatusCubit>().checkAuthStatus(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthStatusCubit, AuthStatusState>(
        listener: (context, state) {
          if (state is AuthStatusSignedIn) {
            context.popAndPushNamed(RoutesManager.home);
          } else if (state is AuthStatusSignedOut) {
            context.popAndPushNamed(RoutesManager.login);
          }
        },
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              FadeIn(
                duration: Duration(milliseconds: 900),
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: context.width / 4,
                  child: BounceIn(
                    duration: Duration(milliseconds: 900),
                    child: Text(
                      "Counter\nألورشه",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge
                          ?.copyWith(fontSize: 24.sp),
                    ).center(),
                  ),
                ),
              ),
              Positioned(
                  bottom: 30,
                  child: FadeInUp(
                    duration: Duration(microseconds: 500),
                    child: Text(
                      "أعتبرها سبلاش جامده",
                      style: context.textTheme.bodyMedium,
                    ),
                  ))
            ],
          ).withSize(width: double.infinity, height: double.infinity),
        ));
  }
}
