import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/helpers/shared_prefrences.dart';
import 'package:chat_app/features/Login/data/data_sources/login_remote_data_source.dart';
import 'package:chat_app/features/Login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';
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
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential' ||
          e.code == 'user-not-found' ||
          e.code == 'wrong-password') {
        return left(const ServerFailure('Incorrect email or password. Please try again.'));
      }
      return left(ServerFailure('There was an error: ${e.message}'));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}