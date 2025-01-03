import 'package:flutter/material.dart';

import '../../components/app_drawer.dart';
import '../../components/cards/big/big_card_image_slide.dart';
import '../../components/cards/big/restaurant_info_big_card.dart';
import '../../components/section_title.dart';
import '../../constants.dart';
import '../../demo_data.dart';
import '../../route/RoutingPage.dart';
import 'components/meal_item_list.dart';
import 'components/medium_card_list.dart';
import 'package:get/get.dart';

import 'components/promotion_banner.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: const SizedBox(),
        title:  Column(
          children: [
            Text(
              "Valley Restaurants".tr,
              style: const TextStyle(color: Colors.green),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: BigCardImageSlide(images: demoBigImages),
              ),
              const SizedBox(height: defaultPadding * 2),
              const SectionTitle(
                title: "Featured Partners",
                //press: () =>    Get.toNamed(ScreenName.featuredScreen),
              ),
              const SizedBox(height: defaultPadding),
               MediumCardList(),
              const SizedBox(height: 20),
              // Banner
              //const PromotionBanner(),
              const SectionTitle(

                title: "Best Pick",
             //   press: () =>    Get.toNamed(ScreenName.featuredScreen),
              ),
              const SizedBox(height: 16),
               const MealItemList(),
              const SizedBox(height: 20),
             // SectionTitle(title: "All Restaurants", press: () {}),
              const SizedBox(height: 16),

              // Demo list of Big Cards
              ...List.generate(
                // For demo we use 4 items
                3,
                (index) => Padding(
                  padding: const EdgeInsets.fromLTRB(
                      defaultPadding, 0, defaultPadding, defaultPadding),
                  child: RestaurantInfoBigCard(
                    // Images are List<String>
                    images: demoBigImages..shuffle(),
                    name: "McDonald's",
                    rating: 4.3,
                    numOfRating: 200,
                    deliveryTime: 25,
                    foodType: const ["Chinese", "American", "Deshi food"],
                    press: () =>    Get.toNamed(ScreenName.detailsScreen),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
