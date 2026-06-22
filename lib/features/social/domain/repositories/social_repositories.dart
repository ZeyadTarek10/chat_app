import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SocialRepositories {
  Stream<Either<Failure, List<SocialEntity>>> getPosts();
  Future<Either<Failure, Unit>> addPost(SocialEntity post);
  Future<Either<Failure, Unit>> updatePost(SocialEntity post);
  Future<Either<Failure, Unit>> deletePost(String postId);
  Future<Either<Failure, Unit>> likePost(String postId, String userId, bool isLiked);
  Future<Either<Failure, String>> getCurrentLocation();
}
