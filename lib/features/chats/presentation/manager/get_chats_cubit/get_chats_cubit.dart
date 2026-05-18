import 'dart:async';

import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/core/helpers/shared_prefrences.dart';
import 'package:chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:chat_app/features/chats/domain/use_cases/get_chat_use_case.dart';
import 'package:chat_app/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_chats_state.dart';

class GetChatsCubit extends Cubit<GetChatsState> {
  final GetChatsUseCase getChatsUseCase;
  StreamSubscription? chatSubscription;

  GetChatsCubit({required this.getChatsUseCase}) : super(GetChatsInitial());

String formatChatTime(DateTime? dateTime) {
  if (dateTime == null) return '';

  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
  DateTime messageDay = DateTime(dateTime.year, dateTime.month, dateTime.day);

  String timeOnly = DateFormat('hh:mm a').format(dateTime);

  if (messageDay == today) {
    return "today • $timeOnly".tr();
  } else if (messageDay == yesterday) {
    return "yesterday • $timeOnly".tr();
  } else {
    return DateFormat('dd MMM • hh:mm a').format(dateTime);
  }
}

  Future<void> fetchChats() async {
    emit(GetChatsLoading());

    final user = await _waitForUser();
    if (user == null) {
      emit(GetChatsError(errMsg: 'user_is_not_logged_in'.tr()));
      return;
    }

    try {
      await user.getIdToken(true);
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      await _clearSession();
      emit(GetChatsError(errMsg: 'user_is_not_logged_in'.tr()));
      return;
    }

    await chatSubscription?.cancel();
    chatSubscription = getChatsUseCase.call().listen((eitherResult) {
      eitherResult.fold(
        (failure) async {
          if (failure.massage.contains('permission-denied')) {
            await _clearSession();
          }
          emit(GetChatsError(errMsg: failure.massage));
        },
        (chatsList) {
          emit(GetChatsSuccess(chatsList: chatsList));
        },
      );
    }, onError: (error) async {
      printFirebaseError(error);
      if (error.toString().contains('permission-denied')) {
        await _clearSession();
      }
      emit(GetChatsError(errMsg: error.toString()));
    });
  }

  Future<User?> _waitForUser() async {
    final current = FirebaseAuth.instance.currentUser;
    if (current != null) return current;

    try {
      return await FirebaseAuth.instance
          .authStateChanges()
          .firstWhere((user) => user != null)
          .timeout(const Duration(seconds: 5));
    } catch (_) {
      return null;
    }
  }

  Future<void> _clearSession() async {
    await FirebaseAuth.instance.signOut();
    await getIt<CacheHelper>().saveData(key: 'isLoggedIn', val: false);
  }

  @override
  Future<void> close() {
    chatSubscription?.cancel();
    return super.close();
  }
}
