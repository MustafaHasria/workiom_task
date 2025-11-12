import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_task/core/constant/app_theme.dart';
import 'package:workiom_task/core/di/app_dependencies.dart';
import 'package:workiom_task/core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //? Initialize EasyLocalization with English only
  await EasyLocalization.ensureInitialized();

  //? Initialize dependencies
  AppDependencies.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'android/assets/translation',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //? Initialize ScreenUtil with design dimensions
    return ScreenUtilInit(
      designSize: const Size(375, 829),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Workiom',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: appTheme(context),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: child!,
            );
          },
          routerConfig: appRouter,
        );
      },
    );
  }
}
