import 'package:flutter/material.dart';
import 'package:foodly_ui/constants.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../components/scalton/medium_card_scalton.dart';
import '../../controller/get_order_controller.dart';

class OrderDetailsScreen extends GetView<GetOrderController> {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int orderId = Get.arguments['order_id'];
      controller.fetchGetOrderDetail(orderId);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("order_details".tr, style: const TextStyle(color: primaryColor )),
       // centerTitle: true,
       // backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoadingOrderDetail.value) {
          return buildFeaturedPartnersLoadingIndicator();
        }

        if (controller.getOrderDetails.isEmpty) {
          return Center(child: Text("لايوجد تفاصيل طلبات".tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)));
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          itemCount: controller.getOrderDetails.length,
          itemBuilder: (context, index) {
            var item = controller.getOrderDetails[index];

            return Container(
              margin: EdgeInsets.only(bottom: 2.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.w),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(2.h),
                child: Row(
                  children: [
                    /// الصورة
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2.w),
                      child: Image.network(
                        item.image.toString(),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 3.w),

                    /// معلومات الوجبة
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.mealName.toString(),
                            //style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            "${'Price'.tr}: ${item.price}${'YER'} | ${'qty'.tr}: ${item.qty}",
                            style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),

                    /// السعر الكلي
                    Text(
                      "${'Total'.tr}: ${item.total}",
                      style: TextStyle(fontSize: 14.sp, /*fontWeight: FontWeight.bold,*/ color:primaryColor),
                    ),
                  ],
                ),
              ),
            );
          },
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
