import '../core/network/dio_client.dart';
import '../model/Order.dart';


class OrderRepository {
  final DioClient _dioClient;

  OrderRepository(this._dioClient);

  Future<Map<String, dynamic>> placeOrder(OrderModel order) async {

    try {
      final response = await _dioClient.post(
        '/orders/order',
        data: order.toJson(),
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }




}