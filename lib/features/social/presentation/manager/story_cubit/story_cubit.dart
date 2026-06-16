import 'package:bloc/bloc.dart';
import 'package:chat_app/config/app/upload_image/domain/use_cases/upload_image_use_case.dart';
import 'package:chat_app/core/enum/story_type_enum.dart';
import 'package:chat_app/features/message/domain/use_cases/send_message_use_case.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:chat_app/features/social/domain/entities/story_entity.dart';
import 'package:chat_app/features/social/domain/use_cases/add_story_use_case.dart';
import 'package:chat_app/features/social/domain/use_cases/delete_story_use_case.dart';
import 'package:chat_app/features/social/domain/use_cases/get_story_use_case.dart';
import 'package:chat_app/features/social/domain/use_cases/update_story_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  final AddStoryUseCase addStoryUseCase;
  final DeleteStoryUseCase deleteStoryUseCase;
  final UpdateStoryUseCase updateStoryUseCase;
  final GetStoryUseCase getStoryUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  StoryCubit({
    required this.addStoryUseCase,
    required this.deleteStoryUseCase,
    required this.updateStoryUseCase,
    required this.getStoryUseCase,
    required this.uploadImageUseCase,
  }) : super(StoryInitial());

  XFile? currentDraftImage;
  int currentDraftColor = 0xFF000000;

  void updateStoryColor(int color) {
    currentDraftColor = color;
    emit(StoryDraftUpdated(
        selectedImage: currentDraftImage, selectedColor: currentDraftColor));
  }

  void updateStoryImage(XFile? image) {
    currentDraftImage = image;
    emit(StoryDraftUpdated(
        selectedImage: currentDraftImage, selectedColor: currentDraftColor));
  }

  void clearImageOrColorStory() {
    currentDraftImage = null;
    currentDraftColor = 0xFF000000;
  }

  void updateStoryIndex(int groupIndex, int storyIndex) {
    if (state is StoryLoaded) {
      emit((state as StoryLoaded).copyWith(
        currentGroupIndex: groupIndex,
        currentStoryIndex: storyIndex,
      ));
    }
  }

  void initDraft(StoryEntity? storyToEdit) {
  if (storyToEdit != null) {
    currentDraftColor = storyToEdit.backgroundColor;
    currentDraftImage = null; 
    emit(StoryDraftUpdated(
      selectedImage: currentDraftImage,
      selectedColor: currentDraftColor,
    ));
  } else {
    clearImageOrColorStory();
  }
}

  Future<void> fetchStoryUsersDetails(List<String> viewerIds,
      List<String> likerIds, GetUserByIdUseCase getUserUseCase) async {
    if (state is! StoryLoaded) return;
    final currentState = state as StoryLoaded;

    emit(currentState.copyWith(isUsersLoading: true));

    List<UserEntity> viewers = [];
    List<UserEntity> likes = [];

    for (String id in viewerIds) {
      final result = await getUserUseCase.call(id);
      result.fold((l) => null, (user) => viewers.add(user));
    }

    for (String id in likerIds) {
      final result = await getUserUseCase.call(id);
      result.fold((l) => null, (user) => likes.add(user));
    }

    emit(currentState.copyWith(
      viewersDetails: viewers,
      likesDetails: likes,
      isUsersLoading: false,
    ));
  }

  Future<void> fetchStories() async {
    emit(StoryLoading());
    final result = await getStoryUseCase();

    result.fold(
      (failure) => emit(StoryError(message: failure.massage)),
      (stories) {
        Map<String, List<StoryEntity>> grouped = {};
        for (var story in stories) {
          if (!grouped.containsKey(story.userId)) grouped[story.userId] = [];
          grouped[story.userId]!.add(story);
        }

        List<UserStoryGroup> finalGroups = grouped.entries
            .map((e) => UserStoryGroup(userId: e.key, stories: e.value))
            .toList();

        final myGroupIndex =
            finalGroups.indexWhere((g) => g.userId == currentUserId);
        if (myGroupIndex != -1) {
          final myGroup = finalGroups.removeAt(myGroupIndex);
          finalGroups.insert(0, myGroup);
        }

        emit(StoryLoaded(groupedStories: finalGroups));
      },
    );
  }

  Future<void> saveStory({
    required String text,
    String? storyIdToUpdate,
    XFile? selectedImage,
    String? existingImageUrl,
    required int selectedColor,
  }) async {
    emit(StoryActionLoading());

    String? finalImageUrl = existingImageUrl;

    if (selectedImage != null) {
      final imgResult = await uploadImageUseCase.call(selectedImage);

      bool hasError = false;
      imgResult.fold(
        (failure) {
          emit(StoryError(message: failure.massage));
          hasError = true;
        },
        (uploadEntity) {
          finalImageUrl = uploadEntity.photo;
        },
      );
      if (hasError) return;
    }

    final hasText = text.isNotEmpty;
    final hasImage = finalImageUrl != null;
    StoryType storyType = (hasText && hasImage)
        ? StoryType.both
        : (hasImage ? StoryType.image : StoryType.text);

    final story = StoryEntity(
      id: storyIdToUpdate ?? DateTime.now().millisecondsSinceEpoch.toString(),
      userId: currentUserId,
      type: storyType,
      text: hasText ? text : null,
      imageUrl: finalImageUrl,
      backgroundColor: selectedColor,
      createdAt: DateTime.now(),
      viewers: const [],
      likes: const [],
    );

    if (storyIdToUpdate != null) {
      final result = await updateStoryUseCase(story: story);
      result.fold(
        (failure) => emit(StoryError(message: failure.massage)),
        (_) => emit(StoryActionSuccess(message: "the_story_has_been_updated_successfully".tr())),
      );
    } else {
      final result = await addStoryUseCase(story: story);
      result.fold(
        (failure) => emit(StoryError(message: failure.massage)),
        (_) => emit(StoryActionSuccess(message: "the_story_was_posted_successfully".tr())),
      );
    }

    await fetchStories();
  }

  Future<void> removeStory(String storyId) async {
    emit(StoryActionLoading());
    final result = await deleteStoryUseCase(storyId: storyId);

    result.fold(
      (failure) => emit(StoryError(message: failure.massage)),
      (_) {
        emit(StoryActionSuccess(message: "the_story_has_been_deleted".tr()));
        fetchStories();
      },
    );
  }

  void markStoryAsViewed(StoryEntity story) {
    if (state is! StoryLoaded) return;
    if (story.viewers.contains(currentUserId)) return;

    final currentState = state as StoryLoaded;
    final updatedViewers = List<String>.from(story.viewers)..add(currentUserId);

    final updatedStory = story.copyWith(viewers: updatedViewers);

    final newGroups = currentState.groupedStories.map((group) {
      final newStories = group.stories
          .map((s) => s.id == story.id ? updatedStory : s)
          .toList();
      return UserStoryGroup(userId: group.userId, stories: newStories);
    }).toList();

    emit(StoryLoaded(groupedStories: newGroups));

    updateStoryUseCase(story: updatedStory);
  }

  Future<void> toggleLikeStory(StoryEntity story) async {
    if (state is! StoryLoaded) return;

    final currentState = state as StoryLoaded;
    List<String> updatedLikes = List.from(story.likes);

    if (updatedLikes.contains(currentUserId)) {
      updatedLikes.remove(currentUserId);
    } else {
      updatedLikes.add(currentUserId);
    }

    final updatedStory = story.copyWith(likes: updatedLikes);

    final newGroups = currentState.groupedStories.map((group) {
      final newStories = group.stories
          .map((s) => s.id == story.id ? updatedStory : s)
          .toList();
      return UserStoryGroup(userId: group.userId, stories: newStories);
    }).toList();

    emit(StoryLoaded(groupedStories: newGroups));

    await updateStoryUseCase(story: updatedStory);
  }
}
