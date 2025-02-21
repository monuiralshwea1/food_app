// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../../constants.dart';
// import 'package:get/get.dart';
//
// import '../../../controller/auth/sing_controller.dart';
// import '../../../route/RoutingPage.dart';
//
// class Body extends GetView<SignController> {
//   const Body({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: defaultPadding),
//               Text("Account Settings".tr,
//                   style: Theme.of(context).textTheme.headlineMedium),
//               Obx(() {
//                 if (controller.isLoadingProfile.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 return Column(
//                   children: [
//                     ProfileMenuCard(
//                       svgSrc: "assets/icons/profile.svg",
//                       title: "Profile Information".tr,
//                       subTitle: profileController.user['name'] ?? 'Unknown',
//                       press: () {},
//                     ),
//                     ProfileMenuCard(
//                       svgSrc: "assets/icons/mail.svg",
//                       title: "Email".tr,
//                       subTitle: profileController.user['email'] ?? 'No Email',
//                       press: () {},
//                     ),
//                     ProfileMenuCard(
//                       svgSrc: "assets/icons/phone.svg",
//                       title: "Phone".tr,
//                       subTitle: profileController.user['phone'] ?? 'No Phone',
//                       press: () {},
//                     ),
//                   ],
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class ProfileMenuCard extends StatelessWidget {
//   const ProfileMenuCard({
//     super.key,
//     this.title,
//     this.subTitle,
//     this.svgSrc,
//     this.press,
//   });
//
//   final String? title, subTitle, svgSrc;
//   final VoidCallback? press;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
//       child: InkWell(
//         borderRadius: const BorderRadius.all(Radius.circular(8)),
//         onTap: press,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5),
//           child: Row(
//             children: [
//               SvgPicture.asset(
//                 svgSrc!,
//                 height: 24,
//                 width: 24,
//                 colorFilter: ColorFilter.mode(
//                   titleColor.withOpacity(0.64),
//                   BlendMode.srcIn,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title!,
//                       maxLines: 1,
//                       style: Theme.of(context).textTheme.labelLarge,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       subTitle!,
//                       maxLines: 1,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: titleColor.withOpacity(0.54),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 8),
//               const Icon(
//                 Icons.arrow_forward_ios_outlined,
//                 size: 20,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
