import 'package:chat_app/features/social/presentation/screens/widgets/circle_avatar_trinding_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.0.w),
        itemCount: 6,
        itemBuilder: (context, index) {
          return const CircleAvatarTrindingSection();
        },
      ),
    );
  }
}