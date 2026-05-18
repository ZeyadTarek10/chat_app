
import 'dart:async';

import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message_groups/domain/repositories/message_groups_repositories.dart';
import 'package:chat_app/features/message_groups/domain/use_cases/send_group_massege_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'messege_group_state.dart';

class MessegeGroupCubit extends Cubit<MessegeGroupState> {
  final SendGroupMessageUseCase sendMessageUseCase;
  final MessageGroupsRepository repository; 
   final TextEditingController controller = TextEditingController();
  final ScrollController controller0 = ScrollController();
  
  StreamSubscription? _messagesSubscription;

  MessegeGroupCubit({ required this.sendMessageUseCase, required this.repository}) : super(MessegeGroupInitial());

  void getMessages(String groupId) {
    _messagesSubscription?.cancel();
    
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

  Future<void> sendMessage(String message, String groupId) async {
    try {
      final result = await sendMessageUseCase(message, groupId, "text");
      result.fold(
        (failure) => emit(MessegeGroupError(error: failure.massage)),
        (_) {
        }, 
      );
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      emit(MessegeGroupError(error: e.toString()));
    }
  }

bool _isMenuOpen = false;
  bool get isMenuOpen => _isMenuOpen; 
  
  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    
    if (state is MessegeGroupLoaded) {
       final currentMessages = (state as MessegeGroupLoaded).messages;
       emit(MessegeGroupLoaded(messages: List.from(currentMessages)));
    } 
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}