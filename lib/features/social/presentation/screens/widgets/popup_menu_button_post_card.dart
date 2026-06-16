import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/core/widgets/user_dialogs.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/presentation/manager/social_cubit/social_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/edit_post_bottom_sheet_content.dart';
import 'package:chat_app/shared_widgets/custom_buttom_sheet.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PopupMenuButtonPostCard extends StatelessWidget {
  const PopupMenuButtonPostCard({
    super.key,
    required this.post,
  });

  final SocialEntity post;

  @override
  Widget build(BuildContext context) {
    final socialCubit = context.read<SocialCubit>();
    return PopupMenuButton<String>(
      color: context.color.popupMenu,
      icon: Icon(Icons.more_horiz, color: context.color.textColor),
      onSelected: (value) {
        if (value == 'delete') {
          CustomDialog.twoButtonDialog(
              context: context,
              textBody: 'do_you_want_to_delete_the_post'.tr(),
              textButton1: 'yes'.tr(),
              textButton2: 'no'.tr(),
              onPressed: (){
                socialCubit.deletePost(post.id);
                GoRouter.of(context).pop(context);
              },
              isLoading: false);
        } else if (value == 'edit') {
          CustomBottomSheet.showModalBottomSheetContainer(
            context: context,
            backgroundColor: context.color.navBarbg,
            widget: BlocProvider.value(
              value: socialCubit,
              child: EditPostBottomSheetContent(post: post),
            ),
          );
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(
                  Icons.edit_outlined,
                  color: Colors.amber,
                  size: 18.sp,
                ),
                SizedBox(
                  width: 10.w,
                ),
                CustomTextWidget(
                  text: 'edit_post'.tr(),
                  textStyle: TextStyle(
                      color: Colors.amber, fontSize: FontDetails.fontSizeS),
                ),
              ],
            )),
        PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                  size: 18.sp,
                ),
                SizedBox(
                  width: 10.w,
                ),
                CustomTextWidget(
                  text: 'delete_post'.tr(),
                  textStyle: TextStyle(
                      color: Colors.red, fontSize: FontDetails.fontSizeS),
                ),
              ],
            ))
      ],
    );
  }
}
