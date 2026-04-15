import 'package:flutter/material.dart';
import 'package:flutter_helper/core/utils/app_colors.dart';

class CustomLinearButton extends StatelessWidget {
  const CustomLinearButton({
    required this.onPressed,
    required this.child,
    this.height,
    this.width,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.backgroundColorbuttonblue1.withOpacity(0.3),
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: height ?? 44,
        width: width ?? 44,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.backgroundColorbuttonblue1,
              AppColors.backgroundColorbuttonblue2,
            ],
            begin: const Alignment(0.46, -0.89),
            end: const Alignment(-0.46, 0.89),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(child: child),
      ),
    );
  }
}
