import 'package:flutter/material.dart';
import 'package:flutter_helper/core/utils/app_colors.dart';
import 'package:flutter_helper/features/splash/presentation/views/widgets/animated_image_logo.dart';
import 'package:flutter_helper/shared_widgets/custom_text.dart';

class AnimatedAlignLogoSplash extends StatelessWidget {
  const AnimatedAlignLogoSplash(
      {super.key,
      required this.isMoved,
      required this.fillFraction,
      required this.showDetails});
  final bool isMoved;
  final double fillFraction;
  final bool showDetails;

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: isMoved ? const Alignment(0.0, -0.8) : Alignment.center,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutBack,
      child: AnimatedScale(
        scale: isMoved ? 0.6 : 1.2,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedImageLogo(fillFraction: fillFraction),
            if (isMoved)
              AnimatedOpacity(
                opacity: showDetails ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: CustomTextWidget(
                    text: 'E-Chat',
                    textStyle: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: AppColors.mainColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
