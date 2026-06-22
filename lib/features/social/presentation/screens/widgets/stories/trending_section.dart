import 'package:chat_app/features/social/presentation/manager/story_cubit/story_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/stories/add_story_button_empty.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/stories/circle_avatar_trinding_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: BlocBuilder<StoryCubit, StoryState>(
        builder: (context, state) {
          if (state is StoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is! StoryLoaded) {
            return const SizedBox.shrink();
          }

          final cubit = context.read<StoryCubit>();
          final groups = state.groupedStories;

          final myGroupIndex =
              groups.indexWhere((g) => g.userId == cubit.currentUserId);
          final hasMyStory = myGroupIndex != -1;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
            itemCount: hasMyStory ? groups.length : groups.length + 1,
            itemBuilder: (context, index) {
              if (!hasMyStory && index == 0) {
                return const AddStoryButtonEmpty();
              }

              final actualIndex = hasMyStory ? index : index - 1;
              final group = groups[actualIndex];
              final isMyGroup = group.userId == cubit.currentUserId;

              return CircleAvatarTrendingGroup(
                group: group,
                isMyGroup: isMyGroup,
                groupIndex: actualIndex,
              );
            },
          );
        },
      ),
    );
  }
}

