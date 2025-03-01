import 'dart:async';
import 'package:foodly_ui/model/get_order_detail.dart';
import 'package:get/get.dart';
import '../core/network_cache_service.dart';
import '../model/order_get_model.dart';
import '../repositories/get_order_repositorie.dart';

class GetOrderController extends GetxController {
  final GetOrderRepository _getOrderRepository;
  final RxList<OrderModelGet> getOrders = <OrderModelGet>[].obs;
  final RxList<GetOrderDetails> getOrderDetails = <GetOrderDetails>[].obs;
  final RxBool isLoading = false.obs, isLoadingOrderDetail = false.obs;
  final RxString error = ''.obs, errorOrderDetail = ''.obs;
  final NetworkCacheService _networkCacheService = Get.find<NetworkCacheService>();
  Timer? _updateTimer;

  GetOrderController(this._getOrderRepository);

  @override
  void onInit() {
    super.onInit();

    fetchGetOrders(); // تحميل البيانات من الـ API عند بدء التطبيق
    _startAutoUpdate(); // تحديث دوري للبيانات
  }

  @override
  void onClose() {
    _updateTimer?.cancel();
    super.onClose();
  }

  void _startAutoUpdate() {
    _updateTimer = Timer.periodic(Duration(minutes: 5), (timer) {
      fetchGetOrders();
    });
  }

  Future<void> fetchGetOrders() async {
    try {
      isLoading.value = true;
      error.value = '';
      final cachedData = _networkCacheService.loadFromCache('orders');
      if (cachedData != null) {
        getOrders.assignAll(cachedData.map((e) => OrderModelGet.fromJson(e)).toList());
      }

      /// ** التحقق من الإنترنت وجلب البيانات من API إذا لزم الأمر**
      if (await _networkCacheService.hasInternet()) {
        final items = await _getOrderRepository.getOrder();
        getOrders.assignAll(items);
        _networkCacheService.saveToCache('orders', items.map((e) => e.toJson()).toList());
      }

    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchGetOrderDetail(int orderId) async {
    try {
      isLoadingOrderDetail.value = true;
      errorOrderDetail.value = '';
      final items = await _getOrderRepository.getOrderDetails(orderId);
      getOrderDetails.assignAll(items);
    } catch (e) {
      errorOrderDetail.value = e.toString();
    } finally {
      isLoadingOrderDetail.value = false;
    }
  }

  bool _isDataSame(List<OrderModelGet> newData) {
    if (getOrders.length != newData.length) return false;
    for (int i = 0; i < getOrders.length; i++) {
      if (getOrders[i].id != newData[i].id) {
        return false;
      }
    }
    return true;
  }


}
