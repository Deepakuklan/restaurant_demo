import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/localization/app_translations.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load translations from JSON files
  final translations = await AppTranslations.loadTranslations();
  
  runApp(MyApp(translations: translations));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> translations;
  
  const MyApp({super.key, required this.translations});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Restaurant Demo',
          theme: AppTheme.lightTheme,
          locale: const Locale('es', 'ES'),
          fallbackLocale: const Locale('en', 'US'),
          translationsKeys: translations,
          initialRoute: AppRoutes.login,
          getPages: AppPages.pages,
        );
      },
    );
  }
}
