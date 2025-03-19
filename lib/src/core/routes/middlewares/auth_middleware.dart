import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvc/src/controllers/auth_controller.dart';
import 'package:getx_mvc/src/core/routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    return authController.isLoggedIn.value
        ? null
        : RouteSettings(name: Routes.LOGIN);
  }
}
