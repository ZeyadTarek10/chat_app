import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/domain/repositories/social_repositories.dart';
import 'package:dartz/dartz.dart';

class AddPostUseCase {
  final SocialRepositories socialRepositories;
  const AddPostUseCase({required this.socialRepositories});

  Future<Either<Failure, Unit>> call({required SocialEntity post}) async {
    return await socialRepositories.addPost(post);
  }
}