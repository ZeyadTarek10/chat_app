import 'package:firebase_auth/firebase_auth.dart';

abstract class  ForgetPasswordRemoteDataSource {
  Future<void> sendPasswordResetEmail({required String email});
}

class ForgetPasswordRemoteDataSourceImpl extends ForgetPasswordRemoteDataSource {
  
  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
    );
  }
}