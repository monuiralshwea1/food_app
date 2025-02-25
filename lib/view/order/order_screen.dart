import 'package:flutter/material.dart';
import 'package:foodly_ui/route/RoutingPage.dart';
import 'package:get/get.dart';
import '../../components/scalton/medium_card_scalton.dart';
import '../../constants.dart';
import '../../controller/get_order_controller.dart';
import 'components/order_card.dart';
import 'package:get/get.dart';

class OrderScreen extends GetView<GetOrderController>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Your Orders".tr,
        style: const TextStyle(color: primaryColor),),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return buildFeaturedPartnersLoadingIndicator();
        }

        if (controller.getOrders.isEmpty) {
          return const Center(
            child: Text('لا توجد لديك طلبات '),
          );
        }

        return RefreshIndicator(
          onRefresh: ()=>controller.fetchGetOrders(),
          child: ListView.builder(
            padding: const EdgeInsets.all(defaultPadding),
            itemCount: controller.getOrders.length,
            itemBuilder: (context, index) {
              var order = controller.getOrders[index];
              return GestureDetector(
                onTap:()=>Get.toNamed(ScreenName.orderDetailScreen,arguments: {'order_id':order.id}),
                child: OrderCard(
                  orderId: order.id!,
                  status: order.status.toString(),
                  totalPrice: double.parse(order.totalPrice.toString()),
                  dateTime: order.dateTime.toString(),
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
