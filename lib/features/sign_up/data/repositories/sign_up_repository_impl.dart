import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/features/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:chat_app/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpRepositoryImpl extends SignUpRepository {
  final SignUpRemoteDataSource remoteDataSource;

  SignUpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String countryCode
  }) async {
    try {
      final userModel = await remoteDataSource.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        phone: phone, countryCode: countryCode,
      );
      return right(userModel);
    } on FirebaseAuthException catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      if (e.code == 'weak-password') {
        return left(ServerFailure('the_password_provided_is_too_weak'.tr()));
      } else if (e.code == 'email-already-in-use') {
        return left(ServerFailure('the_account_already_exists_for_that_email'.tr()));
      }
      return left(ServerFailure('there_was_an_error ${e.message}'.tr()));
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      return left(ServerFailure(e.toString()));
    }
  }
}