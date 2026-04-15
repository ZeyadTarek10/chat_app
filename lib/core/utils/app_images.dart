import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImages {
  static const String path = 'assets/images';
  static const String appLogoImg = '$path/';
  static const String googleLogoImg = '$path/';
  static const String chatRoundImg = '$path/';
  static const String onboundingImg = '$path/';
  static const String onboundingImg2 = '$path/';
  static const String onboundingImg3 = '$path/';


  static Widget showImg({
    required String imgPath,
    double? width,
    double? height,
  }) {
    if (imgPath.endsWith('.svg')) {
      return SvgPicture.asset(imgPath, width: width, height: height);
    } else {
      return Image.asset(imgPath, width: width, height: height);
    }
  }
}
