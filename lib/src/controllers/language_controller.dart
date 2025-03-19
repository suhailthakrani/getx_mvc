import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/services/storage_service.dart';

class LanguageController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final RxString currentLanguage = 'en_US'.obs;
  
  final List<Map<String, dynamic>> languages = [
    {'name': 'English', 'locale': 'en_US'},
    {'name': 'Español', 'locale': 'es_ES'},
  ];
  
  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
  }
  
  Future<void> _loadLanguage() async {
    final savedLanguage = await _storageService.read('language');
    if (savedLanguage != null) {
      currentLanguage.value = savedLanguage;
      updateLocale(savedLanguage);
    }
  }
  
  void updateLocale(String languageCode) {
    final locale = Locale(languageCode.split('_')[0], languageCode.split('_')[1]);
    Get.updateLocale(locale);
    currentLanguage.value = languageCode;
    _storageService.write('language', languageCode);
  }
}
