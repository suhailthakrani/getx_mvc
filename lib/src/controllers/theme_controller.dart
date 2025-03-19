import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/services/storage_service.dart';

class ThemeController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final RxString _themeMode = 'system'.obs;
  
  String get themeMode => _themeMode.value;
  
  @override
  void onInit() {
    super.onInit();
    _loadThemeMode();
  }
  
  Future<void> _loadThemeMode() async {
    final savedThemeMode = await _storageService.read('theme_mode') ?? 'system';
    _themeMode.value = savedThemeMode;
    _applyThemeMode(savedThemeMode);
  }
  
  Future<void> changeThemeMode(String mode) async {
    _themeMode.value = mode;
    await _storageService.write('theme_mode', mode);
    _applyThemeMode(mode);
  }
  
  void _applyThemeMode(String mode) {
    switch (mode) {
      case 'light':
        Get.changeThemeMode(ThemeMode.light);
        break;
      case 'dark':
        Get.changeThemeMode(ThemeMode.dark);
        break;
      default:
        Get.changeThemeMode(ThemeMode.system);
    }
  }
}

