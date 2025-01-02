import 'package:flutter/material.dart';
import 'package:foodly_ui/components/app_drawer.dart';
import 'package:get/get.dart';
import '../components/bottom_nav_bar.dart';
import '../controller/navigation_controller.dart';
import 'home/home_screen.dart';
import 'search/search_screen.dart';
import 'orderDetails/order_details_screen.dart';
import 'profile/profile_screen.dart';

class EntryPoint extends GetView<NavigationController> {
  EntryPoint({super.key});

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const OrderDetailsScreen(),
    //const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:const AppDrawer(),
      body: Obx(() => _screens[controller.selectedIndex]),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}