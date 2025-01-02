import 'package:foodly_ui/controller/category_controller.dart';
import 'package:foodly_ui/controller/meal_iem_controller.dart';
import 'package:foodly_ui/repositories/auth_repositorie.dart';
import 'package:foodly_ui/repositories/category_repositorie.dart';
import 'package:foodly_ui/repositories/meal_item_repositorie.dart';
import 'package:get/get.dart';
import 'controller/auth/sing_controller.dart';
import 'controller/drawer_controller.dart';
import 'controller/navigation_controller.dart';
import 'core/network/dio_client.dart';
import 'core/storge/storage_service.dart';


class Binding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => StorageService(),fenix:true);
    Get.lazyPut(() => DioClient(Get.find<StorageService>()),fenix:true);
    Get.lazyPut(()=>NavigationController(),fenix:true);
    Get.lazyPut(() => AuthRepository(Get.find<DioClient>(), Get.find<StorageService>()),fenix:true);
    Get.lazyPut(()=>SignController(Get.find<AuthRepository>()),fenix:true);
    Get.lazyPut(()=> AppDrawerController(Get.find<StorageService>()),fenix:true);
    Get.lazyPut(() => MealItemRepository(Get.find<DioClient>()),fenix:true);
    Get.lazyPut(() => MealItemController(Get.find<MealItemRepository>()),fenix:true);
    Get.lazyPut(() => CategoryRepository(Get.find<DioClient>()),fenix:true);
    Get.lazyPut(() => CategoryController(Get.find<CategoryRepository>()),fenix:true);




  }
}