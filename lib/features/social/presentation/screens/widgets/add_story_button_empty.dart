import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/social/presentation/manager/story_cubit/story_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddStoryButtonEmpty extends StatelessWidget {
  const AddStoryButtonEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).push(
            AppRoutes.createOrEditStory,
            extra: {
              'cubit': context.read<StoryCubit>(),
              'storyToEdit': null,
            },
          );
        },
        child: CircleAvatar(
          radius: 35.r,
          backgroundColor: ColorsDark.addMemberButtonLightBlue,
          child: const Icon(Icons.add, color: ColorsDark.blueLight2),
        ),
      ),
    );
  }
}

