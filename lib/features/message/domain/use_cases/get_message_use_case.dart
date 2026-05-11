import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message/domain/repositories/message_repo.dart';
import 'package:dartz/dartz.dart';

class GetMessagesUseCase{
  final MessageRepository messageRepository;
  GetMessagesUseCase({required this.messageRepository});

  Stream<Either<Failure, List<MessageEntity>>> call(String roomId) {
    return messageRepository.getMessages(roomId: roomId);
  }
}