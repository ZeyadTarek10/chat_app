
import 'package:chat_app/core/enum/nav_bar_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
 MainCubit() : super(MainInitial());

  NavBarEnum currentNavBar = NavBarEnum.chats;
  bool isMenuOpen = false;
  bool isSearching = false;

  void selectedNavBarIcons(NavBarEnum viewEnum) {
    currentNavBar = viewEnum;
    
    emit(NavBarSelectedIconsState(navBarEnum: currentNavBar));
  }


  void toggleMenuState(bool isOpen) {
    isMenuOpen = isOpen;
    emit(ChatsMenuState(isMenuOpen));
  }

  void toggleSearch() {
    isSearching = !isSearching;
    emit(ChatsSearchToggled(isSearching));
    if (!isSearching) {
      
    }
  }
}