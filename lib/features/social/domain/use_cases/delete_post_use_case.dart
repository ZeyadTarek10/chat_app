import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/social/domain/repositories/social_repositories.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  final SocialRepositories socialRepositories;
  const DeletePostUseCase({required this.socialRepositories});

  Future<Either<Failure, Unit>> call({required String postId}) async {
    return await socialRepositories.deletePost(postId);
  }
}