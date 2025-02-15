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
        title: const Text('My Locations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_location),
            onPressed: () => Get.to(() => const AddLocationScreen()),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }

        if (controller.locations.isEmpty) {
          return const Center(child: Text('No locations added yet'));
        }

        return ListView.builder(
          itemCount: controller.locations.length,
          itemBuilder: (context, index) {
            final location = controller.locations[index];
            return LocationListItem(location: location);
          },
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
        title: const Text('Add New Location'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(15.3694, 44.1910), // Sana'a coordinates
              zoom: 12,
            ),
            onTap: controller.updateSelectedLocation,
            markers: controller.selectedLocation.value != null
                ? {
              Marker(
                markerId: const MarkerId('selected'),
                position: controller.selectedLocation.value!,
              ),
            }
                : {},
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Obx(() {
              final location = controller.selectedLocation.value;
              final address = controller.selectedAddress.value;

              if (location == null) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Tap on the map to select a location',
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (address != null) ...[
                      Text(
                        'Selected Address:',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(address),
                      const SizedBox(height: 16),
                    ],
                    ElevatedButton(
                      onPressed: () => controller.addLocation(location),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text('Confirm Location'),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}