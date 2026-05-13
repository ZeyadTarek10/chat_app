import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/features/splash/presentation/views/widgets/animated_align_logo_splash.dart';
import 'package:chat_app/features/splash/presentation/views/widgets/animated_opacty_logo_splash.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double fillFraction = 0.0;
  bool isMoved = false;
  bool showDetails = false;

  @override
  void initState() {
    super.initState();
    startAnimationSequence();
  }

  void startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) setState(() => fillFraction = 1.0);

    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) setState(() => isMoved = true);

    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => showDetails = true);

    await Future.delayed(const Duration(seconds: 2));
    GoRouter.of(context).pushReplacement(AppRoutes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.mainColor,
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedOpactyLogoSplash(showDetails:  showDetails ),
            AnimatedAlignLogoSplash(
              isMoved: isMoved,
              fillFraction: fillFraction,
              showDetails: showDetails,
            ),
          ],
        ),
      ),
    );
  }
}


