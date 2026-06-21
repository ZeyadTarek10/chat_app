import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/social/presentation/manager/story_cubit/story_cubit.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CircleAvatarTrendingGroup extends StatelessWidget {
  final UserStoryGroup group;
  final bool isMyGroup;
  final int groupIndex;

  const CircleAvatarTrendingGroup({
    super.key,
    required this.group,
    required this.isMyGroup,
    required this.groupIndex,
  });

  @override
  Widget build(BuildContext context) {
    final lastStory = group.stories.last;
    final cubit = context.read<StoryCubit>();

    final isCompletelyViewed = group.stories
        .every((story) => story.viewers.contains(cubit.currentUserId));

    final borderColor = isMyGroup
        ? ColorsLight.mainTextColor
        : (isCompletelyViewed
            ? ColorsLight.mainTextColor
            : ColorsDark.blueLight2);

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(
          AppRoutes.viewsStory,
          extra: {
            'cubit': cubit,
            'initialGroupIndex': groupIndex,
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 37.r,
              backgroundColor: borderColor,
              child: Container(
                width: 70.r,
                height: 70.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(lastStory.backgroundColor),
                ),
                clipBehavior: Clip.antiAlias,
                child: lastStory.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: lastStory.imageUrl!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.photo_size_select_actual_outlined,
                          color: Colors.white54,
                          size: 30,
                        ),
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : (lastStory.text != null
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CustomTextWidget(
                                text: lastStory.text!,
                                maxLines: 1,
                                textStyle: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorsDark.white,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                        : null),
              ),
            ),
            if (isMyGroup)
              Positioned(
                bottom: 10,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    cubit.initDraft(null);

                    GoRouter.of(context).push(
                      AppRoutes.createOrEditStory,
                      extra: {
                        'cubit': cubit,
                        'storyToEdit': null,
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 12.r,
                    backgroundColor: ColorsDark.blueLight2,
                    child: Icon(Icons.add, size: 16.r, color: ColorsDark.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
