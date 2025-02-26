import 'package:flutter/material.dart';
import 'package:foodly_ui/controller/meal_iem_controller.dart';
import 'package:foodly_ui/model/meal.dart';
import 'package:foodly_ui/view/home/components/meal_card.dart';
import 'package:foodly_ui/view/home/components/offer_list.dart';
import 'package:sizer/sizer.dart';
import '../../components/app_drawer.dart';
import '../../components/cards/big/big_card_image_slide.dart';
import '../../components/cards/big/restaurant_info_big_card.dart';
import '../../components/scalton/medium_card_scalton.dart';
import '../../components/section_title.dart';
import '../../constants.dart';
import '../../demo_data.dart';
import '../../route/RoutingPage.dart';
import '../details/components/iteams.dart';
import 'components/meal_item_list.dart';
import 'components/medium_card_list.dart';
import 'package:get/get.dart';

import 'components/promotion_banner.dart';

class HomeScreen extends GetView<MealItemController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "Valley Restaurants".tr,
              style: const TextStyle(color: primaryColor),
            )
          ],
        ),
          actions: [
      Padding(
      padding:  EdgeInsets.all(1.0.h),
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.05),
        child: IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.black87),
          onPressed: () =>  Get.toNamed(ScreenName.cartScreen),
        ),
      ),
    ),
    ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height:3.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: BigCardImageSlide(images: demoBigImages),
              ),
               SizedBox(height:4.h),
              SectionTitle(title: "عروض خاصة"),
              OfferList(),
               SizedBox(height: 1.h),
              SectionTitle(
                title: "category".tr,
                //press: () =>    Get.toNamed(ScreenName.featuredScreen),
              ),
              const SizedBox(height: defaultPadding),
              MediumCardList(),
               SizedBox(height: 1.h),
              // Banner
              //const PromotionBanner(),
              SectionTitle(
                title: 'meal categories'.tr,
                //   press: () =>    Get.toNamed(ScreenName.featuredScreen),
              ),
              const MealItemList(),
               SizedBox(height: 2.h),
              // SectionTitle(title: "All Restaurants", press: () {}),
             // const SizedBox(height: 16),

              // Demo list of Big Cards
              Obx(() {
                if (controller.islodingMeal.value) {
                  return buildFeaturedPartnersLoadingIndicator();
                }
                if (controller.meals.isEmpty) {
                    return const Center(child: Text("لا توجد ,وجبات متاحة"));
                }

                if (controller.erroMeals.isNotEmpty) {
                  return Center(child: Text(controller.erroMeals.value));
                }



                return SizedBox(
                 // height: 400.h,
                  width: 200.w,
                  child:  Items(meals: controller.meals,),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   physics: const ClampingScrollPhysics(),
                  //   itemCount: controller.meals.length,
                  //   itemBuilder: (context, index) {
                  //     Meal meal = controller.meals[index];
                  //
                  //     return Padding(
                  //       padding: const EdgeInsets.fromLTRB(
                  //           defaultPadding, 0, defaultPadding, defaultPadding),
                  //       child: MealCard(
                  //         meal: meal,
                  //         onPressed: () {},
                  //       ),
                  //     );
                  //   },
                  // ),
                );
              }),
            ],
          ),
        ),
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
