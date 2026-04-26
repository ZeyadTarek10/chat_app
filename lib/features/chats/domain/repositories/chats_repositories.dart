import 'package:chat_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/chats_entity.dart';

abstract class ChatsRepositories {
  Future<Either<Failure, ChatsEntity>> getChats();
}
