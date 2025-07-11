import 'package:foodly_ui/controller/category_controller.dart';
import 'package:foodly_ui/controller/get_order_controller.dart';
import 'package:foodly_ui/controller/meal_iem_controller.dart';
import 'package:foodly_ui/controller/offer_controller.dart';
import 'package:foodly_ui/repositories/auth_repositorie.dart';
import 'package:foodly_ui/repositories/category_repositorie.dart';
import 'package:foodly_ui/repositories/get_order_repositorie.dart';
import 'package:foodly_ui/repositories/meal_item_repositorie.dart';
import 'package:foodly_ui/repositories/offer_repositorie.dart';
import 'package:foodly_ui/repositories/order_repositorie.dart';
import 'package:get/get.dart';
import 'controller/auth/sing_controller.dart';
import 'controller/cart_controller.dart';
import 'controller/drawer_controller.dart';
import 'controller/location_controller.dart';
import 'controller/navigation_controller.dart';
import 'core/network/dio_client.dart';
import 'core/network_cache_service.dart';
import 'core/storge/storage_service.dart';
import 'repositories/location_repository.dart';


class Binding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => StorageService(),fenix:true);
    Get.lazyPut(() => DioClient(Get.find<StorageService>()),fenix:true);
    Get.lazyPut(()=>NavigationController(),fenix:true);
    Get.lazyPut(()=>NetworkCacheService(), fenix: true);
    Get.lazyPut(() => AuthRepository(Get.find<DioClient>(), Get.find<StorageService>()),fenix:true);
    Get.lazyPut(()=>SignController(Get.find<AuthRepository>()),fenix:true);
    Get.lazyPut(()=> AppDrawerController(Get.find<StorageService>()),fenix:true);
    Get.lazyPut(() => MealItemRepository(Get.find<DioClient>()),fenix:true);
    Get.lazyPut(() => MealItemController(Get.find<MealItemRepository>()),fenix:true);
    Get.lazyPut(() => CategoryRepository(Get.find<DioClient>()),fenix:true);
    Get.lazyPut(() => CategoryController(Get.find<CategoryRepository>()),fenix:true);
    Get.lazyPut(()=>OrderRepository(Get.find<DioClient>()),fenix:true);
    Get.lazyPut(() => CartController(Get.find<OrderRepository>()),fenix:true);
    Get.lazyPut(() => OfferRepository(Get.find<DioClient>()),fenix:true);
    Get.lazyPut(()=>OfferController(Get.find<OfferRepository>()),fenix: true);
    Get.lazyPut(()=>LocationRepository(Get.find<DioClient>()),fenix: true);
    Get.lazyPut(()=>LocationController(Get.find<LocationRepository>()),fenix: true);
    Get.lazyPut(()=>GetOrderRepository(Get.find<DioClient>()),fenix: true);
    Get.lazyPut(()=>GetOrderController(Get.find<GetOrderRepository>()),fenix: true);




  }
}