import 'package:chat_app/features/message/data/data_sources/message_remote_data_source.dart';
import 'package:chat_app/features/message/data/models/message_model.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message/domain/repositories/message_repo.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/core/network/netwok_info.dart';

class MessageRepoImpl implements MessageRepository {
  final NetworkInfo networkInfo;
  final MessageRemoteDataSource messageRemoteDataSource;

  MessageRepoImpl(
      {required this.networkInfo, required this.messageRemoteDataSource});

  @override
  Future<Either<Failure, void>> sendMessage(
      {required MessageEntity message, required String roomId}) async {
    try {
      final messageModel = MessageModel(
        id: message.id,
        message: message.message,
        createdAt: message.createdAt,
        toId: message.toId,
        fromId: message.fromId,
        type: message.type,
        read: message.read,
      );
      await messageRemoteDataSource.sendMessage(
          messageModel: messageModel, roomId: roomId);
      return const Right(null);
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> readMessage(
      {required String roomId, required String msgId}) async {
    try {
      await messageRemoteDataSource.readMessage(roomId: roomId, msgId: msgId);
      return const Right(null);
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<MessageEntity>>> getMessages(
      {required String roomId}) async* {
    try {
      await for (var messages
          in messageRemoteDataSource.getMessages(roomId: roomId)) {
        yield Right(messages);
      }
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      yield Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById({required String uid}) async {
    try {
      final user = await messageRemoteDataSource.getUserById(uid: uid);
      return Right(user);
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRoom({required String roomId}) async {
    try {
      await messageRemoteDataSource.deleteRoom(roomId: roomId);
      return const Right(null);
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearChatMessages(
      {required String roomId}) async {
    try {
      await messageRemoteDataSource.clearChatMessages(roomId: roomId);
      return const Right(null);
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      return Left(ServerFailure(e.toString()));
    }
  }
}
