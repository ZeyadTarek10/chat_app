import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/network/netwok_info.dart';
import 'package:chat_app/features/social/data/data_source/social_remote_data_source.dart';
import 'package:chat_app/features/social/data/models/social_model.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/domain/repositories/social_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

class SocialRepositoriesImpl implements SocialRepositories {
  final NetworkInfo networkInfo;
  final SocialRemoteDataSource remoteDataSource;

  SocialRepositoriesImpl(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Stream<Either<Failure, List<SocialEntity>>> getPosts() async* {
    if (await networkInfo.isConnected) {
      try {
        yield* remoteDataSource
            .getPosts()
            .map<Either<Failure, List<SocialEntity>>>(
              (posts) => Right(posts),
            );
      } catch (error) {
        yield Left(ServerFailure(error.toString()));
      }
    } else {
      yield Left(CacheFailure("no_internet_connection".tr()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(SocialEntity post) async {
    if (await networkInfo.isConnected) {
      try {
        final postModel = SocialModel(
          id: post.id,
          userId: post.userId,
          userName: post.userName,
          userImage: post.userImage,
          postText: post.postText,
          postImage: post.postImage,
          time: post.time,
          commentsCount: post.commentsCount,
          likesCount: post.likesCount,
          location: post.location,
          likedBy: post.likedBy,
        );
        await remoteDataSource.addPost(postModel);
        return const Right(unit);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(CacheFailure("no_internet_connection".tr()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(SocialEntity post) async {
    if (await networkInfo.isConnected) {
      try {
        final postModel = SocialModel(
          id: post.id,
          userId: post.userId,
          userName: post.userName,
          userImage: post.userImage,
          postText: post.postText,
          postImage: post.postImage,
          time: post.time,
          commentsCount: post.commentsCount,
          likesCount: post.likesCount,
          location: post.location,
          likedBy: post.likedBy,
        );
        await remoteDataSource.updatePost(postModel);
        return const Right(unit);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(CacheFailure("no_internet_connection".tr()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(String postId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deletePost(postId);
        return const Right(unit);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(CacheFailure("no_internet_connection".tr()));
    }
  }

  @override
  Future<Either<Failure, Unit>> likePost(
      String postId, String userId, bool isLiked) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.likePost(postId, userId, isLiked);
        return const Right(unit);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(CacheFailure("no_internet_connection".tr()));
    }
  }

  @override
  Future<Either<Failure, String>> getCurrentLocation() async {
    if (await networkInfo.isConnected) {
      try {
        final location = await remoteDataSource.getCurrentLocation();
        return Right(location);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(CacheFailure("no_internet_connection".tr()));
    }
  }
}
