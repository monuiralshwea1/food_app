import 'package:foodly_ui/model/category.dart';
import 'package:get/get.dart';

import '../model/order_get_model.dart';
import '../repositories/get_order_repositorie.dart';




class GetOrderController extends GetxController {
  final GetOrderRepository _getOrderRepository;
  final RxList<OrderModelGet> getOrders = <OrderModelGet>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  GetOrderController(this._getOrderRepository);

  @override
  void onInit() {
    super.onInit();
    fetchGetOrders();
  }

  Future<void> fetchGetOrders() async {
    try {

      isLoading.value = true;
      error.value = '';
      final items = await _getOrderRepository.getOrder();
      getOrders.assignAll(items);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}