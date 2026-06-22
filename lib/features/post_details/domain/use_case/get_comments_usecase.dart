import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/post_details/domain/entities/comment_entity.dart';
import 'package:chat_app/features/post_details/domain/repositories/comments_repository.dart';
import 'package:dartz/dartz.dart';

class GetCommentsUseCase {
  final CommentsRepository commentsRepository;

  GetCommentsUseCase({required this.commentsRepository});

  Stream<Either<Failure, List<CommentEntity>>> call(String postId) {
    return commentsRepository.getComments(postId);
  }
}