import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/network/netwok_info.dart';
import 'package:chat_app/features/social/data/data_source/story_remote_data_source.dart';
import 'package:chat_app/features/social/data/models/story_model.dart';
import 'package:chat_app/features/social/domain/entities/story_entity.dart';
import 'package:chat_app/features/social/domain/repositories/story_repositories.dart';
import 'package:dartz/dartz.dart';

class StoryRepositoryImpl implements StoryRepository {
  final StoryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  StoryRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Unit>> addStory(StoryEntity story) async {
    if (await networkInfo.isConnected) {
      try {
        final model = StoryModel(
          id: story.id,
          userId: story.userId,
          type: story.type,
          text: story.text,
          imageUrl: story.imageUrl,
          createdAt: story.createdAt,
          backgroundColor: story.backgroundColor, 
          viewers: story.viewers, 
          likes: story.likes,
        );
        await remoteDataSource.uploadStory(model);
        return const Right(unit);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(
          CacheFailure("no_internet_connection")); 
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteStory(String storyId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteStory(storyId);
        return const Right(unit);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(CacheFailure("no_internet_connection"));
    }
  }

  @override
  Future<Either<Failure, List<StoryEntity>>> getStories() async {
    if (await networkInfo.isConnected) {
      try {
        final stories = await remoteDataSource.fetchStories();
        return Right(stories); 
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(CacheFailure("no_internet_connection"));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateStory(StoryEntity story) async {
    if (await networkInfo.isConnected) {
      try {
        final model = StoryModel(
          id: story.id,
          userId: story.userId,
          type: story.type,
          text: story.text,
          imageUrl: story.imageUrl,
          createdAt: story.createdAt, 
          backgroundColor: story.backgroundColor,
          viewers: story.viewers, 
          likes: story.likes,
        );
        await remoteDataSource.uploadStory(model);
        return const Right(unit);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(CacheFailure("no_internet_connection"));
    }
  }
}
