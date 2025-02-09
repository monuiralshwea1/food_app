import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../route/RoutingPage.dart';
import '../core/storge/storage_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final storageService = Get.find<StorageService>();
    final token = storageService.getToken();

    if (token == null && route != ScreenName.SinginScreen) {
      return const RouteSettings(name: ScreenName.SinginScreen);
    }

    return null;
  }
}
