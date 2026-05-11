import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:chat_app/features/chats/domain/repositories/chats_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_app/core/usecases/usecase.dart';

class CreateChatsUseCase implements UseCase<ChatsEntity, String > {
  final ChatsRepositories chatsRepositories;

  CreateChatsUseCase({required this.chatsRepositories});

  @override
  Future<Either<Failure, ChatsEntity>> call(String phone) async {
    return await chatsRepositories.createChat(phone: phone);
  }
}
