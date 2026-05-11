import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/chats/data/data_sources/create_chats_remote_data_source.dart';
import 'package:chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:chat_app/features/chats/domain/repositories/chats_repositories.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_app/core/network/netwok_info.dart';

class ChatsRepositoryImpl implements ChatsRepositories {
  final NetworkInfo networkInfo;
  final ChatsRemoteDataSource chatsRemoteDataSource;

  ChatsRepositoryImpl(
      {required this.networkInfo, required this.chatsRemoteDataSource});

  @override
  Future<Either<Failure, ChatsEntity>> createChat(
      {required String phone}) async {
    try {
      final createChat =
          await chatsRemoteDataSource.createChat(phone: phone);

      return Right(createChat);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<ChatsEntity>>> getChatsList() async* {
    try {
      await for (var modelsList in chatsRemoteDataSource.getChatsList()) {
        final chatList = modelsList.map((model) => model as ChatsEntity).toList();
        yield Right(chatList);
      }
    } catch (error) {
      yield Left(ServerFailure(error.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<UserEntity>>> searchUserByPhone({required String phone}) async {
    try {
      final users = await chatsRemoteDataSource.searchUserByPhone(phone: phone);
      
      return Right(users);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}