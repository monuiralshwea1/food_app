import 'package:flutter/material.dart';
import 'package:foodly_ui/constants.dart';
import '../../../model/meal.dart';
import 'package:get/get.dart';
class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onPressed;

  const MealCard({
    Key? key,
    required this.meal,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                meal.image.toString(),
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.restaurant,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            // Content Section
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    meal.name ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Price and Add Button Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Text(
                        '\$${meal.price?.toStringAsFixed(2) ?? '0.00'}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:primaryColor,
                        ),
                      ),
                      // Add Button
                      SizedBox(
                        width: 100, // Fixed width for the button
                        child: ElevatedButton(
                          onPressed: onPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add_shopping_cart, size: 18),
                              const SizedBox(width: 4),
                              Text('Add'.tr),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}