import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../scalton/scalton_line.dart';
import '../scalton/scalton_rounded_container.dart';

class MediumCardScalton extends StatelessWidget {
  const MediumCardScalton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w, // عرض متجاوب (50% من عرض الشاشة)
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // يمنع overflow بتقليل الحجم للأصغر
        children: [
          const AspectRatio(
            aspectRatio: 1.25,
            child: ScaltonRoundedContainer(),
          ),
          SizedBox(height: 2.h), // مسافة متجاوبة
          ScaltonLine(width: 40.w), // عرض متجاوب
          SizedBox(height: 1.5.h),
          ScaltonLine(width: 45.w),
          SizedBox(height: 1.5.h),
          ScaltonLine(width: 35.w),
        ],
      ),
    );
  }
}
