import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvc/src/bindings/app_bindings.dart';
import 'package:getx_mvc/src/core/routes/app_pages.dart';
import 'package:getx_mvc/src/core/theme/app_theme.dart';
import 'package:getx_mvc/src/translations/app_translations.dart';
import 'package:getx_mvc/src/views/widgets/not_found_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Application',
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // or ThemeMode.light or ThemeMode.dark
      
      // Localization
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      
      // Routing
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const NotFoundView(),
      ),
      
      // Bindings
      initialBinding: AppBindings(),
      
      // Behavior
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
      popGesture: true, // Enables swipe to go back
      smartManagement: SmartManagement.full, // Memory management
      
      // Error handling
      onInit: () {
        // Global error handling
        FlutterError.onError = (FlutterErrorDetails details) {
          FlutterError.presentError(details);
          // You could also report to a service like Sentry or Firebase Crashlytics
        };
      },
      
      // Logging
      enableLog: true,
      logWriterCallback: (String text, {bool isError = false}) {
        // Custom log handling
        if (isError) {
          debugPrint('ERROR: $text');
        } else {
          debugPrint('LOG: $text');
        }
      },
    );
  }
}
