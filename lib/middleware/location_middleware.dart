import 'package:flutter/material.dart';
import 'package:foodly_ui/route/RoutingPage.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../core/storge/storage_service.dart';


class LocationMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route)  {
    final StorageService _storageService = Get.find<StorageService>();
      _storageService.getToken().then((token) {
      if (token == null) {
        Get.snackbar(
          'Authentication Required'.tr,
          'Please sign in to manage your locations'.tr,
          backgroundColor:accentColor,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          mainButton: TextButton(
            onPressed: () => Get.toNamed(ScreenName.locationScreen),
            child: Text(
                'Sign In'.tr, style: const TextStyle(color: Colors.white)),
          ),
        );
        Get.offNamed(ScreenName.SinginScreen);
      }
    });

    return null;
  }
}