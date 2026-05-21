import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/config/app/upload_image/presentation/manager/cubit/upload_image_cubit.dart';
import 'package:chat_app/config/app/upload_image/presentation/screens/widgets/image_pick.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

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
          backgroundColor: ColorsDark.blueLight2,
          child: ClipOval(
            child: user!.profilePicUrl != null && user!.profilePicUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: user!.profilePicUrl!,
                    width: 130.r,  
                    height: 130.r,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: SizedBox(
                        width: 30.w,
                        height: 30.h,
                        child: const CircularProgressIndicator(
                          color: ColorsDark.white, 
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: 65.r,
                      backgroundColor: ColorsLight.error,
                      child: Icon(Icons.error_outline, color: Colors.white,size: 50.sp,)
                    )
                  )
                : Image.asset(
                    AppImages.userCircle,
                    width: 130.r,
                    height: 130.r,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: CircleAvatar(
            radius: 18.r,
            backgroundColor: ColorsDark.blueLight2,
            child: IconButton(
              onPressed: () async {
                final picker = PickImageUtils();
                XFile? file = await picker.pickImage(ImageSource.gallery);
                if (file != null) {
                  UploadImageCubit.get(context).postImage(file);
                }
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
