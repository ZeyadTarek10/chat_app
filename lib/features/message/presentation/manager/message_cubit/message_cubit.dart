import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message/domain/use_cases/delete_room_use_case.dart';
import 'package:chat_app/features/message/domain/use_cases/get_message_use_case.dart';
import 'package:chat_app/features/message/domain/use_cases/send_message_use_case.dart';
import 'package:chat_app/features/message/domain/use_cases/read_message_use_case.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final ReadMessageUseCase readMessageUseCase;
  final GetUserByIdUseCase getUserByIdUseCase; 
  final DeleteRoomUseCase deleteRoomUseCase;
  final ClearChatMessagesUseCase clearChatMessagesUseCase;
  final TextEditingController controller = TextEditingController();
  final ScrollController controller0 = ScrollController();

  UserEntity? friendModel;

  StreamSubscription? _messagesSubscription;

  MessageCubit({
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
    required this.readMessageUseCase,
    required this.getUserByIdUseCase,
    required this.deleteRoomUseCase,
    required this.clearChatMessagesUseCase,
  }) : super(MessageInitial());

  void getMessages(String roomId) {
    emit(MessageLoadingState());

    _messagesSubscription?.cancel(); 
    _messagesSubscription = getMessagesUseCase.call(roomId).listen((result) {
      if (!isClosed) {
        result.fold(
          (failure) => emit(MessageErrorState(errMsg: failure.massage)),
          (messages) {
            MessageEntity? currentReply;
            if (state is MessageLoadedState) {
              currentReply = (state as MessageLoadedState).replyMessage;
            }

            emit(MessageLoadedState(
              messages: messages, 
              friendData: friendModel,
              replyMessage: currentReply, 
            ));
          },
        );
      }
    });
  }

String formatMessageTime(DateTime? dateTime) {
  if (dateTime == null) return "";

  return DateFormat('hh:mm a').format(dateTime);
}

bool _isMenuOpen = false;
bool issMenuOpen = false;
  bool get isMenuOpen => _isMenuOpen; 
  
  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    
    if (state is MessageLoadedState) {
       final currentMessages = (state as MessageLoadedState).messages;
       
       emit(MessageLoadedState(
         messages: List.from(currentMessages),
         friendData: friendModel,
       ));
    } 
  }

  void toggleMenuState(bool isOpen) {
    issMenuOpen = isOpen;
    emit(ChatsMenuState(isMenuOpen));
  }
 Future<void> initChat(String roomId, String friendId) async {
    emit(MessageLoadingState());

    final userResult = await getUserByIdUseCase.call(friendId); 
    
    userResult.fold(
      (failure) => emit(MessageErrorState(errMsg: failure.massage)),
      (user) {
        friendModel = user;
       getMessages(roomId);
      }
    );
  }

  void selectReplyMessage(MessageEntity message) {
    if (state is MessageLoadedState) {
      emit((state as MessageLoadedState).copyWith(replyMessage: message));
    }
  }

  void cancelReply() {
    if (state is MessageLoadedState) {
      emit((state as MessageLoadedState).copyWith(clearReply: true));
    }
  }
  

  Future<void> sendMessage(MessageEntity message, String roomId) async {
    final result = await sendMessageUseCase.call(message, roomId);
    result.fold(
      (failure) { if (!isClosed) emit(MessageActionErrorState(errMsg: failure.massage)); },
      (_) {},
    );
  }

  Future<void> sendTextMessage({required String roomId, required String friendId}) async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    MessageEntity? currentReply;
    if (state is MessageLoadedState) {
      currentReply = (state as MessageLoadedState).replyMessage;
    }

    String msgId = DateTime.now().millisecondsSinceEpoch.toString();
    
    final newMessage = MessageEntity(
      id: msgId,
      message: text,
      createdAt: DateTime.now(),
      toId: friendId,
      fromId: FirebaseAuth.instance.currentUser!.uid,
      type: "text",
      read: "",
      replyMessage: currentReply,
    );

    controller.clear();
    cancelReply();
    _scrollToBottom();

    final result = await sendMessageUseCase.call(newMessage, roomId);
    result.fold(
      (failure) { if (!isClosed) emit(MessageActionErrorState(errMsg: failure.massage)); },
      (_) {},
    );
  }

  void _scrollToBottom() {
    if (controller0.hasClients) {
      controller0.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  Future<void> readMessage(String roomId, String msgId) async {
    await readMessageUseCase.call(roomId, msgId);
  }

  Future<void> deleteRoom({required String roomId}) async {
    final result = await deleteRoomUseCase.call(roomId);
    result.fold(
      (failure) { if (!isClosed) emit(MessageActionErrorState(errMsg: failure.massage)); },
      (_) {},
    );
  }

  Future<void> clearChat({required String roomId}) async {
    final result = await clearChatMessagesUseCase.call(roomId);
    result.fold(
      (failure) {
        if (!isClosed) emit(MessageActionErrorState(errMsg: failure.massage));
      },
      (_) {
      },
    );
  }
  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}