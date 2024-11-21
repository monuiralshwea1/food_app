import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();
  
  final _selectedIndex = 0.obs;
  get selectedIndex => _selectedIndex.value;
  
  void changeIndex(int index) {
    _selectedIndex.value = index;
  }
}