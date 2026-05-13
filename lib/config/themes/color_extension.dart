import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MyColor extends ThemeExtension<MyColor> {
  const MyColor({
    required this.mainColor,
    required this.chatBackgroundColor,
    required this.onbordingWaveColor1,
    required this.onbordingWaveColor2,
    required this.bluePinkDark,
    required this.bluePinkLight,
    required this.textColor,
    required this.textFormBorder,
    required this.navBarbg,
    required this.navBarSelectedTab,
    required this.containerShadow1,
    required this.containerShadow2,
    required this.containerLinear1,
    required this.containerLinear2,
  });
  final Color? mainColor;
  final Color? chatBackgroundColor;
  final Color? onbordingWaveColor1;
  final Color? onbordingWaveColor2;
  final Color? bluePinkDark;
  final Color? bluePinkLight;
  final Color? textColor;
  final Color? textFormBorder;
  final Color? navBarbg;
  final Color? navBarSelectedTab;
  final Color? containerShadow1;
  final Color? containerShadow2;
  final Color? containerLinear1;
  final Color? containerLinear2;

  @override
  ThemeExtension<MyColor> copyWith({
    Color? mainColor,
    Color? bluePinkDark,
    Color? bluePinkLight,
    Color? textColor,
    Color? textFormBorder,
    Color? navBarbg,
    Color? navBarSelectedTab,
    Color? containerShadow1,
    Color? containerShadow2,
    Color? containerLinear1,
    Color? containerLinear2,
  }) {
    return MyColor(
      mainColor: mainColor,
      chatBackgroundColor: chatBackgroundColor,
      onbordingWaveColor1: onbordingWaveColor1,
      onbordingWaveColor2: onbordingWaveColor2,
      bluePinkDark: bluePinkDark,
      bluePinkLight: bluePinkLight,
      textColor: textColor,
      textFormBorder: textFormBorder,
      navBarbg: navBarbg,
      navBarSelectedTab: navBarSelectedTab,
      containerShadow1: containerShadow1,
      containerShadow2: containerShadow2,
      containerLinear1: containerLinear1,
      containerLinear2: containerLinear2,
    );
  }

  @override
  ThemeExtension<MyColor> lerp(
      covariant ThemeExtension<MyColor>? other, double t) {
    if (other is! MyColor) {
      return this;
    }
    return MyColor(
      mainColor: mainColor,
      chatBackgroundColor: chatBackgroundColor,
      onbordingWaveColor1: onbordingWaveColor1,
      onbordingWaveColor2: onbordingWaveColor2,
      bluePinkDark: bluePinkDark,
      bluePinkLight: bluePinkLight,
      textColor: textColor,
      textFormBorder: textFormBorder,
      navBarbg: navBarbg,
      navBarSelectedTab: navBarSelectedTab,
      containerShadow1: containerShadow1,
      containerShadow2: containerShadow2,
      containerLinear1: containerLinear1,
      containerLinear2: containerLinear2,
    );
  }

  static const MyColor dark = MyColor(
    mainColor: ColorsDark.mainColor,
    chatBackgroundColor: ColorsDark.chatBackgroundColor,
    onbordingWaveColor1: ColorsDark.onbordingWaveColor1,
    onbordingWaveColor2: ColorsDark.onbordingWaveColor2,
    bluePinkDark: ColorsDark.blueDark,
    bluePinkLight: ColorsDark.blueLight1,
    textColor: ColorsDark.white,
    textFormBorder: ColorsDark.blueLight1,
    navBarbg: ColorsDark.navBarDark,
    navBarSelectedTab: ColorsDark.white,
    containerShadow1: ColorsDark.black1,
    containerShadow2: ColorsDark.black2,
    containerLinear1: ColorsDark.black1,
    containerLinear2: ColorsDark.black2,
  );
  static const MyColor light = MyColor(
    mainColor: ColorsLight.mainColor,
    chatBackgroundColor: ColorsLight.chatBackgroundColor,
    onbordingWaveColor1: ColorsLight.onbordingWaveColor1,
    onbordingWaveColor2: ColorsLight.onbordingWaveColor2,
    bluePinkDark: ColorsLight.pinkDark,
    bluePinkLight: ColorsLight.pinkLight,
    textColor: ColorsLight.black,
    textFormBorder: ColorsLight.pinkLight,
    navBarbg: ColorsLight.mainColor,
    navBarSelectedTab: ColorsLight.pinkDark,
    containerShadow1: ColorsLight.white,
    containerShadow2: ColorsLight.white,
    containerLinear1: ColorsLight.pinkDark,
    containerLinear2: ColorsLight.pinkLight,
  );
}
