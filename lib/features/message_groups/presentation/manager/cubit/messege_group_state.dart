part of 'messege_group_cubit.dart';

@immutable
sealed class MessegeGroupState {}

final class MessegeGroupInitial extends MessegeGroupState {}

class MessegeGroupLoading extends MessegeGroupState {}
class MessegeGroupLoaded extends MessegeGroupState {
  final List<MessageEntity> messages;
  final MessageEntity? replyMessage;
  MessegeGroupLoaded({required this.messages, this.replyMessage});
  MessegeGroupLoaded copyWith({
    List<MessageEntity>? messages,
    MessageEntity? replyMessage,
    bool clearReply = false,
  }) {
    return MessegeGroupLoaded(
      messages: messages ?? this.messages,
      replyMessage: clearReply ? null : (replyMessage ?? this.replyMessage),
    );
  }
}
class MessegeGroupError extends MessegeGroupState {
  final String error;
  MessegeGroupError({required this.error});
}

final class MessegeGroupActionLoading extends MessegeGroupState {}
final class MessegeGroupActionSuccess extends MessegeGroupState {}
final class MessegeGroupActionError extends MessegeGroupState {
  final String error;
  MessegeGroupActionError({required this.error});
}