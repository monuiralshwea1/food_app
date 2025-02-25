import '../core/network/dio_client.dart';
import '../model/order_get_model.dart';
import '../model/get_order_detail.dart';

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


  Future<List<GetOrderDetails>> getOrderDetails(int order_id) async {
    try {
      final response = await _dioClient.post('/orders/getOrderDetails',
        data: {'order_id':order_id}
      );
      if (response.data['status'] == true) {
        final List<dynamic> OrderDetails = await response.data['order_details'];
        return OrderDetails.map((json) => GetOrderDetails.fromJson(json as Map<String, dynamic>)).toList();
      }
      throw Exception(response.data['msg'] ?? 'Failed to load OrderDetails');
    } catch (e) {
      throw Exception('Failed to load OrderDetails: $e');
    }
  }
}