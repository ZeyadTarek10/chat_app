import 'package:flutter/material.dart';
import 'package:chat_app/features/splash/presentation/views/widgets/center_image_with_text.dart';

class AnimatedOpactyLogoSplash extends StatelessWidget {
  const AnimatedOpactyLogoSplash({super.key, required this.showDetails});

  final bool showDetails;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: showDetails ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          CenterImageWithText(),
        ],
      ),
    );
  }
}
