
import 'package:foodly_ui/model/category.dart';

import '../../core/network/dio_client.dart';
import '../model/meal_item.dart';

class CategoryRepository {
  final DioClient _dioClient;

  CategoryRepository(this._dioClient);

  Future<List<Category>> getCategorys() async {
    try {
      final response = await _dioClient.get('/categorys/categorys');
      if (response.data['status'] == true) {
        final List<dynamic> categorysJson = await response.data['categorys'];
        return categorysJson.map((json) => Category.fromJson(json as Map<String, dynamic>)).toList();
      }
      throw Exception(response.data['msg'] ?? 'Failed to load categorys');
    } catch (e) {
      throw Exception('Failed to load categorys: $e');
    }
  }
}