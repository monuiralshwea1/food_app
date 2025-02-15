import 'package:flutter/material.dart';

import '../../../model/location_model.dart';


class LocationListItem extends StatelessWidget {
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
        title: Text(location.additionalDetails ?? 'Unknown Location'),
        subtitle: Text(
          'Lat: ${location.latitude}, Long: ${location.longitude}',
        ),
        trailing: Icon(
          location.isAvailable ? Icons.check_circle : Icons.cancel,
          color: location.isAvailable ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}