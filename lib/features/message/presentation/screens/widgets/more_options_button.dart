import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MoreOptionsButton extends StatelessWidget {
  const MoreOptionsButton({
    super.key,
    required this.cubit,
    required this.roomId,
  });

  final MessageCubit cubit;
  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: PopupMenuButton<String>(
        icon: cubit.isMenuOpen
            ? Container(
                decoration: BoxDecoration(
                  color: context.color.textColor!.withOpacity(0.2),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: context.color.mainColor!.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.close, color: context.color.textColor),
              )
            : Icon(Icons.more_horiz_rounded,
                color: context.color.textColor, size: 20.sp),
        offset: const Offset(0, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        color: context.color.popupMenu,
        elevation: 8,
        onOpened: () => cubit.toggleMenuState(true),
        onCanceled: () => cubit.toggleMenuState(false),
        onSelected: (value) {
          cubit.toggleMenuState(false);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (value == 'Delete chat') {
              cubit.deleteRoom(roomId: roomId);
              if (context.mounted) {
                GoRouter.of(context).pushReplacement(AppRoutes.home);
              }
            } else if (value == 'Delete messages') {
              cubit.clearChat(roomId: roomId);
            }
          });
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'Delete chat',
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Row(
              children: [
                const Icon(CupertinoIcons.trash,
                    color: ColorsLight.mainTextColor, size: 20),
                SizedBox(width: 16.w),
                CustomTextWidget(
                  text: 'delete_chat'.tr(),
                  textStyle: TextStyle(
                    fontSize: FontDetails.fontSizeS,
                    fontWeight: FontDetails.semiBoldFontWeight,
                    color: context.color.textColor,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'Delete messages',
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Row(
              children: [
                Icon(CupertinoIcons.delete_left,
                    color: ColorsLight.mainTextColor, size: 20.sp),
                SizedBox(width: 16.w),
                CustomTextWidget(
                  text: 'delete_messages'.tr(),
                  textStyle: TextStyle(
                    fontSize: FontDetails.fontSizeS,
                    fontWeight: FontDetails.semiBoldFontWeight,
                    color: context.color.textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
