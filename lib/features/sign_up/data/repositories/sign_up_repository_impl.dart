import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:chat_app/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:dartz/dartz.dart';
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
  }) async {
    try {
      final userModel = await remoteDataSource.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(const ServerFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        return left(const ServerFailure('The account already exists for that email.'));
      }
      return left(ServerFailure('There was an error: ${e.message}'));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}