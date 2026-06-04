import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/message/presentation/screens/widgets/icon_options.dart';
import 'package:chat_app/features/message_groups/presentation/manager/cubit/messege_group_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AttachmentGroupMenu extends StatelessWidget {
  final String groupId;
  const AttachmentGroupMenu({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MessegeGroupCubit>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: context.color.navBarbg,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsLight.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconOptions(
                icon: Icons.camera_alt,
                label: 'camera'.tr(),
                onPressed: () => cubit.sendGroupImageMessage(
                    groupId: groupId, source: ImageSource.camera),
              ),
              // IconOptions(
              //     icon: Icons.mic, label: 'record'.tr(), onPressed: () {}),
              IconOptions(
                  icon: Icons.person,
                  label: 'contact'.tr(),
                  onPressed: () {
                    cubit.sendGroupContactMessage(groupId: groupId);
                  }),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconOptions(
                icon: Icons.photo,
                label: 'gallery'.tr(),
                onPressed: () => cubit.sendGroupImageMessage(
                    groupId: groupId, source: ImageSource.gallery),
              ),
              IconOptions(
                  icon: Icons.location_on,
                  label: 'my_location'.tr(),
                  onPressed: () {
                    cubit.sendGroupLocationMessage(groupId: groupId);
                  }),
              // IconOptions(
              //     icon: Icons.insert_drive_file,
              //     label: 'document'.tr(),
              //     onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
