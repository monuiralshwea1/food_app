import 'package:flutter/material.dart';
import 'package:foodly_ui/route/RoutingPage.dart'; // تأكد من صحة المسار
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'binding.dart';
import 'constants.dart';
import 'translation/translation_service.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
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
      },
    );
  }
}
