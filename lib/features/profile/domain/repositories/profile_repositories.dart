import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';


abstract class ProfileRepositories {
  Future<Either<Failure, UserEntity>> getUser();
  Future<Either<Failure, void>> updateUserProfile(UserEntity user);
  Future<Either<Failure, void>> logout();
}