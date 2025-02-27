import 'package:flutter/material.dart';
import 'package:foodly_ui/model/category.dart';

import '../../../constants.dart';
import '../../rating.dart';
import '../../small_dot.dart';

class RestaurantInfoMediumCard extends StatelessWidget {
   RestaurantInfoMediumCard({
    super.key,
    required this.category,
     required this.press
  });

  Category category;
   final VoidCallback press;


   @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1.25,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                 child:Image.network(
                    category.image.toString(),
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
                     }
                  ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Text(
              category.name.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
