import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/config/app/upload_image/domain/use_cases/upload_image_use_case.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:chat_app/features/social/data/data_source/social_remote_data_source.dart';
import 'package:chat_app/features/social/data/models/social_model.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/domain/use_cases/add_post_use_case.dart';
import 'package:chat_app/features/social/domain/use_cases/delete_post_use_case.dart';
import 'package:chat_app/features/social/domain/use_cases/get_current_location_use_case.dart';
import 'package:chat_app/features/social/domain/use_cases/get_post_use_case.dart';
import 'package:chat_app/features/social/domain/use_cases/like_post_use_case.dart';
import 'package:chat_app/features/social/domain/use_cases/update_post_use_case.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  final GetPostsUseCase getPostsUseCase;
  final AddPostUseCase addPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final SocialRemoteDataSource remoteDataSource;
  final LikePostUseCase likePostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final GetCurrentLocationUseCase getCurrentLocationUseCase;
  StreamSubscription? _postsSubscription;
  final TextEditingController textController = TextEditingController();
  bool isLocationLoading = false;
  Set<String> sentUserIds = {};

  SocialCubit({
    required this.getPostsUseCase,
    required this.addPostUseCase,
    required this.remoteDataSource,
    required this.updatePostUseCase,
    required this.uploadImageUseCase,
    required this.deletePostUseCase,
    required this.likePostUseCase,
    required this.getCurrentLocationUseCase,
  }) : super(SocialInitial());

  List<SocialEntity> allPosts = [];
  String currentLocation = "";
  XFile? selectedImage;
  String? uploadedImageUrl;

  void resetPostData() {
    currentLocation = "";
    selectedImage = null;
    uploadedImageUrl = null;
    textController.clear();
  }

  Future <void> fetchPosts() async {
    emit(SocialLoading());
    _postsSubscription = getPostsUseCase().listen(
      (result) {
        result.fold(
          (failure) => emit(SocialError(failure.massage)),
          (posts) {
            allPosts = posts;
            emit(SocialLoaded(allPosts));
          },
        );
      },
    );
  }

  Future <void> createNewPost(String text, UserEntity currentUser) async {
    emit(SocialLoading());
    final newPost = SocialEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: currentUser.uid,
      userName: currentUser.name,
      userImage: currentUser.profilePicUrl,
      postText: text,
      postImage: uploadedImageUrl,
      location: currentLocation,
      time: DateTime.now(),
      likesCount: 0,
      commentsCount: 0,
    );

    final result = await addPostUseCase(post: newPost);
    result.fold(
      (failure) => emit(SocialError(failure.massage)),
      (_) {
        resetPostData();
        emit(SocialActionSuccess());
      },
    );
  }

  Future <void> updatePost(SocialEntity oldPost, String newText) async {
    emit(SocialLoading());
    final updatedPost = SocialEntity(
      id: oldPost.id,
      userId: oldPost.userId,
      userName: oldPost.userName,
      userImage: oldPost.userImage,
      postText: newText,
      postImage: uploadedImageUrl ?? oldPost.postImage,
      time: oldPost.time,
      likesCount: oldPost.likesCount,
      likedBy: oldPost.likedBy,
      commentsCount: oldPost.commentsCount,
      location: currentLocation.isEmpty ? oldPost.location : currentLocation,
    );

    final result = await updatePostUseCase(updatedPost);
    result.fold(
      (failure) => emit(SocialError(failure.massage)),
      (_) {
        resetPostData();
        emit(SocialActionSuccess());
      },
    );
  }

  void initEditData(SocialEntity post) {
    textController.text = post.postText;
    currentLocation = post.location ?? "";
    uploadedImageUrl = post.postImage;
    selectedImage = null;
  }

  Future <void> deletePost(String postId) async {
    emit(SocialLoading());

    final result = await deletePostUseCase(postId: postId);

    result.fold(
      (failure) => emit(
        SocialError(failure.massage),
      ),
      (_) {},
    );
  }

   Future<void> toggleLikePost(SocialEntity post, String currentUserId) async {
    final postIndex = allPosts.indexWhere((p) => p.id == post.id);
    if (postIndex == -1) return;

    final isLiked = post.likedBy.contains(currentUserId);
    final updatedLikedBy = List<String>.from(post.likedBy);

    isLiked
        ? updatedLikedBy.remove(currentUserId)
        : updatedLikedBy.add(currentUserId);
    final updatedLikesCount = (post.likesCount ?? 0) + (isLiked ? -1 : 1);

    allPosts[postIndex] = (post as SocialModel).copyWith(
      likesCount: updatedLikesCount,
      likedBy: updatedLikedBy,
    );

    emit(SocialLoaded(List.from(allPosts)));

    final result = await likePostUseCase(
      postId: post.id,
      userId: currentUserId,
      isLiked: isLiked,
    );

    result.fold(
      (failure) {
        emit(SocialError(failure.massage));
      },
      (success) {},
    );
  }

  Future <void> uploadSelectedImage(XFile image) async {
    selectedImage = image;
    emit(SocialImageUploading());

    final imageResult = await uploadImageUseCase(image);
    imageResult.fold(
      (failure) => emit(SocialError(failure.massage)),
      (uploadModel) {
        uploadedImageUrl = uploadModel.photo;
        emit(SocialImageUploaded());
      },
    );
  }

  Future <void> fetchLocation() async {
    emit(SocialLocationLoading());
    final result = await getCurrentLocationUseCase();
    result.fold((failure) => emit(SocialError(failure.massage)), (location) {
      currentLocation = location;
      emit(SocialLocationFetched());
    });
  }

  void markPostAsSent(String id) {
    sentUserIds.add(id);
    if (state is SocialLoaded) {
      emit(SocialLoaded(List.from(allPosts)));
    }
  }

  void clearSentUserIds() {
    sentUserIds.clear();
  }

  @override
  Future<void> close() {
    textController.dispose();
    _postsSubscription?.cancel();
    return super.close();
  }
}
