import 'package:chat_app/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class MyAssets extends ThemeExtension<MyAssets> {
  const MyAssets({
    required this.logoEChat,
    required this.onbording,
    required this.onbording1,
    required this.onbording2,
    required this.onbording3,
  });

  final String? logoEChat;
  final String? onbording;
  final String? onbording1;
  final String? onbording2;
  final String? onbording3;

  @override
  ThemeExtension<MyAssets> copyWith({
    String? logoEChat,
    String? onbording,
    String? onbording1,
    String? onbording2,
    String? onbording3,
  }) {
    return MyAssets(
      logoEChat: logoEChat,
      onbording: onbording,
      onbording1: onbording1,
      onbording2: onbording2,
      onbording3: onbording3,
    );
  }

  @override
  ThemeExtension<MyAssets> lerp(
    covariant ThemeExtension<MyAssets>? other,
    double t,
  ) {
    if (other is! MyAssets) {
      return this;
    }
    return MyAssets(
      logoEChat: logoEChat,
      onbording: onbording,
      onbording1: onbording1,
      onbording2: onbording2,
      onbording3: onbording3,
    );
  }

  static const MyAssets dark = MyAssets(
    logoEChat: AppImages.appLogoImgHomeDark,
    onbording: AppImages.onboundingImgDark,
    onbording1: AppImages.onboundingImg1Dark,
    onbording2: AppImages.onboundingImg2Dark,
    onbording3: AppImages.onboundingImg3Dark,
  );
  static const MyAssets light = MyAssets(
    logoEChat: AppImages.appLogoImgHomeLight,
    onbording: AppImages.onboundingImgLight,
    onbording1: AppImages.onboundingImg1Light,
    onbording2: AppImages.onboundingImg2Light,
    onbording3: AppImages.onboundingImg3Light,
  );
}
