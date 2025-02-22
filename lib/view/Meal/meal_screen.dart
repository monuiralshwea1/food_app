import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/scalton/medium_card_scalton.dart';
import '../../constants.dart';
import '../../controller/meal_iem_controller.dart';
import '../../controller/cart_controller.dart';
import '../../route/RoutingPage.dart';
import '../addToOrder/add_to_order_screen.dart';
import '../cart/cart_screen.dart';
import 'components/meal_list_item.dart';

class MealScreen extends GetView<MealItemController> {
  const MealScreen({Key? key}) : super(key: key);

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
              onPressed: (){
               // controller.fetchMealsFromItem(0);
                return Get.back();
                },
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
                icon: const Icon(Icons.shopping_cart, color: Colors.black87),
                onPressed: () => Get.toNamed(ScreenName.cartScreen),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.05),
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.black87),
                onPressed: () {

                },
              ),
            ),
          ),

        ],
      ),
      body: Obx(
        () {
          if (controller.isloadingMealCategory.value) {
            return buildFeaturedPartnersLoadingIndicator();
          }

          if (controller.meals.isEmpty) {
            return const Center(
              child: Text('لا توجد وجبات في هذا القسم'),
            );
          }

          return RefreshIndicator(
            onRefresh:()=>controller.fetchMealsFromCategory( Get.arguments['category_id']),
            child: GridView.builder(
              padding: const EdgeInsets.all(defaultPadding),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.7,
                mainAxisSpacing: defaultPadding,
                crossAxisSpacing: defaultPadding,
              ),
              itemCount: controller.meals.length,
              itemBuilder: (context, index) {
                final meal = controller.meals[index];
                return MealListItem(
                  meal: meal,
                  press: () => Get.to(
                    () => AddToOrderScreen(meal: meal),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
  SingleChildScrollView buildFeaturedPartnersLoadingIndicator() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          2,
              (index) => const Padding(
            padding: EdgeInsets.only(left: defaultPadding),
            child: MediumCardScalton(),
          ),
        ),
      ),
    );
  }
}
