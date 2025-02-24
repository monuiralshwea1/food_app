import 'package:foodly_ui/route/RoutingPage.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();
  
  final _selectedIndex = 0.obs;
  get selectedIndex => _selectedIndex.value;
  
  void changeIndex(int index) {
    if (index == 2) {
      Get.toNamed(ScreenName.order); // التنقل باستخدام المسار
    } else {
      selectedIndex.value = index;
    }
  }
}