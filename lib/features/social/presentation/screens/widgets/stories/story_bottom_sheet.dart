import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/features/message/domain/use_cases/send_message_use_case.dart';
import 'package:chat_app/features/social/domain/entities/story_entity.dart';
import 'package:chat_app/features/social/presentation/manager/story_cubit/story_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/stories/bottom_sheet_story_contant.dart';
import 'package:chat_app/injection_container.dart';
import 'package:chat_app/shared_widgets/custom_buttom_sheet.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryBottomSheetHelper {
  static void show({
    required BuildContext context,
    required StoryEntity story,
    required StoryCubit storyCubit,
    required AnimationController animController,
  }) {
    animController.stop();

    storyCubit.fetchStoryUsersDetails(
        story.viewers, story.likes, getIt<GetUserByIdUseCase>());

    CustomBottomSheet.showModalBottomSheetContainer(
      context: context,
      backgroundColor: context.color.mainColor,
      whenComplete: () {
        animController.forward();
      },
      widget: BlocProvider.value(
        value: storyCubit,
        child: BlocBuilder<StoryCubit, StoryState>(
          builder: (context, state) {
            if (state is! StoryLoaded) return const SizedBox.shrink();
            if (state.isUsersLoading) return const CustomLoading();
            
            return BottomSheetStoryContant(
              viewersDetails: state.viewersDetails, 
              likesDetails: state.likesDetails, 
              watchingText: '${story.viewers.length} ${'views'.tr()}', 
              likeText: '${story.likes.length} ${"like".tr()}',
            );
          },
        ),
      ),
    );
  }
}