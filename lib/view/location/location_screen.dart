import 'package:flutter/material.dart';
import 'package:foodly_ui/route/RoutingPage.dart';
import 'package:get/get.dart';
import '../../controller/location_controller.dart';
import 'components/location_list_item.dart';


class LocationScreen extends GetView<LocationController> {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Locations'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            tooltip: 'Get Current Location'.tr,
            onPressed: controller.getCurrentLocation,
          ),
          IconButton(
            icon: const Icon(Icons.add_location),
            tooltip: 'Add New Location'.tr,
            onPressed: () =>  Get.toNamed(ScreenName.AddlocationScreen),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.error.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error'.tr,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Text(controller.error.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchLocations,
                  child: Text('Retry'.tr),
                ),
              ],
            ),
          );
        }

        if (controller.locations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_off,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No locations added yet'.tr,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Add your first delivery location'.tr,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => Get.toNamed(ScreenName.AddlocationScreen),
                  icon: const Icon(Icons.add_location),
                  label: Text('Add Location'.tr),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchLocations(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.locations.length,
            itemBuilder: (context, index) {
              final location = controller.locations[index];
              return LocationListItem(location: location);
            },
          ),
        );
      }),
    ); 
  }
}

