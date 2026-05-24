import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:chat_app/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:dartz/dartz.dart';

class GoogleSignInUseCase {
  final SignUpRepository signUpRepository;

  GoogleSignInUseCase({required this.signUpRepository});

  Future<Either<Failure, UserEntity>> call(
      {required String phone, required String countryCode}) async {
    return await signUpRepository.signInWithGoogle(
      phone: '',
      countryCode: countryCode,
    );
  }
}
