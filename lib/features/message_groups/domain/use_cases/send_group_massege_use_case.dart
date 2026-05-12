import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/message_groups/domain/repositories/message_groups_repositories.dart';
import 'package:dartz/dartz.dart';

class SendGroupMessageUseCase {
  final MessageGroupsRepository messageGroupsRepository;
  SendGroupMessageUseCase({required this.messageGroupsRepository});

  Future<Either<Failure, void>> call(String message, String groupId, String? type) {
    return messageGroupsRepository.sendGroupMessage(message: message, groupId: groupId, type: type);
  }
}