import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message/domain/repositories/message_repo.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_app/core/error/failures.dart';

class SendMessageUseCase {
  final MessageRepository messageRepository;

  SendMessageUseCase({required this.messageRepository});

  Future<Either<Failure, void>> call(
      MessageEntity message, String roomId) async {
    return await messageRepository.sendMessage(
        message: message, roomId: roomId);
  }
}

class GetUserByIdUseCase {
  final MessageRepository messageRepository;
  
  GetUserByIdUseCase({required this.messageRepository});
  
  Future<Either<Failure, UserEntity>> call(String uid) {
    return messageRepository.getUserById(uid: uid);
  }
}

