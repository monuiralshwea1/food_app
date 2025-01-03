import 'package:get/get.dart';

import '../model/meal_item.dart';
import '../repositories/meal_item_repositorie.dart';


class MealItemController extends GetxController {
  final MealItemRepository _mealItemRepository;
  final RxList<MealItem> mealItems = <MealItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  MealItemController(this._mealItemRepository);

  @override
  void onInit() {
    super.onInit();
    fetchMealItems();
  }

  Future<void> fetchMealItems() async {
    try {
      isLoading.value = true;
      error.value = '';
      final items = await _mealItemRepository.getMealItems();
      mealItems.assignAll(items);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}