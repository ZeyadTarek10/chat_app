
import 'dart:async';

import 'package:chat_app/config/app/upload_image/domain/use_cases/upload_image_use_case.dart';
import 'package:chat_app/config/app/upload_image/presentation/screens/widgets/image_pick.dart';
import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/features/groups/domain/repositories/groups_repository.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message_groups/domain/repositories/message_groups_repositories.dart';
import 'package:chat_app/features/message_groups/domain/use_cases/send_group_massege_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'messege_group_state.dart';

class MessegeGroupCubit extends Cubit<MessegeGroupState> {
  final SendGroupMessageUseCase sendMessageUseCase;
  final MessageGroupsRepository repository; 
  final GroupsRepository groupsRepository;
   final TextEditingController controller = TextEditingController();
  final ScrollController controller0 = ScrollController();
  final UploadImageUseCase uploadImageUseCase;
  
  StreamSubscription? _messagesSubscription;

  MessegeGroupCubit({ required this.sendMessageUseCase, required this.repository, required this.uploadImageUseCase, required this.groupsRepository}) : super(MessegeGroupInitial());

  void getMessages(String groupId) {
    _messagesSubscription?.cancel();

    groupsRepository.resetGroupUnreadCount(groupId);
    
    _messagesSubscription = repository.getGroupMessages(groupId).listen((result) {
      result.fold(
        (failure) => emit(MessegeGroupError(error: failure.massage)), 
        (messages) {
          final myUid = FirebaseAuth.instance.currentUser?.uid;
          
          for (var msg in messages) {
            if (msg.fromId != myUid && (msg.read == null || msg.read!.isEmpty)) {
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

  String formatMessageTime(DateTime? dateTime) {
    if (dateTime == null) return "";

    return DateFormat('hh:mm a').format(dateTime);
  }

  String getChatDayHeader(DateTime messageDate) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final messageDay = DateTime(messageDate.year, messageDate.month, messageDate.day);

  if (messageDay == today) {
    return "today".tr();
  } else if (messageDay == yesterday) {
    return "yesterday".tr();
  } else {
    return '${messageDate.day}/${messageDate.month}/${messageDate.year}';
  }
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
         date1.month == date2.month &&
         date1.day == date2.day;
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
      controller0.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }

    try {
      final result = await sendMessageUseCase(text, groupId, "text", currentReply);
      result.fold(
        (failure) => emit(MessegeGroupError(error: failure.massage)),
        (_) {}, 
      );
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      emit(MessegeGroupError(error: e.toString()));
    }
  }

  Future<void> sendGroupImageMessage({required String groupId, required ImageSource source}) async {
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
          final result =
              await sendMessageUseCase(imageUrl, groupId, "image", currentReply);

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
          emit((state as MessegeGroupLoaded)
              .copyWith(clearPendingImage: true));
        }
      },
    );
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