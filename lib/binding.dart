import 'package:get/get.dart';
import 'controller/navigation_controller.dart';


class Binding extends Bindings{

  @override
  void dependencies() {
     Get.lazyPut(()=>NavigationController(),fenix:true);
    // Get.lazyPut(()=>HandlingError(),fenix:true);
    // Get.lazyPut(() => ShareholderController(),fenix:true);
    // Get.lazyPut(() => VolunteerController(),fenix:true);

  }
}