import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/social/domain/entities/story_entity.dart';
import 'package:chat_app/features/social/domain/repositories/story_repositories.dart';
import 'package:dartz/dartz.dart';

class GetStoryUseCase {
  final StoryRepository storyRepository;
  GetStoryUseCase({required this.storyRepository});

  Future<Either<Failure, List<StoryEntity>>> call() async {
    return await storyRepository.getStories();
  }
}
