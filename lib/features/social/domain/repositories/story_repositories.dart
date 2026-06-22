import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/social/domain/entities/story_entity.dart';
import 'package:dartz/dartz.dart';

abstract class StoryRepository {
  Future<Either<Failure, Unit>> addStory(StoryEntity story);
  Future<Either<Failure, Unit>> updateStory(StoryEntity story);
  Future<Either<Failure, Unit>> deleteStory(String storyId);
  Future<Either<Failure, List<StoryEntity>>> getStories();
}