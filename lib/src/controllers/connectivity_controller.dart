import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '../core/services/connectivity_service.dart';

class ConnectivityController extends GetxController {
  final ConnectivityService _connectivityService = Get.find<ConnectivityService>();
  final RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Set initial connection status
    isConnected.value = _connectivityService.isConnected;
    
    // Listen to connectivity changes
    _connectivityService.statusStream.listen((status) {
      isConnected.value = status.contains(ConnectivityResult.mobile) || status.contains(ConnectivityResult.mobile);
    });
  }
  
  // Method to check connectivity before performing critical operations
  Future<bool> checkConnectivity() async {
    if (!isConnected.value) {
      Get.snackbar(
        'Offline',
        'This operation requires an internet connection',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return true;
  }
}