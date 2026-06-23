import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/features/splash/presentation/views/widgets/animated_image_logo.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                  child: CustomTextWidget(
                    text: 'app_name'.tr(),
                    textStyle: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontDetails.blackFontWeight,
                      color: context.color.textSplashColor,
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
