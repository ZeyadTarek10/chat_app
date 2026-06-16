import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/enum/alert_enum.dart';
import 'package:chat_app/core/services/alert_service.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/message/domain/use_cases/send_message_use_case.dart';
import 'package:chat_app/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat_app/features/social/presentation/manager/story_cubit/story_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/story_bottom_sheet.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/story_viewer_screen_item.dart';
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
  late PageController _pageController;
  late AnimationController _animController;
  final TextEditingController _replyController = TextEditingController();
  final FocusNode _replyFocusNode = FocusNode();

  late int currentGroupIndex;
  int currentStoryIndex = 0;

  @override
  void initState() {
    super.initState();
    currentGroupIndex = widget.initialGroupIndex;
    _pageController = PageController(initialPage: currentGroupIndex);
    _animController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextStory();
      }
    });

    _replyFocusNode.addListener(() {
      if (_replyFocusNode.hasFocus) {
        _animController.stop();
      } else {
        _animController.forward();
      }
    });

    _animController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _recordCurrentStoryView();
    });
  }

  void _recordCurrentStoryView() {
    if (!mounted) return;
    final cubit = context.read<StoryCubit>();
    if (cubit.state is StoryLoaded) {
      final groups = (cubit.state as StoryLoaded).groupedStories;
      if (currentGroupIndex < groups.length &&
          currentStoryIndex < groups[currentGroupIndex].stories.length) {
        final story = groups[currentGroupIndex].stories[currentStoryIndex];
        cubit.markStoryAsViewed(story);
      }
    }
  }

  void _nextStory() {
    final cubit = context.read<StoryCubit>();
    if (cubit.state is StoryLoaded) {
      final groups = (cubit.state as StoryLoaded).groupedStories;

      if (currentStoryIndex < groups[currentGroupIndex].stories.length - 1) {
        setState(() => currentStoryIndex++);
        _resetTimer();
        _recordCurrentStoryView();
      } else if (currentGroupIndex < groups.length - 1) {
        setState(() {
          currentGroupIndex++;
          currentStoryIndex = 0;
        });
        _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
        _resetTimer();
        _recordCurrentStoryView();
      } else {
        if (mounted) {
          GoRouter.of(context).pop();
        }
      }
    }
  }

  void _previousStory() {
    if (currentStoryIndex > 0) {
      setState(() => currentStoryIndex--);
      _resetTimer();
      _recordCurrentStoryView();
    } else if (currentGroupIndex > 0) {
      final cubit = context.read<StoryCubit>();
      final groups = (cubit.state as StoryLoaded).groupedStories;

      setState(() {
        currentGroupIndex--;
        currentStoryIndex = groups[currentGroupIndex].stories.length - 1;
      });
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      _resetTimer();
      _recordCurrentStoryView();
    } else {
      if (mounted) {
        if (GoRouter.of(context).canPop()) {
          GoRouter.of(context).pop();
        } else {
          GoRouter.of(context).go('/');
        }
      }
    }
  }

  void _resetTimer() {
    _animController.reset();
    _animController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    _replyController.dispose();
    _replyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit, StoryState>(
      buildWhen: (previous, current) =>
          current is StoryLoaded || current is StoryLoading,
      builder: (context, state) {
        if (state is! StoryLoaded || state.groupedStories.isEmpty) {
          return const Scaffold(
              backgroundColor: ColorsLight.black,
              body: Center(child: CircularProgressIndicator()));
        }

        final groups = state.groupedStories;
        final cubit = context.read<StoryCubit>();

        return Scaffold(
          backgroundColor: ColorsLight.black,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentGroupIndex = index;
                  currentStoryIndex = 0;
                });
                _resetTimer();
                _recordCurrentStoryView();
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
                  animController: _animController,
                  replyController: _replyController,
                  replyFocusNode: _replyFocusNode,
                  onNext: _nextStory,
                  onPrevious: _previousStory,
                  onPause: () => _animController.stop(),
                  onResume: () => _animController.forward(),
                  onLike: () => cubit.toggleLikeStory(story),
                  onShowViewers: () => StoryBottomSheetHelper.show(
                      context: context,
                      story: story,
                      storyCubit: cubit,
                      animController: _animController),
                  onClose: () {
                    if (GoRouter.of(context).canPop()) {
                      GoRouter.of(context).pop();
                    } else {
                      GoRouter.of(context).pop();
                    }
                  },
                  onDelete: () {
                    cubit.removeStory(story.id);
                    if (mounted) Navigator.pop(context);
                  },
                  onEdit: () {
                    _animController.stop();
                    GoRouter.of(context).pushReplacement(
                      AppRoutes.createOrEditStory,
                      extra: {
                        'cubit': cubit,
                        'storyToEdit': story,
                      },
                    );
                  },
                  onSendReply: () async {
                    if (_replyController.text.isNotEmpty) {
                      FocusScope.of(context).unfocus();

                      final messageCubit = getIt<MessageCubit>();
                      final getUserUseCase = getIt<GetUserByIdUseCase>();

                      String fetchedOwnerName = 'unknown'.tr();
                      final ownerResult =
                          await getUserUseCase.call(story.userId);
                      ownerResult.fold((failure) => null,
                          (user) => fetchedOwnerName = user.name);

                      String fetchedMyName = 'me'.tr();
                      final myResult =
                          await getUserUseCase.call(cubit.currentUserId);
                      myResult.fold((failure) => null,
                          (user) => fetchedMyName = user.name);

                      messageCubit.sendStoryReplyMessage(
                        friendId: story.userId,
                        messageText: _replyController.text,
                        story: story,
                        myName: fetchedMyName,
                        storyOwnerName: fetchedOwnerName,
                      );

                      _replyController.clear();
                      AlertService().showAlert(
                          context: context,
                          subtitle: "${"the_reply_has_been_sent_as_a_message_to".tr()} $fetchedOwnerName",
                          status: AlertStatus.success);
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
