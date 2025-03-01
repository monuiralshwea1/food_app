import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../core/network_cache_service.dart';
import '../model/category.dart';
import '../repositories/category_repositorie.dart';


class CategoryController extends GetxController {
  final CategoryRepository _categoryRepository;
  final RxList<Category> categorys = <Category>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final NetworkCacheService _networkCacheService = Get.find<NetworkCacheService>();
  Timer? _updateTimer;

  CategoryController(this._categoryRepository);
  @override
  void onInit() {
    super.onInit();

    fetchCategories(); // تحميل البيانات من الـ API عند بدء التطبيق
    _startAutoUpdate(); // تحديث دوري للبيانات
  }

  @override
  void onClose() {
    _updateTimer?.cancel();
    super.onClose();
  }

  void _startAutoUpdate() {
    _updateTimer = Timer.periodic(Duration(minutes: 5), (timer) {
      fetchCategories();
    });
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      error.value = '';


      final cachedData = _networkCacheService.loadFromCache('categories');
      if (cachedData != null) {
        categorys.assignAll(cachedData.map((e) => Category.fromJson(e)).toList());
        isLoading.value = false;
      }

      /// **🔹 التحقق من الإنترنت وجلب البيانات من API إذا لزم الأمر**
      if (await _networkCacheService.hasInternet()) {
         isLoading.value = true;
        final items = await _categoryRepository.getCategorys();
          categorys.assignAll(items);
          _networkCacheService.saveToCache('categories', items.map((e) => e.toJson()).toList());
      }

    }
    catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }



}