import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import '../constants.dart';
import '../core/network_cache_service.dart';
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

  final NetworkCacheService _networkCacheService = Get.find<NetworkCacheService>();
  Timer? _updateTimer;

  LocationController(this._locationRepository);

  @override
  void onInit() {
    super.onInit();
    fetchLocations();
    getCurrentLocation();
    _startAutoUpdate(); // تحديث دوري للبيانات
  }

  @override
  void onClose() {
    _updateTimer?.cancel();
    super.onClose();
  }



/////////////////////////////////////////////////////////////////
  void _startAutoUpdate() {
    _updateTimer = Timer.periodic(Duration(minutes: 5), (timer) {
      fetchLocations();
    });
  }



  ////////////////////////////////////////////////////////////////

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




  //////////////////////////////////////////////////////////////

  Future<dynamic> fetchLocations() async {
    try {
      isLoading.value = true;
      error.value = '';
      // final cachedData = _networkCacheService.loadFromCache('locations');
      // if (cachedData != null) {
      //   locations.assignAll(cachedData.map((e) => LocationModel.fromJson(e)).toList());
      //
      // }
      /// **🔹 التحقق من الإنترنت وجلب البيانات من API إذا لزم الأمر**
      // if (await _networkCacheService.hasInternet()) {

        final fetchedLocations = await _locationRepository.getLocations();
        locations.assignAll(fetchedLocations);
        final availableLocation = locations.firstWhereOrNull((loc) => loc.isAvailable == true);
      if (availableLocation != null) {
        activeLocationId.value = availableLocation.id;
      }

       // _networkCacheService.saveToCache('locations',fetchedLocations.map((e) => e.toJson()).toList());

      //}

    } catch (e) {

      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }



////////////////////////////////////////////////////////////////////
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
      //print(e.toString());
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



/////////////////////////////////////////////////////////
  void updateSelectedLocation(LatLng location) {
    selectedLocation.value = location;
    _getAddressFromLatLng(location);
  }


  //////////////////////////////////////////////////////
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


  ///////////////////////////////////////////////////

  Future<void> setActiveLocation(int locationId) async {
    try {
      isLoading.value = true;
      error.value = '';


      await _locationRepository.updateLocationStatus(locationId);

      //activeLocationId.value = locationId;

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