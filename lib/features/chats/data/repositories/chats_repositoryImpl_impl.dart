import 'package:chat_app/features/chats/data/data_sources/chats_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/network/netwok_info.dart';
import 'package:chat_app/features/first_feature/domain/entities/cat_fact_entity.dart';
import 'package:chat_app/features/first_feature/domain/repositories/first_feature_repo.dart';

class ChatsRepositoryImpl implements FirstFeatureRepository {
  final NetworkInfo networkInfo;
  final ChatsRemoteDataSource chatsRemoteDataSource;

  ChatsRepositoryImpl(
      {required this.networkInfo, required this.chatsRemoteDataSource});

  @override
  Future<Either<Failure, CatFactEntity>> getCatFact() async {
    try {
      final response = await chatsRemoteDataSource.getChats();
      return Right(response);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
