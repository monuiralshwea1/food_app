import 'package:flutter/material.dart';
import 'package:foodly_ui/controller/category_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../components/cards/medium/restaurant_info_medium_card.dart';
import '../../../components/scalton/medium_card_scalton.dart';
import '../../../constants.dart';
import '../../../demo_data.dart';
import '../../details/details_screen.dart';
import 'package:get/get.dart';

class MediumCardList extends GetView<CategoryController> {
   MediumCardList({super.key});


  @override
  Widget build(BuildContext context) {
    // only for demo
    List data = demoMediumCardData..shuffle();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 254,
          child:Obx((){
            if (controller.isLoading.value) {
              return buildFeaturedPartnersLoadingIndicator();//SizedBox(
              //   height: 10.h,
              //   child: const Center(child: CircularProgressIndicator()),
              // );
            }

            if (controller.error.isNotEmpty) {
              SizedBox(
                height: 10.h,
                child: Center(child: Text(controller.error.value)),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.categorys.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  left: defaultPadding,
                  right: (controller.categorys.length - 1) == index ? defaultPadding : 0,
                ),
                child: RestaurantInfoMediumCard(
                   category: controller.categorys[index],
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailsScreen(),
                      ),
                    );
                  },
                ),
              ),
            );

          })


        ),
      ],
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
