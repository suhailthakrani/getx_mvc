import 'package:get/get.dart';
import 'package:getx_mvc/src/core/services/analytics_service.dart';
import 'package:getx_mvc/src/core/services/auth_service.dart';
import 'package:getx_mvc/src/core/services/connectivity_service.dart';
import '../services/storage_service.dart';
import '../services/http_service.dart';
import '../../data/providers/api_provider.dart';
import '../../data/repositories/product_repository.dart';

Future<void> initServiceLocator() async {
  // Initialize services
  final storageService = await StorageService.init();
  Get.put<StorageService>(storageService, permanent: true);
  
  // Core services
  Get.put<HttpService>(HttpService(), permanent: true);
  Get.put<AuthService>(AuthService(), permanent: true);
  
  // API providers
  Get.put<ApiProvider>(ApiProvider(), permanent: true);
  
  // Repositories
  // Get.put<UserRepository>(UserRepository(), permanent: true);
  Get.put<ProductRepository>(ProductRepository(), permanent: true);
  
  // Any other services or utilities
  Get.put<ConnectivityService>(ConnectivityService(), permanent: true);
  Get.put<AnalyticsService>(AnalyticsService(), permanent: true);
}