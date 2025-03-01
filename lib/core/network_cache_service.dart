import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_storage/get_storage.dart';

class NetworkCacheService {
  final Connectivity _connectivity = Connectivity();
  final GetStorage _storage = GetStorage();

  ///  التحقق من الاتصال بالإنترنت*
  Future<bool> hasInternet() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  /// حفظ البيانات في الكاش**
  void saveToCache(String key, List<dynamic> newData) {
    final cachedData = _storage.read<List>(key);

    if (cachedData != null && jsonEncode(cachedData) == jsonEncode(newData)) {
      return;
    }
    _storage.write(key, newData);
  }

  /// ** تحميل البيانات من الكاش**

  List<dynamic>? loadFromCache(String key) {
    return _storage.read<List>(key);
  }
}
