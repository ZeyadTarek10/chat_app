import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfilePhoto extends StatelessWidget {
  const EditProfilePhoto({
    super.key,
    required this.user,
  });

  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 65.r,
          backgroundImage: user!.profilePicUrl != null
              ? NetworkImage(user!.profilePicUrl!) as ImageProvider
              : const AssetImage(AppImages.userCircle),
          backgroundColor: ColorsDark.blueLight2,
        ),
        Positioned(
          right: 0,
          top: 0,
          child: CircleAvatar(
            radius: 18.r,
            backgroundColor: ColorsDark.blueLight2,
            child: IconButton(
              onPressed: () {
                // TODO: Edit Image;
              },
              icon: Icon(Icons.edit_outlined,
                  color: ColorsDark.white, size: 20.sp),
            ),
          ),
        )
      ],
    );
  }
}

