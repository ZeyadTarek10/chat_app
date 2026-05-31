part of 'message_cubit.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class MessageLoadingState extends MessageState {}
final class MessageLoadedState extends MessageState {
  final List<MessageEntity> messages;
  final UserEntity? friendData;
  final MessageEntity? replyMessage;
  final String? pendingImagePath;
  MessageLoadedState({
    required this.messages,
    this.friendData,
    this.replyMessage,
    this.pendingImagePath,
  });

  MessageLoadedState copyWith({
    List<MessageEntity>? messages,
    UserEntity? friendData,
    MessageEntity? replyMessage,
    bool clearReply = false,
    String? pendingImagePath,
    bool clearPendingImage = false,
  }) {
    return MessageLoadedState(
      messages: messages ?? this.messages,
      friendData: friendData ?? this.friendData,
      replyMessage: clearReply ? null : (replyMessage ?? this.replyMessage),
      pendingImagePath: clearPendingImage
          ? null
          : (pendingImagePath ?? this.pendingImagePath),
    );
  }
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