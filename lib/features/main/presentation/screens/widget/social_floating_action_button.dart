import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/social/presentation/screens/social_screen.dart';
import 'package:flutter/material.dart';

class SocialFloatingActionButton extends StatelessWidget {
  const SocialFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: ColorsLight.mainTextColor,
      backgroundColor: context.color.navBarbg,
      splashColor: context.color.textSplashColor,
      focusColor: context.color.textSplashColor,
      hoverColor: context.color.textSplashColor,
      shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SocialScreen()),
          );
        },
        child: const Icon(Icons.public),
      );
  }
}
