part of 'messege_group_cubit.dart';

@immutable
sealed class MessegeGroupState {}

final class MessegeGroupInitial extends MessegeGroupState {}

class MessegeGroupLoading extends MessegeGroupState {}
class MessegeGroupLoaded extends MessegeGroupState {
  final List<MessageEntity> messages;
  MessegeGroupLoaded({required this.messages});
}
class MessegeGroupError extends MessegeGroupState {
  final String error;
  MessegeGroupError({required this.error});
}