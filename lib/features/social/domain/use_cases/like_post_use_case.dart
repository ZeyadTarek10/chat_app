import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/social/domain/repositories/social_repositories.dart';
import 'package:dartz/dartz.dart';

class LikePostUseCase {
  final SocialRepositories socialRepositories;
  const LikePostUseCase({required this.socialRepositories});

  Future<Either<Failure, Unit>> call(
      {required String postId,
      required String userId,
      required bool isLiked}) async {
    return await socialRepositories.likePost(postId, userId, isLiked);
  }
}
