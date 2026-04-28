import 'package:chat_app/features/chats/data/data_sources/chats_remote_data_source.dart';
import 'package:chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:chat_app/features/chats/domain/repositories/chats_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/network/netwok_info.dart';

class ChatsRepositoryImpl implements ChatsRepositories {
  final NetworkInfo networkInfo;
  final ChatsRemoteDataSource chatsRemoteDataSource;

  ChatsRepositoryImpl(
      {required this.networkInfo, required this.chatsRemoteDataSource});

  @override
  Future<Either<Failure, ChatsEntity>> getChats() async {
    try {
      final response = await chatsRemoteDataSource.getChats();
      return Right(response);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
