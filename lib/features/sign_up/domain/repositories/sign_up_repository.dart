import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SignUpRepository {
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  });
}