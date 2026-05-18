import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/features/forget_password/data/data_sources/forget_password_remote_data_source.dart';
import 'package:chat_app/features/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordRepositoryImpl extends ForgetPasswordRepository{
  final ForgetPasswordRemoteDataSource remoteDataSource;

  ForgetPasswordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> forgetPassword({required String email}) async{
    try {
      await remoteDataSource.sendPasswordResetEmail(email: email);
      return right(null);
    } on FirebaseAuthException catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      return left(ServerFailure(e.message ?? 'error_sending_email'.tr()));
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      return left(ServerFailure(e.toString()));
    }
  }
}