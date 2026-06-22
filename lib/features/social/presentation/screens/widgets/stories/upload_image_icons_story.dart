import 'package:chat_app/config/app/upload_image/presentation/screens/widgets/image_pick.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/social/presentation/manager/story_cubit/story_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageIconsStory extends StatelessWidget {
  const UploadImageIconsStory({
    super.key,
    required this.cubit,
    required this.hasAnyImage,
  });

  final StoryCubit cubit;
  final bool hasAnyImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: Icon(Icons.camera_alt, color: ColorsDark.white, size: 30.sp),
            onPressed: () async {
              final xFile =
                  await PickImageUtils().pickImage(ImageSource.camera);
              cubit.updateStoryImage(xFile);
            }),
        SizedBox(width: 20.w),
        IconButton(
            icon:
                Icon(Icons.photo_library, color: ColorsDark.white, size: 30.sp),
            onPressed: () async {
              final xFile =
                  await PickImageUtils().pickImage(ImageSource.gallery);
              cubit.updateStoryImage(xFile);
            }),
        if (hasAnyImage) ...[
          SizedBox(width: 20.w),
          IconButton(
              icon: Icon(Icons.delete, color: ColorsLight.error, size: 30.sp),
              onPressed: () {
                cubit.deleteDraftImage();
              }),
        ]
      ],
    );
  }
}

