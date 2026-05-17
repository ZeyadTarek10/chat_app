import 'package:bloc/bloc.dart';
import 'package:chat_app/core/helpers/shared_prefrences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  final CacheHelper cacheHelper;
  MoreCubit({required this.cacheHelper}) : super(MoreInitial());

  bool isDarkMode = false;
  bool isMuteNotification = false;
  bool isHideChatHistory = false;
  bool isSecurityEnabled = false;

    Future<void> changeAppThemeMode(String key,{bool? sharedMode}) async {
      if (key == 'dark_mode') isDarkMode = sharedMode ?? !isDarkMode;
    if (sharedMode != null) {
      isDarkMode = sharedMode;
      emit(CubitState.themeChangeMode(isDark: isDarkMode));
    } else {
      isDarkMode = !isDarkMode;
      await CacheHelper()
          .saveData(key: 'mode', val: isDarkMode)
          .then((value) => emit(CubitState.themeChangeMode(isDark: isDarkMode)));
    }
  }

  void toggleSwitch(String key, bool value) {
    if (key == 'dark_mode') isDarkMode = value;
    if (key == 'mute_notif') isMuteNotification = value;
    if (key == 'hide_chat') isHideChatHistory = value;
    if (key == 'security') isSecurityEnabled = value;
    emit(MoreInitial()); 
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await FirebaseAuth.instance.signOut();
      
      await cacheHelper.saveData(key: 'isLoggedIn', val: false);
      
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure('Failed to logout: ${e.toString()}'));
    }
  }
}
