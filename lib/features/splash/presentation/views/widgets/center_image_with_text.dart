import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_images.dart';

class CenterImageWithText extends StatelessWidget {
  const CenterImageWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 280,
        height: 280,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('${AppImages.chatRoundImg}Chat Round.png'), 
            fit: BoxFit.contain, 
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0), 
            child: Text(
              'Stay Connected\nStay Chatting',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.mainColor, 
                height: 1.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
