import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import '../model/location_model.dart';
import '../repositories/location_repository.dart';
import '../services/LocationService.dart';

class LocationController extends GetxController {
  final LocationRepository _locationRepository;
  final RxList<LocationModel> locations = <LocationModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  // For Google Maps
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  Rx<String?> selectedAddress = Rx<String?>(null);

  LocationController(this._locationRepository);

  @override
  void onInit() {
    super.onInit();
    fetchLocations();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        selectedLocation.value = LatLng(
            position.latitude,
            position.longitude
        );
        _getAddressFromLatLng(selectedLocation.value!);
      } else {
        Get.snackbar(
          'Error',
          'Please enable GPS and grant location permission',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  Future<void> fetchLocations() async {
    try {
      isLoading.value = true;
      error.value = '';
      final fetchedLocations = await _locationRepository.getLocations();
      locations.assignAll(fetchedLocations);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addLocation(LatLng position) async {
    try {
      isLoading.value = true;
      error.value = '';

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final address = placemarks.first;
      final addressStr = '${address.street}, ${address.locality}, ${address.country}';

      await _locationRepository.addLocation(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
        additionalDetails: addressStr,
      );

      await fetchLocations();

      Get.back();
      Get.snackbar(
        'Success',
        'Location added successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        error.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void updateSelectedLocation(LatLng location) {
    selectedLocation.value = location;
    _getAddressFromLatLng(location);
  }

  Future<void> _getAddressFromLatLng(LatLng location) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        selectedAddress.value =
        '${place.street}, ${place.locality}, ${place.country}';
      }
    } catch (e) {
      print('Error getting address: $e');
      selectedAddress.value = null;
    }
  }
}
