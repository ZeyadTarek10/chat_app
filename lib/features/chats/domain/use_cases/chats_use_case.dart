import 'package:chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:chat_app/features/chats/domain/repositories/chats_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecases/usecase.dart';

class ChatsUseCase implements UseCase<ChatsEntity, NoParams> {
  final ChatsRepositories chatsRepositories;

  ChatsUseCase({required this.chatsRepositories});

  @override
  Future<Either<Failure, ChatsEntity>> call(NoParams params) {
    return chatsRepositories.getChats();
  }
}
