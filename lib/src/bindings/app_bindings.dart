import 'package:get/get.dart';
import 'package:getx_mvc/src/controllers/auth_controller.dart';
import 'package:getx_mvc/src/controllers/connectivity_controller.dart';
import '../controllers/theme_controller.dart';
import '../controllers/language_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Global controllers that should persist throughout the app lifecycle
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ThemeController>(ThemeController(), permanent: true);
    Get.put<LanguageController>(LanguageController(), permanent: true);
    Get.put<ConnectivityController>(ConnectivityController(), permanent: true);
  }
}