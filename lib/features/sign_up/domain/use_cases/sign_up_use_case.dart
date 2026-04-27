import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:chat_app/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:dartz/dartz.dart';

class SignUpUseCase {
  final SignUpRepository repository;
  SignUpUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String countryCode
  }) async {
    return await repository.signUp(
      email: email,
      password: password,
      name: name,
      phone: phone,
      countryCode: countryCode,
    );
  }
}