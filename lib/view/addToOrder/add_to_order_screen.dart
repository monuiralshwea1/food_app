import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../controller/cart_controller.dart';
import '../../model/meal.dart';
import 'components/info.dart';

class AddToOrderScreen extends GetView<CartController> {
  final Meal meal;

  const AddToOrderScreen({
    Key? key,
    required this.meal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxInt quantity = 1.obs;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Info(meal: meal),
                  const SizedBox(height: defaultPadding),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (quantity.value > 1) {
                              quantity.value--;
                            }
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Obx(() => Text(
                              quantity.value.toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            )),
                        IconButton(
                          onPressed: () => quantity.value++,
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(defaultPadding),
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
                    onPressed: () {
                      controller.addToCart(meal, quantity.value);
                      Get.snackbar(
                        'تم',
                        'تمت إضافة ${meal.name} إلى السلة',
                        backgroundColor: const Color(0xFF4CAF50),
                        colorText: Colors.white,
                      );
                     // Get.back();

                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(
                      'إضافة إلى السلة - ${(meal.price * quantity.value).toStringAsFixed(2)} ر.س',
                      style: const TextStyle(fontSize: 18),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
