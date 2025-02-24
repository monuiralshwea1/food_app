import 'package:flutter/material.dart';
import 'package:foodly_ui/route/RoutingPage.dart';
import 'package:get/get.dart';
import '../controller/navigation_controller.dart';
import 'nav_bar_item.dart';

class BottomNavBar extends GetView<NavigationController> {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Obx(
            () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavBarItem(
              icon: 'assets/icons/home.svg',
              label: 'Home'.tr,
              isSelected: controller.selectedIndex == 0,
              onTap: () => controller.changeIndex(0),
            ),
            NavBarItem(
              icon: 'assets/icons/search.svg',
              label: 'Search'.tr,
              isSelected: controller.selectedIndex == 1,
              onTap: () => controller.changeIndex(1),
            ),
            NavBarItem(
              icon: 'assets/icons/order.svg',
              label: 'Orders'.tr,
              isSelected: controller.selectedIndex == 2,
              onTap: () => Get.toNamed(ScreenName.order),
            ),
            // NavBarItem(
            //   icon: 'assets/icons/profile.svg',
            //   label: 'Profile'.tr,
            //   isSelected: controller.selectedIndex == 3,
            //   onTap: () => controller.changeIndex(3),
            // ),
          ],
        ),
      ),
    );
  }
}