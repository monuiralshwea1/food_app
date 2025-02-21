import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../route/RoutingPage.dart';
import '../core/storge/storage_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final storageService = Get.find<StorageService>();

      storageService.getToken().then((token) {
        if (token == null && route != ScreenName.SinginScreen) {
           Get.offNamed(ScreenName.SinginScreen);
        }
    }
    );


    return null;
  }
}
