import 'package:foodly_ui/model/meal.dart';
import 'package:get/get.dart';

import '../model/meal_item.dart';
import '../repositories/meal_item_repositorie.dart';


class MealItemController extends GetxController {
  final MealItemRepository _mealItemRepository;
  final RxList<MealItem> mealItems = <MealItem>[].obs;
  final RxList<Meal> meals = <Meal>[].obs;
  final RxBool isLoading = false.obs,islodingMeal=false.obs;
  final RxString error = ''.obs,erroMeals=''.obs;

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

    Future<void> fetchMealsFromItem(int meal_item_id) async {
      try {
        meals.clear();
        islodingMeal.value = true;
        erroMeals.value = '';
        final items = await _mealItemRepository.getMeaFromMealItem(
            meal_item_id);
        meals.assignAll(items);
        print(meals);
      } catch (e) {
        erroMeals.value = e.toString();
      } finally {
        islodingMeal.value = false;
      }







  }







}