import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImages {
  static const String path = 'assets/images';
  static const String appLogoImg = '$path/Logo.png';
  static const String appLogoImgHome = '$path/Logo E-Chat.png';
  static const String googleLogoImg = '$path/google_logo.png';
  static const String chatRoundImg = '$path/Chat Round.png';
  static const String onboundingImg = '$path/onbording.png';
  static const String onboundingImg1 = '$path/onbording1.png';
  static const String onboundingImg2 = '$path/onbording2.png';
  static const String onboundingImg3 = '$path/onbording3.png';

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
