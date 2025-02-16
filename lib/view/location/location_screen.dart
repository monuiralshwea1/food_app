import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
            onPressed: () => Get.to(() => const AddLocationScreen()),
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
                  onPressed: () => Get.to(() => const AddLocationScreen()),
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

class AddLocationScreen extends GetView<LocationController> {
  const AddLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Location'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            tooltip: 'Get Current Location'.tr,
            onPressed: controller.getCurrentLocation,
          ),
        ],
      ),
      body: Stack(
        children: [
          Obx(() {
            final initialPosition = controller.selectedLocation.value ??
                const LatLng(15.3694, 44.1910); // Sana'a coordinates

            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: initialPosition,
                zoom: 15,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              onTap: controller.updateSelectedLocation,
              markers: controller.selectedLocation.value != null
                  ? {
                Marker(
                  markerId: const MarkerId('selected'),
                  position: controller.selectedLocation.value!,
                  draggable: true,
                  onDragEnd: controller.updateSelectedLocation,
                ),
              }
                  : {},
            );
          }),

          // Loading indicator for getting location
          Obx(() {
            if (controller.isGettingLocation.value) {
              return Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return const SizedBox.shrink();
          }),

          // Bottom panel
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Obx(() {
              final location = controller.selectedLocation.value;
              final address = controller.selectedAddress.value;

              return Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (location == null) ...[
                        Text(
                          'Select Location'.tr,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap on the map to select a location or use current location'.tr,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ] else ...[
                        Text(
                          'Selected Location'.tr,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (address != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            address,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () => controller.addLocation(location),
                          child: controller.isLoading.value
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                              : Text('Confirm Location'.tr),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}