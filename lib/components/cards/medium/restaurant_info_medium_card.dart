import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodly_ui/model/category.dart';

import '../../../constants.dart';
import '../../rating.dart';
import '../../small_dot.dart';

class RestaurantInfoMediumCard extends StatelessWidget {
   RestaurantInfoMediumCard({
    super.key,
    required this.category,
     required this.pass
  });

  Category category;
    GestureTapCallback pass;


   @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pass,
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.25,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: category.image!,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit:BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Text(
              category.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),

          ],
        ),
      ),
    );
  }
}
