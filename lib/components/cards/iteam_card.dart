import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../small_dot.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.press,
  });

  final String? title, description, image;
  final double? price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.labelLarge!.copyWith(
      color: titleColor.withOpacity(0.64),
      fontWeight: FontWeight.normal,
      fontFamily: 'Cairo', // 👈 إضافة دعم الخط العربي
    );

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: 110,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.network(
                  image.toString(),
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
            ),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // ✅ حل مشكلة overflow
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo', // ✅ تطبيق الخط العربي
                    ),
                  ),
                  Text(
                    description ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontFamily: 'Cairo', // ✅ تطبيق الخط العربي
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        "YER$price",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: primaryColor,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 25.w, // ✅ تحسين حجم الزر
                        height: 5.h,
                        child: ElevatedButton(
                          onPressed: press,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add_shopping_cart, size: 16),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'إضافة'.tr, // ✅ تعريب النص
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontFamily: 'Cairo', // ✅ تطبيق الخط العربي
                                    fontSize: 12,
                                  ),
                                ),
                              ),
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
