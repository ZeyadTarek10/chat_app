import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetStoryContant extends StatelessWidget {
  const BottomSheetStoryContant({
    super.key,
    required this.viewersDetails,
    required this.likesDetails,
    required this.watchingText,
    required this.likeText,
  });

  final List<UserEntity> viewersDetails;
  final List<UserEntity> likesDetails;
  final String watchingText;
  final String likeText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Icon(Icons.remove_red_eye, color: ColorsDark.blueLight2),
                SizedBox(width: 8.w),
                CustomTextWidget(
                    text: watchingText,
                    textStyle: TextStyle(
                        fontSize: 18.sp, fontWeight: FontDetails.boldFontWeight)),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.favorite, color: ColorsLight.red),
                SizedBox(width: 8.w),
                CustomTextWidget(
                    text: likeText,
                    textStyle: TextStyle(
                        fontSize: 18.sp, fontWeight: FontDetails.boldFontWeight)),
              ],
            ),
          ],
        ),
        Divider(height: 30.h, thickness: 1.w),
        viewersDetails.isEmpty
            ?  Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                    child: CustomTextWidget(text: 'no_views_yet'.tr(),
                        textStyle: const TextStyle(color: ColorsLight.mainTextColor))),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewersDetails.length,
                itemBuilder: (context, index) {
                  final user = viewersDetails[index];
                  final hasLiked = likesDetails.any((u) => u.uid == user.uid);

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: user.profilePicUrl != null
                          ? CachedNetworkImageProvider(user.profilePicUrl!)
                          : null,
                      child: user.profilePicUrl == null
                          ? const Icon(Icons.person, color: Colors.grey)
                          : null,
                    ),
                    title: Text(user.name,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    trailing: hasLiked
                        ? const Icon(Icons.favorite,
                            color: Colors.red, size: 20)
                        : null,
                  );
                },
              ),
      ],
    );
  }
}
