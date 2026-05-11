import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:chat_app/features/chats/domain/repositories/chats_repositories.dart';
import 'package:dartz/dartz.dart';

class GetChatsUseCase implements NoParams{
  final ChatsRepositories chatsRepositories;

  GetChatsUseCase({required this.chatsRepositories});

  Stream<Either<Failure ,List<ChatsEntity>>> call() {
    return chatsRepositories.getChatsList();
  }
}