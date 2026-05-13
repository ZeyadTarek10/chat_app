import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendIcon extends StatelessWidget {
  const SendIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsDark.blueLight1,
            ColorsDark.blueLight2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.send_rounded, color: ColorsDark.white, size: 20.sp),
    );
  }
}
