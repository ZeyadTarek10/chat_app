import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/network/netwok_info.dart';
import 'package:chat_app/features/post_details/data/data_sources/comments_remote_data_source.dart';
import 'package:chat_app/features/post_details/data/model/comment_model.dart';
import 'package:chat_app/features/post_details/domain/entities/comment_entity.dart';
import 'package:chat_app/features/post_details/domain/repositories/comments_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CommentsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Stream<Either<Failure, List<CommentEntity>>> getComments(
      String postId) async* {
    if (await networkInfo.isConnected) {
      try {
        yield* remoteDataSource
            .getComments(postId)
            .map<Either<Failure, List<CommentEntity>>>(
              (comments) => Right(comments),
            );
      } catch (error) {
        yield Left(ServerFailure(error.toString()));
      }
    } else {
      yield Left(CacheFailure("no_internet_connection".tr()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addComment(CommentEntity comment) async {
    if (await networkInfo.isConnected) {
      try {
        final commentModel = CommentModel(
          id: comment.id,
          postId: comment.postId,
          userId: comment.userId,
          userName: comment.userName,
          userImage: comment.userImage,
          commentText: comment.commentText,
          time: comment.time,
        );

        await remoteDataSource.addComment(commentModel);
        return const Right(unit);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(CacheFailure("no_internet_connection".tr()));
    }
  }
}
