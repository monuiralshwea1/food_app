import 'package:flutter/material.dart';
//import 'package:food_app/route/RoutingPage.dart';
import 'package:foodly_ui/route/RoutingPage.dart';
import 'package:get/get.dart';
import 'binding.dart';
import 'constants.dart';
import 'translation/translation_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'food',
      debugShowCheckedModeBanner: false,
      translations: TranslationService(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('ar'),
      defaultTransition: Transition.fade,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: bodyTextColor),
          bodySmall: TextStyle(color: bodyTextColor),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(defaultPadding),
          hintStyle: TextStyle(color: bodyTextColor),
        ),
      ),
      initialBinding: Binding(),
      initialRoute: ScreenName.splash,
      getPages: RoutingPage().getRout,
    );
  }
}
