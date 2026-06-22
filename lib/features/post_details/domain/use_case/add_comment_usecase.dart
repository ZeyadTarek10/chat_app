import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/post_details/domain/entities/comment_entity.dart';
import 'package:chat_app/features/post_details/domain/repositories/comments_repository.dart';
import 'package:dartz/dartz.dart';

class AddCommentUseCase {
  final CommentsRepository commentsRepository;

  AddCommentUseCase({required this.commentsRepository});

  Future<Either<Failure, void>> call(CommentEntity comment) async {
    return await commentsRepository.addComment(comment);
  }
}