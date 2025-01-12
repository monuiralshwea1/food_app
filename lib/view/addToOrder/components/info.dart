import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../model/meal.dart';

class Info extends StatelessWidget {
  const Info({
    Key? key,
    required this.meal,
  }) : super(key: key);

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.5,
          child: meal.image != null
              ? Image.network(
                  meal.image!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.restaurant,
                        color: Colors.grey,
                        size: 40,
                      ),
                    );
                  },
                )
              : Container(
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.restaurant,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
        ),
        const SizedBox(height: defaultPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      meal.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Text(
                    '${meal.price} ر.س',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              if (meal.description != null && meal.description!.isNotEmpty) ...[
                const SizedBox(height: defaultPadding / 2),
                Text(
                  meal.description!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black54,
                      ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
