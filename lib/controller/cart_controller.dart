import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../core/storge/storage_service.dart';
import '../model/Order.dart';
import '../model/cart_item.dart';
import '../model/meal.dart';
import '../core/network/dio_client.dart';
import '../repositories/order_repositorie.dart';
import '../route/RoutingPage.dart';

class CartController extends GetxController {
  static const String CART_STORAGE_KEY = 'cart_items';
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  final RxDouble total = 0.0.obs;
  final RxBool isLoading = false.obs;
  final storage = GetStorage();
  final OrderRepository orderRepository;
  final RxDouble deliveryFee = 0.0.obs;
  final RxBool isLoadingDeliveryFee = false.obs,proceedToSummaryLoading=false.obs;

  CartController(this.orderRepository);

  @override
  void onInit() {
    super.onInit();
    loadCartFromStorage();
  }

  void loadCartFromStorage() {
    try {
      final cartData = storage.read<List>(CART_STORAGE_KEY);
      if (cartData != null) {
        cartItems.value = cartData.map((item) => CartItem.fromJson(Map<String, dynamic>.from(item))).toList();
        calculateTotal();
      }
    } catch (e) {
      print('Error loading cart: $e');
    }
  }

  Future<void> saveCartToStorage() async {
    try {
      final cartData = cartItems.map((item) => item.toJson()).toList();
      await storage.write(CART_STORAGE_KEY, cartData);
    } catch (e) {
      print('Error saving cart: $e');
    }
  }

  Future<double> getDeliveryFee() async {
    try {
      isLoadingDeliveryFee.value = true;

        final fee = await orderRepository.getDeliveryFee();
        deliveryFee.value = fee;
        return fee;
      }
     catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل في جلب سعر التوصيل',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      rethrow;
    } finally {
      isLoadingDeliveryFee.value = false;
    }
  }

  void addToCart(Meal meal, int quantity) {
    try {
      final existingIndex = cartItems.indexWhere((item) => item.meal_id == meal.id);
      if (existingIndex >= 0) {
        cartItems[existingIndex].quantity += quantity;
        cartItems.refresh();
      } else {
        cartItems.add(
          CartItem(
            meal_id: meal.id!,
            mealName: meal.name,
            price: meal.price,
            quantity: quantity,
            image: meal.image ?? '',
          ),
        );
      }
      calculateTotal();
      saveCartToStorage();
      Get.snackbar(
        'تم',
        'تمت إضافة ${meal.name} إلى السلة',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء إضافة العنصر إلى السلة',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void removeFromCart(int mealId) {
    try {
      cartItems.removeWhere((item) => item.meal_id == mealId);
      calculateTotal();
      saveCartToStorage();
      Get.snackbar(
        'تم',
        'تم حذف العنصر من السلة',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء حذف العنصر من السلة',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void updateQuantity(int mealId, int quantity) {
    try {
      final index = cartItems.indexWhere((item) => item.meal_id == mealId);
      if (index != -1) {
        if (quantity > 0) {
          cartItems[index].quantity = quantity;
          cartItems.refresh();
          calculateTotal();
          saveCartToStorage();
        }
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء تحديث الكمية',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void calculateTotal() {
    total.value = cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void clearCart() {
    cartItems.clear();
    total.value = 0;
    deliveryFee.value = 0;
    saveCartToStorage();
  }

  void proceedToSummary() async {
    proceedToSummaryLoading.value=true;
    if (cartItems.isEmpty) {
      Get.snackbar(
        'تنبيه',
        'السلة فارغة',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      proceedToSummaryLoading.value=false;
      return;
    }

    try {
      // جلب سعر التوصيل قبل الانتقال إلى شاشة الملخص
      await getDeliveryFee();
      proceedToSummaryLoading.value=false;
      Get.toNamed(ScreenName.orderSummary);

    } catch (e) {
      proceedToSummaryLoading.value=false;
      Get.toNamed(ScreenName.orderSummary);
      // Get.snackbar(
      //   'خطأ',
      //   'فشل في جلب سعر التوصيل. حاول مرة أخرى',
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
    }
  }

  Future<bool> placeOrder() async {
    try {
      isLoading.value = true;

      final storageService = Get.find<StorageService>();
      final token = await storageService.getToken();

      if (token == null) {
        Get.snackbar(
          'تنبيه',
          'يجب تسجيل الدخول أولاً',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        final result = await Get.toNamed(ScreenName.SinginScreen);
        if (result != true) {
          return false;
        }
        return placeOrder();
      }

      if (cartItems.isEmpty) {
        Get.snackbar(
          'تنبيه',
          'السلة فارغة',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return false;
      }

      final orderDetails = cartItems.map((item) => {
        'meal_id': item.meal_id,
        'qty': item.quantity,
      }).toList();

      final orderData = OrderModel(
        totalPrice: total.value + deliveryFee.value, // إضافة سعر التوصيل للسعر الإجمالي
        status: 'pending',
        orderDetails: orderDetails,
      );

      final response = await submitPlaceOrder(orderData);

      if (response['status'] == true) {
        clearCart();
        Get.snackbar(
          'نجاح',
          'تم إرسال طلبك بنجاح',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      }

      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء إرسال الطلب',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } catch (e) {
      if (e.toString().contains('401')) {
        final storageService = Get.find<StorageService>();
        await storageService.deleteToken();

        Get.snackbar(
          'تنبيه',
          'انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );

        Get.offAllNamed(ScreenName.SinginScreen);
        return false;
      }

      Get.snackbar(
        'خطأ',
        'حدث خطأ في الاتصال بالخادم',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> submitPlaceOrder(OrderModel order) async {
    try {
      final response = await orderRepository.placeOrder(order);
      return response;
    } catch (e) {
      throw e;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}