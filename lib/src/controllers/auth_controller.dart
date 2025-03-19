import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvc/src/core/errors/exceptions';
import 'package:getx_mvc/src/core/routes/app_routes.dart';
import 'package:getx_mvc/src/core/services/auth_service.dart';
import 'package:getx_mvc/src/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  // Login form fields
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController resetEmailController = TextEditingController();

  // Registration form fields
  final registerFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Observable states
  final isLoading = false.obs;
  final rememberMe = false.obs;
  final isLoggedIn = false.obs;

  // User data
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    resetEmailController.dispose();
    nameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Check if user is already logged in
  Future<void> checkLoginStatus() async {
    isLoggedIn.value = await _authService.isLoggedIn();
    if (isLoggedIn.value) {
      try {
        final userData = await _authService.fetchUserProfile();
        currentUser.value = UserModel.fromJson(userData);
      } catch (e) {
        await _authService.logout();
        isLoggedIn.value = false;
      }
    }
  }

  // Load saved email if remember me was checked
  Future<void> loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('savedEmail');
    if (savedEmail != null && savedEmail.isNotEmpty) {
      emailController.text = savedEmail;
      rememberMe.value = true;
    }
  }

  // Save or clear email based on remember me
  Future<void> _handleRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe.value) {
      await prefs.setString('savedEmail', emailController.text);
    } else {
      await prefs.remove('savedEmail');
    }
  }

  // Login function
  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        final response = await _authService.login(
          emailController.text.trim(),
          passwordController.text,
        );

        // Handle remember me
        await _handleRememberMe();

        // Update user data
        currentUser.value = UserModel.fromJson(response['user']);
        isLoggedIn.value = true;

        // Clear password
        passwordController.clear();

        // Navigate to home
        Get.offAllNamed(Routes.HOME);

      } catch (e) {
        _handleAuthError(e);
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Register function
  Future<void> register() async {
    if (registerFormKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        final response = await _authService.register(
          nameController.text.trim(),
          registerEmailController.text.trim(),
          registerPasswordController.text,
        );

        // Update user data
        currentUser.value = UserModel.fromJson(response['user']);
        isLoggedIn.value = true;

        // Clear form
        nameController.clear();
        registerEmailController.clear();
        registerPasswordController.clear();
        confirmPasswordController.clear();

        // Navigate to home
        Get.offAllNamed(Routes.HOME);

      } catch (e) {
        _handleAuthError(e);
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Password reset function
  Future<void> resetPassword() async {
    try {
      isLoading.value = true;

      await _authService.resetPassword(resetEmailController.text.trim());

      resetEmailController.clear();
      Get.snackbar(
        'Success',
        'Password reset instructions have been sent to your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

    } catch (e) {
      _handleAuthError(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Sign out function
  Future<void> signOut() async {
    try {
      isLoading.value = true;
      await _authService.logout();
    } catch (e) {
      // Continue with logout even if API call fails
    } finally {
      // Reset user data
      currentUser.value = null;
      isLoggedIn.value = false;

      // Navigate to login
      Get.offAllNamed(Routes.LOGIN);
      isLoading.value = false;
    }
  }

  // Handle authentication errors
  void _handleAuthError(dynamic error) {
    String message = 'An error occurred. Please try again.';

    if (error is UnauthorizedException) {
      message = 'Invalid email or password';
    } else if (error is ValidationException) {
      message = error.message;
    } else if (error is ServerException) {
      message = 'Server error. Please try again later.';
    } else if (error is ConnectionException) {
      message = 'No internet connection';
    }

    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  // Form validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != registerPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}