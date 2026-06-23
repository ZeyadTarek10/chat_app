import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SocialFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;
  final Object? heroTag;
  const SocialFloatingActionButton({
    super.key, required this.icon, required this.onPressed, this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: ColorsLight.mainTextColor,
      backgroundColor: context.color.navBarbg,
      splashColor: context.color.textSplashColor,
      focusColor: context.color.textSplashColor,
      hoverColor: context.color.textSplashColor,
      heroTag: heroTag,
      shape: const CircleBorder(),
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
