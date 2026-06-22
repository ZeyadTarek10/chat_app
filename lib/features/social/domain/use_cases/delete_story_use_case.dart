import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/social/domain/repositories/story_repositories.dart';
import 'package:dartz/dartz.dart';

class DeleteStoryUseCase {
  final StoryRepository storyRepository;
  DeleteStoryUseCase({required this.storyRepository});

  Future<Either<Failure, Unit>> call({required String storyId}) async {
    return await storyRepository.deleteStory(storyId);
  }
}
