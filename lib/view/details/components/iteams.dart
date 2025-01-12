import 'package:flutter/material.dart';
import 'package:foodly_ui/binding.dart';
import 'package:foodly_ui/model/meal.dart';
import 'package:get/get.dart';
import '../../../components/cards/iteam_card.dart';
import '../../../constants.dart';
import '../../addToOrder/add_to_order_screen.dart';

class Items extends StatelessWidget {
   List<Meal>meals;
   Items({
    super.key,
    required this.meals
  });


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),//const NeverScrollableScrollPhysics(),
      itemCount: meals.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        child: ItemCard(
          title: meals[index].name,
          description:meals[index].description,
          image: meals[index].image,
        //  foodType: demoData[index]['foodType'],
          price: meals[index].price,
          //priceRange: demoData[index]["priceRange"],
          press: () => Get.to(AddToOrderScreen(meal: meals[index]),
          ),

        ),
      ),
    );
  }

}

