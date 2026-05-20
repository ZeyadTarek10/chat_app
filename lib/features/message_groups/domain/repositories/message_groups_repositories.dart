import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MessageGroupsRepository {
  Future<Either<Failure, void>> sendGroupMessage({
    required String message,
    required String groupId,
    String? type,
    MessageEntity? replyMessage,
  });
  Stream<Either<Failure, List<MessageEntity>>> getGroupMessages(String groupId);
  Future<Either<Failure, void>> markMessageAsRead(String groupId, String messageId);
}