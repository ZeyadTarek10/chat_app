import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/post_details/domain/entities/comment_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CommentsRepository {
  Stream<Either<Failure, List<CommentEntity>>> getComments(String postId);
  Future<Either<Failure, void>> addComment(CommentEntity comment);
}