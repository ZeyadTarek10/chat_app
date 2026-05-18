import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/core/helpers/shared_prefrences.dart';
import 'package:chat_app/features/Login/data/data_sources/login_remote_data_source.dart';
import 'package:chat_app/features/Login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final CacheHelper cacheHelper;
  
  LoginRepositoryImpl({required this.remoteDataSource, required this.cacheHelper});

  @override
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
    required bool isKeepMeSignedIn,
  }) async {
    try {
      await remoteDataSource.signInWithEmail(email: email, password: password);
      
      if (isKeepMeSignedIn) {
        await cacheHelper.saveData(key: 'isLoggedIn', val: true); 
      }
      
      return right(null); 
      
    } on FirebaseAuthException catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      if (e.code == 'invalid-credential' ||
          e.code == 'user-not-found' ||
          e.code == 'wrong-password') {
        return left(ServerFailure('incorrect_email_or_password_Please_try_again'.tr()));
      }
      return left(ServerFailure('there_was_an_error ${e.message}'.tr()));
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      return left(ServerFailure(e.toString()));
    }
  }
}