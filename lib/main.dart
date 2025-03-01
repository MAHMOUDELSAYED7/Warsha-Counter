import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warsha_counter/core/utils/routes.dart';

import 'core/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: "My Banking Guide",
            locale: const Locale('ar'),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: RoutesManager.initialRoute,
            theme: ThemeData(
              fontFamily: "Amiri"
            ),
            builder: (context, child) {
              final mediaQueryData = MediaQuery.of(context);
              final scaledMediaQueryData = mediaQueryData.copyWith(
                textScaler: TextScaler.noScaling,
              );
              return MediaQuery(
                data: scaledMediaQueryData,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: child!,
                ),
              );
            },
          );
        });
  }
}
