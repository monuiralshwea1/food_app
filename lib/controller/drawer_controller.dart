import 'package:get/get.dart';

import '../core/storge/storage_service.dart';


class AppDrawerController extends GetxController {
  final StorageService _storageService;

  @override
  void onInit() {
    super.onInit();
    getToken();
  }

  AppDrawerController(this._storageService);

  final _isLoggedIn = false.obs;
  bool get isLoggedIn => _isLoggedIn.value;

  Future<void> getToken() async {
    final token = await _storageService.getToken();
    _isLoggedIn.value = token != null;
  }






}