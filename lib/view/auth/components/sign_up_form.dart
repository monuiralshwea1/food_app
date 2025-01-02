import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../../controller/auth/sing_controller.dart';


class SignUpForm extends GetView<SignController> {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          // Name Field
          TextFormField(
            controller: controller.nameController,
            validator: controller.validateName,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            decoration:  InputDecoration(hintText: "Name".tr),
          ),

          const SizedBox(height: defaultPadding),
          // Email Field
          TextFormField(
            controller: controller.emailController,
            validator: controller.validateEmail,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration:  InputDecoration(hintText: "Email Address".tr),
          ),
          const SizedBox(height: defaultPadding),

          // Password Field
          Obx(() => TextFormField(
            controller: controller.passwordController,
            obscureText: controller.obscureText,
            validator: controller.validatePassword,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Password".tr,
              suffixIcon: GestureDetector(
                onTap: controller.togglePasswordVisibility,
                child: Icon(
                  controller.obscureText ? Icons.visibility_off : Icons.visibility,
                  color: bodyTextColor,
                ),
              ),
            ),
          )),
          const SizedBox(height: defaultPadding),

          // Confirm Password Field
          Obx(() => TextFormField(
            controller: controller.confirmPasswordController,
            obscureText: controller.obscureText,
            validator: controller.validateConfirmPassword,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Confirm Password".tr,
              suffixIcon: GestureDetector(
                onTap: controller.togglePasswordVisibility,
                child: Icon(
                  controller.obscureText ? Icons.visibility_off : Icons.visibility,
                  color: bodyTextColor,
                ),
              ),
            ),
          )),
          const SizedBox(height: defaultPadding),

          // Phone Field
          TextFormField(
            controller: controller.phoneController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            validator: controller.validatePhone,
            decoration:  InputDecoration(hintText: "Phone Number".tr),
          ),
          const SizedBox(height: defaultPadding),

          // Address Field
          TextFormField(
            controller: controller.addressController,
            textInputAction: TextInputAction.done,
            validator: controller.validateAddress,
            decoration:  InputDecoration(hintText: "Address".tr),
          ),
          const SizedBox(height: defaultPadding),

          // Sign Up Button
          Obx(() => ElevatedButton(
            onPressed: controller.isLoading ? null : controller.signUp,
            child: controller.isLoading
                ? const CircularProgressIndicator()
                :  Text("Sing up".tr),
          )),
        ],
      ),
    );
  }
}