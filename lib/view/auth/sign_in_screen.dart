import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../components/buttons/socal_button.dart';
import '../../components/welcome_text.dart';
import '../../constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../route/RoutingPage.dart';
import 'components/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Sing in".tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Sign Up Form
              const SignInForm(),
              const SizedBox(height: defaultPadding),

              //Already have account
              Center(
                child: Text.rich(
                  TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.w500),
                    text: "Dont you have an account?".tr,
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Sing up'.tr,
                          style: const TextStyle(color: primaryColor),
                          recognizer: TapGestureRecognizer()

                        ..onTap = () => Get.toNamed(ScreenName.SingUpScreen),
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: defaultPadding),
              // Center(
              //   child: Text(
              //     "By Signing up you agree to our Terms \nConditions & Privacy Policy.",
              //     textAlign: TextAlign.center,
              //     style: Theme.of(context).textTheme.bodyMedium,
              //   ),
              // ),
              // const SizedBox(height: defaultPadding),
              // kOrText,
              // const SizedBox(height: defaultPadding),
              //
              // // Facebook
              // SocalButton(
              //   press: () {},
              //   text: "Connect with Facebook",
              //   color: const Color(0xFF395998),
              //   icon: SvgPicture.asset(
              //     'assets/icons/facebook.svg',
              //     colorFilter: const ColorFilter.mode(
              //       Color(0xFF395998),
              //       BlendMode.srcIn,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: defaultPadding),
              //
              // // Google
              // SocalButton(
              //   press: () {},
              //   text: "Connect with Google",
              //   color: const Color(0xFF4285F4),
              //   icon: SvgPicture.asset(
              //     'assets/icons/google.svg',
              //   ),
              // ),
              // const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
