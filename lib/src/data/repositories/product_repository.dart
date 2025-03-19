import 'package:get/get.dart';
import 'package:getx_mvc/src/data/models/product_model.dart';
import 'package:getx_mvc/src/data/providers/api_provider.dart';

class ProductRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  
  Future<List<Product>> getProducts() async {
    final response = await _apiProvider.get('/products');
    return List<Product>.from(
      response.map((json) => Product.fromJson(json))
    );
  }
  
  Future<Product> getProductById(int id) async {
    final response = await _apiProvider.get('/products/$id');
    return Product.fromJson(response);
  }
}