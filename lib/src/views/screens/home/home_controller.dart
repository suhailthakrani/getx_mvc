import 'package:get/get.dart';
import 'package:getx_mvc/src/controllers/base_controller.dart';
import 'package:getx_mvc/src/data/models/product_model.dart';
import 'package:getx_mvc/src/data/repositories/product_repository.dart';

class HomeController extends BaseController {
  final ProductRepository _productRepository = Get.find<ProductRepository>();
  final RxList<Product> products = <Product>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }
  
  Future<void> fetchProducts() async {
    showLoading();
    try {
      final result = await _productRepository.getProducts();
      products.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products');
    } finally {
      hideLoading();
    }
  }
  
  void navigateToProductDetails(Product product) {
    Get.toNamed('/product-details', arguments: product);
  }
}