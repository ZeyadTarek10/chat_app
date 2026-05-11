import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ChatsRepositories {
  Future<Either<Failure, ChatsEntity>> createChat({required String phone});
  Stream<Either<Failure , List<ChatsEntity>>> getChatsList();
  Future<Either<Failure, List<UserEntity>>> searchUserByPhone({required String phone});
}
