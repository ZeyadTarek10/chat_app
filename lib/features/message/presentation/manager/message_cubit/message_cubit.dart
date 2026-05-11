import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message/domain/use_cases/get_message_use_case.dart';
import 'package:chat_app/features/message/domain/use_cases/send_message_use_case.dart';
import 'package:chat_app/features/message/domain/use_cases/read_message_use_case.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final ReadMessageUseCase readMessageUseCase;
  final GetUserByIdUseCase getUserByIdUseCase; 
  final TextEditingController controller = TextEditingController();
  final ScrollController controller0 = ScrollController();

  UserEntity? friendModel;

  StreamSubscription? _messagesSubscription;

  MessageCubit({
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
    required this.readMessageUseCase,
    required this.getUserByIdUseCase,
  }) : super(MessageInitial());

  void getMessages(String roomId) {
    emit(MessageLoadingState());

    _messagesSubscription?.cancel(); 
    _messagesSubscription = getMessagesUseCase.call(roomId).listen((result) {
      if (!isClosed) {
        result.fold(
          (failure) => emit(MessageErrorState(errMsg: failure.massage)),
          (messages) => emit(MessageLoadedState(messages: messages, friendData: friendModel)),
        );
      }
    });
  }

String formatMessageTime(DateTime? dateTime) {
  if (dateTime == null) return "";

  return DateFormat('hh:mm a').format(dateTime);
}

bool _isMenuOpen = false;
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
  

  Future<void> sendMessage(MessageEntity message, String roomId) async {
    final result = await sendMessageUseCase.call(message, roomId);
    result.fold(
      (failure) { if (!isClosed) emit(MessageActionErrorState(errMsg: failure.massage)); },
      (_) {},
    );
  }

  Future<void> readMessage(String roomId, String msgId) async {
    await readMessageUseCase.call(roomId, msgId);
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}