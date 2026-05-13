import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/features/message/domain/repositories/message_repo.dart';
import 'package:dartz/dartz.dart';

class DeleteRoomUseCase implements UseCase<void, String> {
  final MessageRepository messageRepository;
  
  DeleteRoomUseCase({required this.messageRepository});
  
  @override
  Future<Either<Failure, void>> call(String roomId) {
    return messageRepository.deleteRoom(roomId: roomId);
  }
}

class ClearChatMessagesUseCase implements UseCase<void, String> {
  final MessageRepository messageRepository;
  
  ClearChatMessagesUseCase({required this.messageRepository});
  
  @override
  Future<Either<Failure, void>> call(String roomId) {
    return messageRepository.clearChatMessages(roomId: roomId);
  }
}