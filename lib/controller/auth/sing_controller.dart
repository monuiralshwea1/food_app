import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../repositories/auth_repositorie.dart';
import '../../route/RoutingPage.dart';


class SignController extends GetxController {
  final AuthRepository _authRepository;
  final formKey = GlobalKey<FormState>();
  final _obscureText = true.obs;
  final _isLoading = false.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final addressController = TextEditingController();

  SignController(this._authRepository);

  bool get obscureText => _obscureText.value;
  bool get isLoading => _isLoading.value;

  void togglePasswordVisibility() {
    _obscureText.value = !_obscureText.value;
  }

  String? validateName(String? value){
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;

  }

  String? validatePhone(String? value){
    if (value == null || value.isEmpty) {
      return 'Phone is required';
    }
    return null;

  }

  String? validateAddress(String? value){
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    return null;

  }
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }


  Future<void> signIn() async {
    if (formKey.currentState!.validate()) {
      try {
        _isLoading.value = true;
        final user = await _authRepository.login(
          phone: phoneController.text,
          password: passwordController.text,
        );
        Get.offAllNamed(ScreenName.entryPoint); // Navigate to home after successful login
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        _isLoading.value = false;
      }
    }
  }


  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      try {
        _isLoading.value = true;
        final user = await _authRepository.register(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          phone: phoneController.text,
          address: addressController.text,
        );
        Get.offAllNamed(ScreenName.entryPoint);
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        _isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}