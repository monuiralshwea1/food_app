import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../../controller/auth/sing_controller.dart';


class SignInForm extends GetView<SignController> {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.phoneController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            validator: controller.validatePhone,
            decoration:  InputDecoration(hintText: "Phone Number".tr),
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
          ),
          ),
          const SizedBox(height: defaultPadding),

          // Sign In Button
          Obx(() => ElevatedButton(
            onPressed: controller.isLoading ? null : controller.signIn,
            child: controller.isLoading
                ? const CircularProgressIndicator()
                :  Text("Sing in".tr),
          )),
        ],
      ),
    );
  }
}