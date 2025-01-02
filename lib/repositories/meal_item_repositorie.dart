
import '../../core/network/dio_client.dart';
import '../model/meal_item.dart';

class MealItemRepository {
  final DioClient _dioClient;

  MealItemRepository(this._dioClient);

  Future<List<MealItem>> getMealItems() async {
    try {
      final response = await _dioClient.get('/categorys/mealItems');
        if (response.data['status'] == true) {
          final List<dynamic> mealItemsJson = await response.data['mealItems'];
          return mealItemsJson.map((json) => MealItem.fromJson(json as Map<String, dynamic>)).toList();
        }
        throw Exception(response.data['msg'] ?? 'Failed to load meal items');
      } catch (e) {
        throw Exception('Failed to load meal items: $e');
   }
   }
}