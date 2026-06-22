import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/social/domain/entities/story_entity.dart';
import 'package:chat_app/features/social/domain/repositories/story_repositories.dart';
import 'package:dartz/dartz.dart';

class UpdateStoryUseCase {
  final StoryRepository storyRepository;
  UpdateStoryUseCase({required this.storyRepository});

  Future<Either<Failure, Unit>> call({required StoryEntity story}) async {
    return await storyRepository.updateStory(story);
  }
}
