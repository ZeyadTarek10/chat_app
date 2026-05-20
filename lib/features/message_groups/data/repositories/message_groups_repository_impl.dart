import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:chat_app/features/message_groups/data/data_source/message_groups_remote_data_source.dart';
import 'package:chat_app/features/message_groups/domain/repositories/message_groups_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageGroupsRepositoryImpl implements MessageGroupsRepository {
  final MessageGroupsRemoteDataSource messageGroupsRemoteDataSource;
  final FirebaseAuth auth = FirebaseAuth.instance;

  MessageGroupsRepositoryImpl({ required this.messageGroupsRemoteDataSource });

  @override
  Future<Either<Failure, void>> sendGroupMessage(
      {required String message, required String groupId, String? type, MessageEntity? replyMessage,}) async {
    try {
      final send = await messageGroupsRemoteDataSource.sendGroupMessage(
          message: message, groupId: groupId, type: type, replyMessage: replyMessage,);
      return right(send);
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<MessageEntity>>> getGroupMessages(String groupId) async* {
    try {
      yield* messageGroupsRemoteDataSource.getGroupMessages(groupId).map((messages) => Right(messages));
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      yield Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markMessageAsRead(String groupId, String messageId) async {
    try {
      await messageGroupsRemoteDataSource.markMessageAsRead(groupId, messageId);
      return right(null);
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      return left(ServerFailure(e.toString()));
    }
  }
}