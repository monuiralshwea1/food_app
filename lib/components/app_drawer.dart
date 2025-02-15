import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodly_ui/route/RoutingPage.dart';
import 'package:get/get.dart';
import '../../controller/drawer_controller.dart';
import '../../constants.dart';

class AppDrawer extends GetView<AppDrawerController> {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Settings".tr,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: defaultPadding),

                DrawerMenuItem(
                  svgSrc: "assets/icons/profile.svg",
                  title: "Profile Information".tr,
                  subTitle: "Change your account information".tr,
                  onTap: () => Get.toNamed('/profile'),
                ),

                GetBuilder<AppDrawerController>(
                  builder: (controller)
                  =>Obx(()=> controller.isLoggedIn ?
                    const SizedBox.shrink() :
                    Column(
                      children: [
                        DrawerMenuItem(
                          svgSrc: "assets/icons/lock.svg",
                          title: "Sing up".tr,
                          subTitle:"sing up".tr,
                          onTap: () => Get.toNamed(ScreenName.SingUpScreen),
                        ),
                        DrawerMenuItem(
                          svgSrc: "assets/icons/lock.svg",
                          title: "Sing in".tr,
                          subTitle: "sing in".tr,
                          onTap: () => Get.toNamed(ScreenName.SinginScreen),
                        ),
                      ],
                    ),
                  ),
                ),

                DrawerMenuItem(
                  svgSrc: "assets/icons/card.svg",
                  title: "Payment Methods".tr,
                  subTitle: "Add your credit & debit cards".tr,
                  onTap: () {},
                ),

                DrawerMenuItem(
                  svgSrc: "assets/icons/marker.svg",
                  title: "Locations".tr,
                  subTitle: "Add or remove your delivery locations".tr,
                  onTap: () =>Get.toNamed(ScreenName.locationScreen),
                ),

                DrawerMenuItem(
                  svgSrc: "assets/icons/fb.svg",
                  title: "Add Social Account".tr,
                  subTitle: "Add Facebook, Twitter etc".tr,
                  onTap: () {},
                ),

                DrawerMenuItem(
                  svgSrc: "assets/icons/share.svg",
                  title: "Refer to Friends".tr,
                  subTitle: "Get \$10 for reffering friends".tr,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerMenuItem extends StatelessWidget {
  final String svgSrc, title, subTitle;
  final VoidCallback onTap;

  const DrawerMenuItem({
    super.key,
    required this.svgSrc,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: SvgPicture.asset(
        svgSrc,
        height: 24,
        width: 24,
        colorFilter: ColorFilter.mode(
          titleColor.withOpacity(0.64),
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(
          fontSize: 14,
          color: titleColor.withOpacity(0.54),
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}