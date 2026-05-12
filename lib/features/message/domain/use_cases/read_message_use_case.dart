import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/message/domain/repositories/message_repo.dart';
import 'package:dartz/dartz.dart';

class ReadMessageUseCase {
  final MessageRepository messageRepository;
  ReadMessageUseCase({required this.messageRepository});

  Future<Either<Failure, void>> call(String roomId, String msgId) async {
    return await messageRepository.readMessage(roomId: roomId, msgId: msgId);
  }
}