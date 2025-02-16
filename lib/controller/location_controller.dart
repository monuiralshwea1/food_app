import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import '../core/storge/storage_service.dart';
import '../model/location_model.dart';
import '../repositories/location_repository.dart';
import '../route/RoutingPage.dart';
import '../services/LocationService.dart';

class LocationController extends GetxController {
  final LocationRepository _locationRepository;
  final RxList<LocationModel> locations = <LocationModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  // For Google Maps
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  Rx<String?> selectedAddress = Rx<String?>(null);

  final RxBool isGettingLocation = false.obs;
  final RxInt activeLocationId = RxInt(-1);

  LocationController(this._locationRepository);

  @override
  void onInit() {
    super.onInit();
    fetchLocations();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      isGettingLocation.value = true;
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        selectedLocation.value = LatLng(
            position.latitude,
            position.longitude
        );
        _getAddressFromLatLng(selectedLocation.value!);
      } else {
        Get.snackbar(
          'Error'.tr,
          'Please enable GPS and grant location permission'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error getting current location: $e');
    } finally {
      isGettingLocation.value = false;
    }
  }

  Future<dynamic> fetchLocations() async {
    try {
      isLoading.value = true;
      error.value = '';
      // التحقق من وجود التوكن
      final storageService = Get.find<StorageService>();
      final token = await storageService.getToken();
      if (token == null) {
        Get.snackbar(
          'تنبيه',
          'يجب تسجيل الدخول أولاً',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );

        // الانتقال إلى صفحة تسجيل الدخول
        final result = await Get.toNamed(ScreenName.SinginScreen);

        // إذا لم يتم تسجيل الدخول بنجاح
        if (result != true) {
          return false;
        }

        // إعادة المحاولة بعد تسجيل الدخول
        return fetchLocations();
      }

      final fetchedLocations = await _locationRepository.getLocations();
      locations.assignAll(fetchedLocations);

      // Set active location
      for (var location in fetchedLocations) {
        if (location.isAvailable) {
          activeLocationId.value = location.id;
          break;
        }
      }

      return true;
    } catch (e) {
      error.value = e.toString();
      return false;
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
        'Success'.tr,
        'Location added successfully'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error'.tr,
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

  Future<void> setActiveLocation(int locationId) async {
    try {
      isLoading.value = true;
      error.value = '';


      await _locationRepository.updateLocationStatus(locationId);

      activeLocationId.value = locationId;

      // Refresh locations to get updated status
      await fetchLocations();

      Get.snackbar(
        'Success'.tr,
        'Location updated successfully'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error'.tr,
        error.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}