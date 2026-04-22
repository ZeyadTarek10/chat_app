import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/Login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase{
  final LoginRepository repository;
  LoginUseCase({required this.repository});

  Future<Either<Failure, void>> call({
    required String email,
    required String password,
    required bool isKeepMeSignedIn,
  }) async {
    return await repository.login(
        email: email, password: password, isKeepMeSignedIn: isKeepMeSignedIn);
  }
}
