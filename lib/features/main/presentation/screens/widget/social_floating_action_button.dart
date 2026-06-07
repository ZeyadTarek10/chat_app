import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        GoRouter.of(context).push(AppRoutes.social);
      },
      child: const Icon(Icons.public),
    );
  }
}
