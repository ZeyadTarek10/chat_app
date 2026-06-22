part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

final class CommentsLoading extends CommentsState {}

final class CommentsLoaded extends CommentsState {
  final List<CommentEntity> comments;
  CommentsLoaded(this.comments);
}

final class CommentsError extends CommentsState {
  final String message;
  CommentsError(this.message);
}

final class CommentAddedSuccess extends CommentsState {}