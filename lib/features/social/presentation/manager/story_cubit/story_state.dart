part of 'story_cubit.dart';

@immutable
abstract class StoryState {}

class StoryInitial extends StoryState {}
class StoryLoading extends StoryState {}

class StoryLoaded extends StoryState {
  final List<UserStoryGroup> groupedStories;
  final int currentGroupIndex;
  final int currentStoryIndex;
  
  final List<UserEntity> viewersDetails;
  final List<UserEntity> likesDetails;
  final bool isUsersLoading;

  StoryLoaded({
    required this.groupedStories,
    this.currentGroupIndex = 0,
    this.currentStoryIndex = 0,
    this.viewersDetails = const [], 
    this.likesDetails = const [],   
    this.isUsersLoading = false,    
  });

 StoryLoaded copyWith({
    List<UserStoryGroup>? groupedStories,
    int? currentGroupIndex,
    int? currentStoryIndex,
    List<UserEntity>? viewersDetails,
    List<UserEntity>? likesDetails,
    bool? isUsersLoading,
  }) {
    return StoryLoaded(
      groupedStories: groupedStories ?? this.groupedStories,
      currentGroupIndex: currentGroupIndex ?? this.currentGroupIndex,
      currentStoryIndex: currentStoryIndex ?? this.currentStoryIndex,
      viewersDetails: viewersDetails ?? this.viewersDetails,
      likesDetails: likesDetails ?? this.likesDetails,
      isUsersLoading: isUsersLoading ?? this.isUsersLoading,
    );
  }
}

class StoryDraftUpdated extends StoryState {
  final XFile? selectedImage;
  final int selectedColor;
  StoryDraftUpdated({this.selectedImage, required this.selectedColor});
}

class StoryActionLoading extends StoryState {}
class StoryActionSuccess extends StoryState {
  final String message;
  StoryActionSuccess({required this.message});
}
class StoryError extends StoryState {
  final String message;
  StoryError({required this.message});
}

class UserStoryGroup {
  final String userId;
  final List<StoryEntity> stories;
  UserStoryGroup({required this.userId, required this.stories});
}
