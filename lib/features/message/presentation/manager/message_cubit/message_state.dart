part of 'message_cubit.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class MessageLoadingState extends MessageState {}
final class MessageLoadedState extends MessageState {
  final List<MessageEntity> messages;
  final UserEntity? friendData;
  MessageLoadedState({required this.messages, this.friendData});
}
final class MessageErrorState extends MessageState {
  final String errMsg;
  MessageErrorState({required this.errMsg});
}

class ChatsMenuState extends MessageState {
  final bool isMenuOpen;
  ChatsMenuState(this.isMenuOpen);
}


final class MessageActionLoadingState extends MessageState {}
final class MessageActionSuccessState extends MessageState {}
final class MessageActionErrorState extends MessageState {
  final String errMsg;
  MessageActionErrorState({required this.errMsg});
}