import 'package:flutter/material.dart';
import 'package:foodly_ui/controller/meal_iem_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../components/cards/meal_item_card.dart';
import '../../../components/scalton/medium_card_scalton.dart';
import '../../../constants.dart';



class MealItemList extends GetView<MealItemController> {
  const MealItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
         return buildFeaturedPartnersLoadingIndicator();//SizedBox(
        //   height: 10.h,
        //   child: const Center(child: CircularProgressIndicator()),
        // );
      }

      if (controller.error.isNotEmpty) {
         return SizedBox(
          height: 10.h,
          child: Center(child: Text(controller.error.value)),
        );
      }

      return SizedBox(
        height: 10.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.mealItems.length,
          itemBuilder: (context, index) {
            final mealItem = controller.mealItems[index];
            return GestureDetector(child: MealItemCard(mealItem: mealItem,),onTap:(){
              controller.fetchMealsFromItem(mealItem.id);
            },);
          },
        ),
      );
    });
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

