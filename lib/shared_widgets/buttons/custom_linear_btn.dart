import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';

class CustomLinearButton extends StatelessWidget {
  const CustomLinearButton({
    required this.onPressed,
    required this.child,
    this.height,
    this.width,
    super.key, this.radius,
  });

  final VoidCallback onPressed;
  final Widget child;
  final double? height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: ColorsDark.blueLight1.withOpacity(0.3),
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: height ?? 44,
        width: width ?? 44,
        decoration: BoxDecoration(
         gradient: const LinearGradient(
          colors: [
            ColorsDark.blueLight1,
            ColorsDark.blueLight2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
          borderRadius: BorderRadius.circular(radius ?? 30),
        ),
        child: Center(child: child),
      ),
    );
  }
}
