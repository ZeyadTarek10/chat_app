import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/enum/alert_enum.dart';
import 'package:chat_app/core/services/alert_service.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat_app/features/social/presentation/manager/story_cubit/story_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/stories/story_bottom_sheet.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/stories/story_viewer_screen_item.dart';
import 'package:chat_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class StoryViewerScreen extends StatefulWidget {
  final int initialGroupIndex;
  const StoryViewerScreen({super.key, required this.initialGroupIndex});

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen>
    with SingleTickerProviderStateMixin {
  late final StoryCubit _storyCubit;

  @override
  void initState() {
    super.initState();
    _storyCubit = context.read<StoryCubit>();
    _storyCubit.initControllers(this, widget.initialGroupIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _storyCubit.recordCurrentStoryView();
    });
  }

  @override
  void dispose() {
    _storyCubit.disposeControllers();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StoryCubit>();

    return BlocConsumer<StoryCubit, StoryState>(
      listener: (context, state) {
        if (state is StoryFinished) {
          if (GoRouter.of(context).canPop()) {
            GoRouter.of(context).pop();
          } else {
            GoRouter.of(context).go('/');
          }
        }
        if (state is StoryActionSuccess) {
          AlertService().showAlert(
            context: context,
            subtitle: state.message,
            status: AlertStatus.success,
          );
        }
      },
      builder: (context, state) {
        if (state is! StoryLoaded || state.groupedStories.isEmpty) {
          return const Scaffold(
            backgroundColor: ColorsLight.black,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final groups = state.groupedStories;
        final currentGroupIndex = state.currentGroupIndex;
        final currentStoryIndex = state.currentStoryIndex;

        return Scaffold(
          backgroundColor: ColorsLight.black,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: PageView.builder(
              controller: cubit.pageController,
              onPageChanged: (index) {
                cubit.updateStoryIndex(index, 0);
                cubit.resetTimer();
                cubit.recordCurrentStoryView();
              },
              itemCount: groups.length,
              itemBuilder: (context, pageIndex) {
                final group = groups[pageIndex];

                final storyIndexToShow =
                    (pageIndex == currentGroupIndex) ? currentStoryIndex : 0;

                final safeStoryIndex = storyIndexToShow < group.stories.length
                    ? storyIndexToShow
                    : 0;
                final story = group.stories[safeStoryIndex];

                final isMyStory = story.userId == cubit.currentUserId;
                final isLikedByMe = story.likes.contains(cubit.currentUserId);

                return StoryViewerScreenItem(
                  story: story,
                  group: group,
                  currentStoryIndex: safeStoryIndex,
                  isMyStory: isMyStory,
                  isLikedByMe: isLikedByMe,
                  animController: cubit.animController!,
                  replyController: cubit.replyController,
                  replyFocusNode: cubit.replyFocusNode,
                  onNext: () => cubit.nextStory(),
                  onPrevious: () => cubit.previousStory(),
                  onPause: () => cubit.pauseTimer(),
                  onResume: () => cubit.resumeTimer(),
                  onLike: () => cubit.toggleLikeStory(story),
                  onShowViewers: () => StoryBottomSheetHelper.show(
                      context: context,
                      story: story,
                      storyCubit: cubit,
                      animController: cubit.animController!),
                  onClose: () {
                    if (GoRouter.of(context).canPop()) {
                      GoRouter.of(context).pop();
                    } else {
                      GoRouter.of(context).go('/');
                    }
                  },
                  onDelete: () {
                    cubit.removeStory(story.id);
                    if (mounted) Navigator.pop(context);
                  },
                  onEdit: () {
                    cubit.pauseTimer();
                    cubit.initDraft(story);
                    GoRouter.of(context).pushReplacement(
                      AppRoutes.createOrEditStory,
                      extra: {
                        'cubit': cubit,
                        'storyToEdit': story,
                      },
                    );
                  },
                  onSendReply: () async {
                    if (cubit.replyController.text.isNotEmpty) {
                      FocusScope.of(context).unfocus();
                      final ownerName = await cubit.sendStoryReply(
                        story: story,
                        replyText: cubit.replyController.text,
                        messageCubit: getIt<MessageCubit>(),
                      );
                      cubit.replyController.clear();
                      if (ownerName != null && mounted) {
                        AlertService().showAlert(
                          context: context,
                          subtitle:
                              "${"the_reply_has_been_sent_as_a_message_to".tr()} $ownerName",
                          status: AlertStatus.success,
                        );
                      }
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
