import 'package:chat_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ForgetPasswordRepository {
  Future<Either<Failure,void>> forgetPassword({
    required String email,
  });
}
