import 'package:chat_app/core/helpers/shared_prefrences.dart';
import 'package:chat_app/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:chat_app/features/profile/domain/repositories/profile_repositories.dart';
import 'package:chat_app/features/sign_up/data/models/user_model.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/core/network/netwok_info.dart';

class ProfileRepositoryImpl implements ProfileRepositories {
  final NetworkInfo networkInfo;
  final ProfileRemoteDataSource profileRemoteDataSource;
  final CacheHelper cacheHelper;

  ProfileRepositoryImpl(
      {required this.networkInfo, required this.profileRemoteDataSource, required this.cacheHelper});

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      final response = await profileRemoteDataSource.getUser();
      return Right(response);
    } catch (error, stackTrace) {
      printFirebaseError(error, stackTrace);
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserProfile(UserEntity user) async {
    try {
      await profileRemoteDataSource.updateUser(user as UserModel);
      return const Right(null);
    } catch (error, stackTrace) {
      printFirebaseError(error, stackTrace);
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await profileRemoteDataSource.logout();
      await cacheHelper.saveData(key: 'isLoggedIn', val: false);
      return const Right(null);
    } catch (error, stackTrace) {
      printFirebaseError(error, stackTrace);
      return Left(ServerFailure(error.toString()));
    }
  }
}
