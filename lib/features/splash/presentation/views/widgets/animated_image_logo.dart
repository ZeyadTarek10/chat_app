import 'package:flutter/material.dart';
import 'package:flutter_helper/core/utils/app_images.dart';

class AnimatedImageLogo extends StatelessWidget {
  const AnimatedImageLogo({super.key, required this.fillFraction});

  final double logSize = 100.0;
  final double fillFraction;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          '${AppImages.appLogoImg}Logo.png',
          width: logSize,
          height: logSize,
          fit: BoxFit.contain,
          color: const Color(0xFFD0E8F2), 
          colorBlendMode: BlendMode.srcIn, 
        ),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: fillFraction),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return ClipRect(
              child: Align(
                alignment: Alignment.bottomCenter,
                heightFactor: value,
                child: Image.asset(
                  '${AppImages.appLogoImg}Logo.png',
                  width: logSize,
                  height: logSize,
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}