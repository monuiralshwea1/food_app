import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/scalton/medium_card_scalton.dart';
import '../../constants.dart';
import '../../controller/meal_iem_controller.dart';
import '../addToOrder/add_to_order_screen.dart';
import 'components/meal_list_item.dart';

class MealScreen extends GetView<MealItemController> {
  const MealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryId = Get.arguments['category_id'];
      controller.fetchMealsFromCategory(categoryId);
    });
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.05),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  size: 18, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          "meals".tr,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.05),
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.black87),
                onPressed: () {
                  // Implement search functionality
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: defaultPadding),
            // Meals List
            Expanded(
              child: Obx(() {
                if (controller.isloadingMealCategory.value) {
                  return _buildLoadingIndicator();
                }

                if (controller.erroMealCategory.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,
                            size: 48, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          controller.erroMealCategory.value,
                          style: TextStyle(color: Colors.grey[600]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                if (controller.meals.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.restaurant_menu,
                            size: 48, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          "No meals available",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(defaultPadding),
                  itemCount: controller.meals.length,
                  itemBuilder: (context, index) {
                    final meal = controller.meals[index];
                    return MealListItem(
                      title: meal.name ?? '',
                      description: meal.description,
                      image: meal.image,
                      price: meal.price ?? 0.0,
                      press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddToOrderScrreen(),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return ListView.builder(
      padding: const EdgeInsets.all(defaultPadding),
      itemCount: 5,
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(bottom: defaultPadding),
        child: MediumCardScalton(),
      ),
    );
  }
}
