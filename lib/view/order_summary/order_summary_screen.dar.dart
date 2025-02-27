import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../constants.dart';

class OrderSummaryScreen extends GetView<CartController> {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ملخص الطلب'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(
            child: Text('السلة فارغة'),
          );
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Items Section
                    const Text(
                      'تفاصيل الطلب',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = controller.cartItems[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.image,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 180,
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.restaurant,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    );
                                  }
                              ),
                            ),
                            title: Text(item.mealName),
                            subtitle: Text('الكمية: ${item.quantity}'),
                            trailing: Text(
                              '${(item.price * item.quantity).toStringAsFixed(2)} YER',
                              style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const Divider(height: 32),

                    // Price Summary Section
                    const Text(
                      'ملخص السعر',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Subtotal
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('المجموع الفرعي'),
                        Text('${controller.total.toStringAsFixed(2)} YER'),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Delivery Fee
                    FutureBuilder<double>(
                      future: controller.getDeliveryFee(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return Text(
                            'خطأ في حساب رسوم التوصيل: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          );
                        }

                        final deliveryFee = snapshot.data ?? 0.0;
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('رسوم التوصيل'),
                                Text('$deliveryFee YER'),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'الإجمالي',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${(controller.total.value + deliveryFee).toStringAsFixed(2)} YER',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Action Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: SafeArea(
                child: Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.placeOrder(),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'تأكيد الطلب',
                    style: TextStyle(fontSize: 18),
                  ),
                )),
              ),
            ),
          ],
        );
      }),
    );
  }
}