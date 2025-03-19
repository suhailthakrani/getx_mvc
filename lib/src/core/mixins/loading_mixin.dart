import 'package:get/get.dart';

mixin LoadingMixin {
  final RxBool isLoading = false.obs;
  
  void showLoading() => isLoading.value = true;
  void hideLoading() => isLoading.value = false;
}
