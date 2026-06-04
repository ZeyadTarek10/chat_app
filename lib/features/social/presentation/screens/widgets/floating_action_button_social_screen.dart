import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonSocialScreen extends StatelessWidget {
  const FloatingActionButtonSocialScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      foregroundColor: ColorsLight.mainTextColor,
      backgroundColor: context.color.navBarbg,
      splashColor: context.color.textSplashColor,
      focusColor: context.color.textSplashColor,
      hoverColor: context.color.textSplashColor,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
