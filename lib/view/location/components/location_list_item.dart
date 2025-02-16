import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/location_controller.dart';
import '../../../model/location_model.dart';


class LocationListItem extends GetView<LocationController> {
  final LocationModel location;

  const LocationListItem({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.location_on),
        title: Text(location.additionalDetails ?? 'Unknown Location'.tr),
        subtitle: Text(
          'Lat: ${location.latitude}, Long: ${location.longitude}',
        ),
        trailing: Obx(() => IconButton(
          icon: Icon(
            location.id == controller.activeLocationId.value
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: location.id == controller.activeLocationId.value
                ? Colors.green
                : Colors.grey,
          ),
          onPressed: () => controller.setActiveLocation(location.id),
        )),
      ),
    );
  }
}