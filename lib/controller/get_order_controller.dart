import 'package:foodly_ui/model/category.dart';
import 'package:foodly_ui/model/get_order_detail.dart';
import 'package:get/get.dart';

import '../model/order_get_model.dart';
import '../repositories/get_order_repositorie.dart';




class GetOrderController extends GetxController {
  final GetOrderRepository _getOrderRepository;
  final RxList<OrderModelGet> getOrders = <OrderModelGet>[].obs;
  final RxList<GetOrderDetails>getOrderDetails=<GetOrderDetails>[].obs;
  final RxBool isLoading = false.obs,isLoadingOrderDetail=false.obs;
  final RxString error = ''.obs,errorOrderDetail=''.obs;

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

  Future<void> fetchGetOrderDetail(int order_id) async {
    try {

      isLoadingOrderDetail.value = true;
      errorOrderDetail.value = '';
      final items = await _getOrderRepository.getOrderDetails(order_id);
      getOrderDetails.assignAll(items);
    } catch (e) {
      errorOrderDetail.value = e.toString();
    } finally {
      isLoadingOrderDetail.value = false;
    }
  }
}