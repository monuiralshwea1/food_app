import 'package:flutter/material.dart';
import 'package:foodly_ui/controller/offer_controller.dart';
import 'package:foodly_ui/model/meal.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../components/scalton/medium_card_scalton.dart';
import '../../../constants.dart';
import '../../../model/Offer.dart';
import '../../addToOrder/add_to_order_screen.dart';

class OfferList extends GetView<OfferController> {
  const OfferList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Obx(() {
        if (controller.offers.isEmpty) {
          return const Center(child: Text("لا توجد عروض متاحة"));
        }
        if (controller.isLoading.value) {
          return buildFeaturedPartnersLoadingIndicator();
        }

        return  SizedBox(
          height:30.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.offers.length,
            itemBuilder: (context, index) {
              Offer offer = controller.offers[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(offer.image, width: 280, height: 80, fit: BoxFit.cover),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                offer.mealName,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "خصم ${offer.discountPercentage}%",
                                style: const TextStyle(fontSize: 14, color: Colors.red),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${offer.originalPrice} ج.م",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${offer.discountedPrice} ج.م",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                                  ),
                                ],
                              ),
                              // Text(
                              //   "من ${DateFormat('yyyy-MM-dd').format(promotion.startDate)} إلى ${DateFormat('yyyy-MM-dd').format(promotion.endDate)}",
                              //   style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
                              // ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(
                                          () => AddToOrderScreen(meal: Meal(id:offer.meal_id,name:offer.mealName,image: offer.image,price: offer.discountedPrice )),
                                    );
                                  },
                                  child: const Text("إضافة إلى السلة"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
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
