import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/message_entity.dart';

abstract class MessageRepository {
  Future<Either<Failure, void>> sendMessage(
      {required MessageEntity message, required String roomId});
  Future<Either<Failure, void>> readMessage(
      {required String roomId, required String msgId});
  Stream<Either<Failure, List<MessageEntity>>> getMessages(
      {required String roomId});
  Future<Either<Failure, UserEntity>> getUserById({required String uid});
  Future<Either<Failure, void>> deleteRoom({required String roomId});
  Future<Either<Failure, void>> clearChatMessages({required String roomId});
}
