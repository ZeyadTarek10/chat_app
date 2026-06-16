import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/domain/repositories/social_repositories.dart';
import 'package:dartz/dartz.dart';

class GetPostsUseCase {
  final SocialRepositories socialRepositories;
  GetPostsUseCase({required this.socialRepositories});

  Stream<Either<Failure, List<SocialEntity>>> call() {
    return socialRepositories.getPosts();
  }
}