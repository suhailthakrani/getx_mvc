import 'package:get/get.dart';
import 'package:getx_mvc/src/core/errors/exceptions';
import 'package:getx_mvc/src/core/services/http_service.dart';

class ApiProvider {
  final HttpService _httpService = Get.find<HttpService>();
  final String _baseUrl = 'https://api.example.com/v1';
  
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _httpService.get('$_baseUrl$endpoint');
      return _handleResponse(response);
    } catch (e) {
      throw AppException('Failed to fetch data');
    }
  }
  
  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      final response = await _httpService.post('$_baseUrl$endpoint', data);
      return _handleResponse(response);
    } catch (e) {
      throw AppException('Failed to post data');
    }
  }
  
  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.body;
      case 400:
        throw BadRequestException(response.bodyString ?? '{}');
      case 401:
      case 403:
        throw UnauthorizedException(response.bodyString ??'{}');
      case 500:
      default:
        throw ServerException('Server error occurred');
    }
  }
}
