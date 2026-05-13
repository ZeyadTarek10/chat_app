import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/splash/presentation/views/widgets/bottom_wave_clipper.dart';
import 'package:chat_app/features/splash/presentation/views/widgets/build_dot_onbording.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/buttons/custom_text_btn.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback onGetStarted;

  const OnboardingControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onSkip,
    required this.onNext,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: BottomWaveClipper(),
          child: Container(
            color: context.color.onbordingWaveColor1,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(
              color: context.color.onbordingWaveColor2,
              width: double.infinity.w,
              height: double.infinity.h,
              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  CustomLinearButton(
                      onPressed: onGetStarted,
                      height: 60.h,
                      width: double.infinity.w,
                      child: CustomTextWidget(
                          text: "get_started".tr(),
                          textStyle: TextStyle(
                              fontSize: FontDetails.fontSizeM,
                              color: context.color.mainColor,
                              fontWeight: FontDetails.boldFontWeight))),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextButtonWidget(
                        onPressed: onSkip,
                        text: 'skip'.tr(),
                        textStyle: TextStyle(
                            color: ColorsDark.blueLight2,
                            fontSize: 14.sp),
                      ),
                      Row(
                        children: List.generate(
                          totalPages,
                          (index) => BuildDotOnbording(
                              index: index, currentPage: currentPage),
                        ),
                      ),
                      CustomTextButtonWidget(
                          text: 'next'.tr(),
                          onPressed: onNext,
                          style: TextButton.styleFrom(
                            backgroundColor: ColorsDark.backgroundColorCircleButtonblue3,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(16),
                          ),
                          textStyle: TextStyle(
                              color: ColorsDark.blueDark, fontSize: FontDetails.fontSizeXS)),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
