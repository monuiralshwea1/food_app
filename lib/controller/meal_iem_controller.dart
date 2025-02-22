import 'package:foodly_ui/model/meal.dart';
import 'package:get/get.dart';

import '../model/meal_item.dart';
import '../repositories/meal_item_repositorie.dart';

class MealItemController extends GetxController {
  final MealItemRepository _mealItemRepository;
  final RxList<MealItem> mealItems = <MealItem>[].obs;
  final RxList<Meal> meals = <Meal>[].obs;
  final RxBool isLoading = false.obs, islodingMeal = false.obs,isloadingMealCategory=false.obs;
  final RxString error = ''.obs, erroMeals = ''.obs,erroMealCategory=''.obs;
  var filteredMeals = <Meal>[].obs;
  var searchQuery = ''.obs;
  MealItemController(this._mealItemRepository);

  @override
  void onInit() {
    super.onInit();
    fetchMealsFromItem(0);
    fetchMealItems();
  }

  Future<void> fetchMealItems() async {
    try {
      isLoading.value = true;
      error.value = '';
      final items = await _mealItemRepository.getMealItems();
      mealItems.assignAll(items);
      mealItems.insert(0, MealItem(id: 0, name: 'All'.tr));
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
      final items = await _mealItemRepository.getMeaFromMealItem(meal_item_id);
      meals.assignAll(items);
    } catch (e) {
      erroMeals.value = e.toString();
    } finally {
      islodingMeal.value = false;
    }
  }

  Future<void> fetchMealsFromCategory(int category_id) async {
    try {
      meals.clear();
      isloadingMealCategory.value = true;
      erroMealCategory.value = '';
      final items = await _mealItemRepository.getMeaFromCategory(category_id);
      meals.assignAll(items);
    } catch (e) {
      erroMealCategory.value = e.toString();
    } finally {
      isloadingMealCategory.value = false;
    }
  }

  void searchMeals(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredMeals.assignAll(meals);
    } else {
      filteredMeals.assignAll(
        meals.where((meal) => meal.name.toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
  }



}
