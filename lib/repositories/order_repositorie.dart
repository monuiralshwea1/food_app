import '../core/network/dio_client.dart';
import '../model/Order.dart';
import '../model/get_order_detail.dart';


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


  Future<double> getDeliveryFee() async {
    try {

      final response = await _dioClient.get('/orders/prce_delivery');

      if (response.data['status'] == true) {
        final fee = double.parse(response.data['price_delivery'].toString());
        return fee;
      }
      throw Exception(response.data['msg'] ?? 'Failed to get delivery fee');
    } catch (e) {
      throw Exception('Failed to get delivery: $e');
      rethrow;
    }
  }


  Future<List<GetOrderDetails>> featchOrderDetails(int order_id) async {
    try {
      final response = await _dioClient.post('/categorys/mealsFromCategory',
        queryParameters:{'category_id':category_id},
      );
      if (response.data['status'] == true) {
        final List<dynamic> mealsJson = await response.data['meals'];
        return mealsJson.map((json) => Meal.fromJson(json as Map<String, dynamic>)).toList();
      }
      throw Exception(response.data['msg'] ?? 'Failed to load meals');
    } catch (e) {
      throw Exception('Failed to load meals: $e');
    }
  }



}