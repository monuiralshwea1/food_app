// import 'package:flutter/material.dart';
// import '../../../models/meal.dart';
// import '../../../constants.dart';
//
// class MealList extends StatelessWidget {
//   final List<Meal> meals;
//
//   const MealList({
//     Key? key,
//     required this.meals,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: meals.length,
//       itemBuilder: (context, index) {
//         final meal = meals[index];
//         return Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: defaultPadding,
//             vertical: defaultPadding / 2,
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.1),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 // Meal Image
//                 ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     bottomLeft: Radius.circular(15),
//                   ),
//                   child: Image.network(
//                     meal.imageUrl,
//                     width: 120,
//                     height: 120,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         width: 120,
//                         height: 120,
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.error),
//                       );
//                     },
//                   ),
//                 ),
//                 // Meal Details
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(defaultPadding),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           meal.name,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 8),
//                         if (meal.description.isNotEmpty)
//                           Text(
//                             meal.description,
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 14,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         const SizedBox(height: 8),
//                         Text(
//                           '\$${meal.price.toStringAsFixed(2)}',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.green,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
