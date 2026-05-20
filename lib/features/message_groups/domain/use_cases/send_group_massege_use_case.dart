import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message_groups/domain/repositories/message_groups_repositories.dart';
import 'package:dartz/dartz.dart';

class SendGroupMessageUseCase {
  final MessageGroupsRepository messageGroupsRepository;
  SendGroupMessageUseCase({required this.messageGroupsRepository});

  Future<Either<Failure, void>> call(String message, String groupId, String? type, MessageEntity? replyMessage) {
    return messageGroupsRepository.sendGroupMessage(message: message, groupId: groupId, type: type, replyMessage: replyMessage,);
  }
}