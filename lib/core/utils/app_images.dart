import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class AppImages {
  static const String path = 'assets/images';
  static const String path2 = 'assets/lottie';
  static const String appLogoImg = '$path/Logo.png';
  static const String appLogoImgHomeLight = '$path/Logo E-Chat_light.png';
  static const String appLogoImgHomeDark = '$path/Logo E-Chat_dark.png';
  static const String iconSplashLight = '$path/icon_splash_light.png';
  static const String iconSplashDark = '$path/icon_splash_dark.png';
  static const String googleLogoImg = '$path/google_logo.png';
  static const String chatRoundImg = '$path/Chat Round.png';
  static const String onboundingImgLight = '$path/onbording_light.png';
  static const String onboundingImg1Light = '$path/onbording1_light.png';
  static const String onboundingImg2Light = '$path/onbording2_light.png';
  static const String onboundingImg3Light = '$path/onbording3_light.png';
  static const String onboundingImgDark = '$path/onbording_dark.png';
  static const String onboundingImg1Dark = '$path/onbording1_dark.png';
  static const String onboundingImg2Dark = '$path/onbording2_dark.png';
  static const String onboundingImg3Dark = '$path/onbording3_dark.png';
  static const String userCircle = '$path/User Circle.png';
  static const String buttonIcon = '$path/Button Icon.png';
  static const String cardsearch = '$path/Card Search.png';
  static const String bG = '$path/BG.png';
  static const String addFrind = '$path2/Add Friend.json';
  static const String loadingDotsBlue = '$path2/Loading Dots Blue.json';
  static const String noInternetConnection =
      '$path2/No Internet Connection.json';
  static const String nonDataFound = '$path2/non data found.json';
  static const String share = '$path2/Share.json';

  static Widget showImg({
    required String imgPath,
    double? width,
    double? height,
  }) {
    if (imgPath.endsWith('.svg')) {
      return SvgPicture.asset(imgPath, width: width, height: height);
    } else if (imgPath.endsWith('.json')){
      return Lottie.asset(imgPath, width: width, height: height);
    }
    else {
      return Image.asset(imgPath, width: width, height: height);
    }
  }
}
