import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:dartz/dartz.dart';

class ForgetPasswordUseCase{
  final ForgetPasswordRepository repository;
  ForgetPasswordUseCase({required this.repository});

  Future<Either<Failure, void>> call({
    required String email,
  }) async {
    return await repository.forgetPassword(
        email: email);
  }
}
