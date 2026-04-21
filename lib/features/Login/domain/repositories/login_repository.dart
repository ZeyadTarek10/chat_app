import 'package:chat_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure,void>> login({
    required String email,
    required String password,
    required bool isKeepMeSignedIn,
  });
}
