
import 'package:get/get.dart';
import 'package:getx_mvc/src/core/routes/middlewares/auth_middleware.dart';
import 'package:getx_mvc/src/views/screens/home/home_binding.dart';
import 'package:getx_mvc/src/views/screens/home/home_view.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    // GetPage(
    //   name: Routes.SPLASH,
    //   page: () => SplashView(),
    //   binding: SplashBinding(),
    // ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    // GetPage(
    //   name: Routes.LOGIN,
    //   page: () => LoginView(),
    //   binding: AuthBinding(),
    // ),
    // GetPage(
    //   name: Routes.REGISTER,
    //   page: () => RegisterView(),
    //   binding: AuthBinding(),
    // ),
    // GetPage(
    //   name: Routes.PRODUCT_DETAILS,
    //   page: () => ProductDetailsView(),
    //   binding: ProductBinding(),
    //   transition: Transition.rightToLeft,
    // ),
  ];
}