import '../core/network/dio_client.dart';
import '../model/order_get_model.dart';

class GetOrderRepository {
  final DioClient _dioClient;

  GetOrderRepository(this._dioClient);


  Future<List<OrderModelGet>> getOrder() async {
    try {
      final response = await _dioClient.get('/orders/getOrders');
      if (response.data['status'] == true) {
        final List<dynamic> getOrdersJson = await response.data['orders'];
        return getOrdersJson.map((json) =>
            OrderModelGet.fromJson(json as Map<String, dynamic>)).toList();
      }
      throw Exception(response.data['msg'] ?? 'Failed to load orders');
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }
}