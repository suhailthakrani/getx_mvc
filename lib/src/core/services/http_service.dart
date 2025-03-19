import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import '../services/storage_service.dart';

class HttpService extends GetConnect {
  final StorageService _storageService = Get.find<StorageService>();
  
  @override
  void onInit() {
    httpClient.baseUrl = 'https://api.example.com/v1';
    httpClient.timeout = Duration(seconds: 30);
    
    httpClient.addRequestModifier((Request request) async {
      final token = await _storageService.getToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });
    
    httpClient.addResponseModifier((Request request, Response response) {
      return response;
    });
  }
}