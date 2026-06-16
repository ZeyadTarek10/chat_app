import 'package:chat_app/features/social/domain/entities/story_entity.dart';
import 'package:chat_app/features/social/presentation/manager/story_cubit/story_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/icons_top_story_viewer.dart';

import 'package:chat_app/features/social/presentation/screens/widgets/linear_progress_indicator_story.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/reply_send_and_likes_story.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/show_me_views_and_likes_bottom_sheet_story.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/story_body_viewer_screen.dart';
import 'package:flutter/material.dart';

class StoryViewerScreenItem extends StatelessWidget {
  final StoryEntity story;
  final UserStoryGroup group;
  final int currentStoryIndex;
  final bool isMyStory;
  final bool isLikedByMe;
  final AnimationController animController;
  final TextEditingController replyController;
  final FocusNode replyFocusNode;

  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onShowViewers;
  final VoidCallback onLike;
  final VoidCallback onClose;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onSendReply;

  const StoryViewerScreenItem({
    super.key,
    required this.story,
    required this.group,
    required this.currentStoryIndex,
    required this.isMyStory,
    required this.isLikedByMe,
    required this.animController,
    required this.replyController,
    required this.replyFocusNode,
    required this.onNext,
    required this.onPrevious,
    required this.onPause,
    required this.onResume,
    required this.onShowViewers,
    required this.onLike,
    required this.onClose,
    required this.onDelete,
    required this.onEdit,
    required this.onSendReply,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTapDown: (details) {
            FocusScope.of(context).unfocus();
            final screenWidth = MediaQuery.of(context).size.width;
            final dx = details.globalPosition.dx;
            final isRTL = Directionality.of(context) == TextDirection.rtl;
            final isTapOnLeft = dx < screenWidth / 3;

            if (isRTL) {
              if (isTapOnLeft) {
                onNext();
              } else {
                onPrevious();
              }
            } else {
              if (isTapOnLeft) {
                onPrevious();
              } else {
                onNext();
              }
            }
          },
          onLongPressDown: (_) => onPause(),
          onLongPressUp: () => onResume(),
          child: StoryBodyViewerScreen(story: story),
        ),
        Positioned(
          top: 10,
          left: 10,
          right: 10,
          child: LinearProgressIndicatorStory(
              group: group,
              animController: animController,
              currentStoryIndex: currentStoryIndex),
        ),
        Positioned(
          top: 25,
          right: 10,
          left: 10,
          child: IconsTopStoryViewer(
              onClose: onClose,
              isMyStory: isMyStory,
              onDelete: onDelete,
              onEdit: onEdit),
        ),
        if (isMyStory)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: ShowMeViewsAndLikesBottomSheetStory(
                onShowViewers: onShowViewers, story: story),
          )
        else
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: ReplySendAndLikesStory(
                replyController: replyController,
                replyFocusNode: replyFocusNode,
                onSendReply: onSendReply,
                isLikedByMe: isLikedByMe,
                onLike: onLike),
          ),
      ],
    );
  }
}




