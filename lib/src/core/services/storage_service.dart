import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _box;
  
  StorageService._() : _box = GetStorage();
  
  static Future<StorageService> init() async {
    await GetStorage.init();
    return StorageService._();
  }
  
  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }
  
  Future<dynamic> read(String key) async {
    return _box.read(key);
  }
  
  Future<void> remove(String key) async {
    await _box.remove(key);
  }
  
  Future<void> clear() async {
    await _box.erase();
  }
  
  Future<String?> getToken() async {
    return await read('auth_token');
  }
  
  Future<void> saveToken(String token) async {
    await write('auth_token', token);
  }
  
  Future<void> deleteToken() async {
    await remove('auth_token');
  }
}
