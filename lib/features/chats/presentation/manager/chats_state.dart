part of 'chats_cubit.dart';

@immutable
sealed class ChatsState {}

final class ChatsInitial extends ChatsState {}

final class ChatsLoadingState extends ChatsState {}

final class ChatsSuccessState extends ChatsState {
  final ChatsEntity chatsEntity;

  ChatsSuccessState({required this.chatsEntity});
}

final class ChatsErrorState extends ChatsState {
  final String errMsg;

  ChatsErrorState({required this.errMsg});
}
