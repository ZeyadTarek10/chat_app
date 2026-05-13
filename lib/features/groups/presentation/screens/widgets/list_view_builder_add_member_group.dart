import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/groups/presentation/manager/groups_cubit/groups_cubit.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListViewBuilderAddMemberGroup extends StatelessWidget {
  const ListViewBuilderAddMemberGroup({
    super.key,
    required this.cubit,
  });

  final GroupsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cubit.selectedMembers.length,
      itemBuilder: (context, index) {
        var member = cubit.selectedMembers[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: (member['image'] != null &&
                    member['image']!.isNotEmpty)
                ? NetworkImage(member['image']!)
                : null,
            child: (member['image'] == null ||
                    member['image']!.isEmpty)
                ? CustomTextWidget(
                    text: member['name'].isNotEmpty
                        ? member['name'][0].toUpperCase()
                        : '',
                    textStyle: TextStyle(
                        color: ColorsLight.black,
                        fontSize: 20.sp),
                  )
                : null,
          ),
          title: CustomTextWidget(text: member['name']!, textStyle: TextStyle(color: context.color.textColor)),
          subtitle:
              CustomTextWidget(text: member['phone']!, textStyle: TextStyle(color: context.color.textColor)),
          trailing: Container(
            height: 35.h,
            decoration: BoxDecoration(
              color: ColorsDark.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.close, color: ColorsLight.red, size: 20.sp),
              onPressed: () {
                cubit.removeMember(index);
              },
            ),
          ),
        );
      },
    );
  }
}
