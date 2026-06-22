import 'dart:async';

import 'package:chat_app/features/post_details/domain/entities/comment_entity.dart';
import 'package:chat_app/features/post_details/domain/use_case/add_comment_usecase.dart';
import 'package:chat_app/features/post_details/domain/use_case/get_comments_usecase.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final GetCommentsUseCase getCommentsUseCase;
  final AddCommentUseCase addCommentUseCase;
  StreamSubscription? _commentsSubscription;

  final TextEditingController commentController = TextEditingController();
  List<CommentEntity> allComments = [];

  CommentsCubit(
      {required this.getCommentsUseCase, required this.addCommentUseCase})
      : super(CommentsInitial());

  void fetchComments(String postId) async {
    emit(CommentsLoading());
    _commentsSubscription?.cancel();
    _commentsSubscription = getCommentsUseCase(postId).listen(
      (result) {
        result.fold(
          (failure) => emit(CommentsError(failure.massage)),
          (comments) {
            emit(CommentsLoaded(comments));
          },
        );
      },
    );
  }

  void addComment(
      String text, SocialEntity post, UserEntity currentUser) async {
    final newComment = CommentEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      postId: post.id,
      userId: currentUser.uid,
      userName: currentUser.name,
      userImage: currentUser.profilePicUrl ?? '',
      commentText: text,
      time: DateTime.now(),
    );

    final result = await addCommentUseCase(newComment);
    result.fold(
      (failure) => emit(CommentsError(failure.massage)),
      (_) {
        commentController.clear();
      },
    );
  }

  @override
  Future<void> close() {
    commentController.dispose();
    _commentsSubscription?.cancel();
    return super.close();
  }
}
