part of 'create_chats_cubit.dart';

@immutable
sealed class CreateChatsState {}

final class CreateChatsInitial extends CreateChatsState {}

final class UsersSearchingState extends CreateChatsState {}

final class UsersSearchSuccessState extends CreateChatsState {
  final List<UserEntity> foundUsers; 
  
  UsersSearchSuccessState({required this.foundUsers});
}

final class CreateChatsLoadingState extends CreateChatsState {}

final class CreateChatsSuccessState extends CreateChatsState {
  final dynamic chatsEntity;

  CreateChatsSuccessState({required this.chatsEntity});
}

final class CreateChatsErrorState extends CreateChatsState {
  final String errMsg;

  CreateChatsErrorState({required this.errMsg});
}