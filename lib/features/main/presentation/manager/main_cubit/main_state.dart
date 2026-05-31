part of 'main_cubit.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

class NavBarSelectedIconsState extends MainState {
  final NavBarEnum navBarEnum;

  NavBarSelectedIconsState({required this.navBarEnum});
}

class ChatsMenuState extends MainState {
  final bool isMenuOpen;
  ChatsMenuState(this.isMenuOpen);
}

class ChatsSearchToggled extends MainState {
  final bool isSearching;
  ChatsSearchToggled(this.isSearching);
}

class MainSearchUpdatedState extends MainState{}