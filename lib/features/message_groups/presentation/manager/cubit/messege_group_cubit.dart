import 'dart:async';
import 'dart:convert';
import 'package:chat_app/config/app/upload_image/domain/use_cases/upload_image_use_case.dart';
import 'package:chat_app/config/app/upload_image/presentation/screens/widgets/image_pick.dart';
import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/core/mixins/attachment_sender_mixin.dart';
import 'package:chat_app/core/services/contact_service.dart';
import 'package:chat_app/core/services/location_service.dart';
import 'package:chat_app/features/groups/domain/repositories/groups_repository.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message_groups/domain/repositories/message_groups_repositories.dart';
import 'package:chat_app/features/message_groups/domain/use_cases/send_group_massege_use_case.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'messege_group_state.dart';

class MessegeGroupCubit extends Cubit<MessegeGroupState> with AttachmentSenderMixin{
  final SendGroupMessageUseCase sendMessageUseCase;
  final MessageGroupsRepository repository;
  final GroupsRepository groupsRepository;
  final TextEditingController controller = TextEditingController();
  final ScrollController controller0 = ScrollController();
  final UploadImageUseCase uploadImageUseCase;
  @override
  final LocationService locationService;
  @override
  final ContactService contactService;

  StreamSubscription? _messagesSubscription;

  MessegeGroupCubit(
      {required this.sendMessageUseCase,
      required this.repository,
      required this.uploadImageUseCase,
      required this.groupsRepository,
      required this.locationService,
      required this.contactService})
      : super(MessegeGroupInitial());

  void getMessages(String groupId) {
    _messagesSubscription?.cancel();

    groupsRepository.resetGroupUnreadCount(groupId);

    _messagesSubscription =
        repository.getGroupMessages(groupId).listen((result) {
      result.fold(
        (failure) => emit(MessegeGroupError(error: failure.massage)),
        (messages) {
          final myUid = FirebaseAuth.instance.currentUser?.uid;

          for (var msg in messages) {
            if (msg.fromId != myUid &&
                (msg.read == null || msg.read!.isEmpty)) {
              repository.markMessageAsRead(groupId, msg.id!);
            }
          }

          emit(MessegeGroupLoaded(messages: messages));
        },
      );
    });
  }

  void selectReplyMessage(MessageEntity message) {
    if (state is MessegeGroupLoaded) {
      emit((state as MessegeGroupLoaded).copyWith(replyMessage: message));
    }
  }

  void cancelReply() {
    if (state is MessegeGroupLoaded) {
      emit((state as MessegeGroupLoaded).copyWith(clearReply: true));
    }
  }

  Future<void> sendGroupTextMessage(String groupId) async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    MessageEntity? currentReply;
    if (state is MessegeGroupLoaded) {
      currentReply = (state as MessegeGroupLoaded).replyMessage;
    }

    controller.clear();
    cancelReply();
    if (controller0.hasClients) {
      controller0.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }

    try {
      final result =
          await sendMessageUseCase(text, groupId, "text", currentReply);
      result.fold(
        (failure) => emit(MessegeGroupError(error: failure.massage)),
        (_) {},
      );
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      emit(MessegeGroupError(error: e.toString()));
    }
  }

  Future<void> sendGroupImageMessage(
      {required String groupId, required ImageSource source}) async {
    MessageEntity? currentReply;
    if (state is MessegeGroupLoaded) {
      currentReply = (state as MessegeGroupLoaded).replyMessage;
    }

    final XFile? pickedFile = await PickImageUtils().pickImage(source);
    if (pickedFile == null) return;

    toggleMenu();

    if (state is MessegeGroupLoaded) {
      emit((state as MessegeGroupLoaded).copyWith(
        clearReply: true,
        pendingImagePath: pickedFile.path,
      ));
    }

    if (controller0.hasClients) {
      controller0.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }

    final uploadResult = await uploadImageUseCase.call(pickedFile);

    await uploadResult.fold(
      (failure) async {
        if (!isClosed) {
          if (state is MessegeGroupLoaded) {
            emit((state as MessegeGroupLoaded)
                .copyWith(clearPendingImage: true));
          }
          emit(MessegeGroupActionError(error: failure.massage));
        }
      },
      (uploadEntity) async {
        final String? imageUrl = uploadEntity.photo;
        if (imageUrl == null || imageUrl.isEmpty) {
          if (!isClosed && state is MessegeGroupLoaded) {
            emit((state as MessegeGroupLoaded)
                .copyWith(clearPendingImage: true));
          }
          return;
        }

        try {
          final result = await sendMessageUseCase(
              imageUrl, groupId, "image", currentReply);

          result.fold(
            (failure) {
              if (!isClosed) {
                emit(MessegeGroupActionError(error: failure.massage));
              }
            },
            (_) {},
          );
        } catch (e, stackTrace) {
          printFirebaseError(e, stackTrace);
          if (!isClosed) emit(MessegeGroupActionError(error: e.toString()));
        }

        if (!isClosed && state is MessegeGroupLoaded) {
          emit((state as MessegeGroupLoaded).copyWith(clearPendingImage: true));
        }
      },
    );
  }

  Future<void> sendGroupLocationMessage({required String groupId}) async {
    final currentState = state;
    MessageEntity? currentReply;
    if (state is MessegeGroupLoaded) {
      currentReply = (state as MessegeGroupLoaded).replyMessage;
    }

    toggleMenu();

    try {
      final locationData = await buildLocationPayload();

      if (locationData != null) {
        cancelReply();
        if (controller0.hasClients) {
          controller0.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        }

        final result = await sendMessageUseCase(
            locationData, groupId, "location", currentReply);
        result.fold(
          (failure) {
            emit(MessegeGroupActionError(error: failure.massage));
            if (currentState is MessegeGroupLoaded) emit(currentState);
          },
          (_) {},
        );
      } else {
        emit(MessegeGroupActionError(
            error: "access_to_the_site_has_been_denied".tr()));
        if (currentState is MessegeGroupLoaded) emit(currentState);
      }
    } catch (e) {
      emit(MessegeGroupActionError(error: e.toString()));
      if (currentState is MessegeGroupLoaded) emit(currentState);
    }
  }

  Future<void> sendGroupContactMessage({required String groupId}) async {
    final currentState = state;
    MessageEntity? currentReply;
    if (state is MessegeGroupLoaded) {
      currentReply = (state as MessegeGroupLoaded).replyMessage;
    }

    toggleMenu();

    try {
      final contactData = await buildContactPayload();

      if (contactData != null) {
        cancelReply();
        if (controller0.hasClients) {
          controller0.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        }

        final result = await sendMessageUseCase(
            contactData, groupId, "contact", currentReply);
        result.fold(
          (failure) {
            emit(MessegeGroupActionError(error: failure.massage));
            if (currentState is MessegeGroupLoaded) emit(currentState);
          },
          (_) {},
        );
      } else {
        emit(MessegeGroupActionError(error: "no_contact_selected".tr()));
        if (currentState is MessegeGroupLoaded) emit(currentState);
      }
    } catch (e) {
      emit(MessegeGroupActionError(error: e.toString()));
      if (currentState is MessegeGroupLoaded) emit(currentState);
    }
  }

Future<void> sendGroupPostShareMessage({
    required String groupId, 
    required SocialEntity post,
  }) async {
    final currentState = state;
    MessageEntity? currentReply;
    
    if (state is MessegeGroupLoaded) {
      currentReply = (state as MessegeGroupLoaded).replyMessage;
    }

     final postPayload = jsonEncode({
      "id": post.id,
      "user_id": post.userId,
      "user_name": post.userName,
      "user_image": post.userImage ?? "",
      "post_text": post.postText,
      "post_image": post.postImage ?? "",
      "location": post.location ?? "",
      "likes_count": post.likesCount ?? 0,
      "comments_count": post.commentsCount ?? 0,
      "liked_by": post.likedBy,
    });

    cancelReply(); 
    
    if (controller0.hasClients) {
      controller0.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }

    try {
      final result = await sendMessageUseCase(
          postPayload, groupId, "post_share", currentReply);
          
      result.fold(
        (failure) {
          if (!isClosed) {
            emit(MessegeGroupActionError(error: failure.massage));
          }
          if (currentState is MessegeGroupLoaded) emit(currentState);
        },
        (_) {},
      );
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      if (!isClosed) emit(MessegeGroupActionError(error: e.toString()));
      if (currentState is MessegeGroupLoaded) emit(currentState);
    }
  }

  bool _isMenuOpen = false;
  bool get isMenuOpen => _isMenuOpen;

  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;

    if (state is MessegeGroupLoaded) {
      emit((state as MessegeGroupLoaded).copyWith());
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
