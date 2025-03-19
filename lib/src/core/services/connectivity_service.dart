import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  final RxList<ConnectivityResult> _connectionResults = RxList();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  List<ConnectivityResult> get status => _connectionResults;
  Stream<List<ConnectivityResult>> get statusStream =>
      _connectionResults.stream;
  bool get isConnected =>
      _connectionResults.contains(ConnectivityResult.mobile) ||
      _connectionResults.contains(ConnectivityResult.wifi);

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      Get.log('Connectivity initialization error: $e', isError: true);
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    _connectionResults.value = result;

    bool connectionStatus = _connectionResults.contains(ConnectivityResult.mobile) ||  _connectionResults.contains(ConnectivityResult.wifi);

    if (!connectionStatus) {
      Get.snackbar(
        'No Internet Connection',
        'Please check your network connection',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }
}
