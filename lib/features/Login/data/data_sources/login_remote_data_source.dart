import 'package:firebase_auth/firebase_auth.dart';

abstract class  LoginRemoteDataSource {
  Future<void> signInWithEmail({required String email, required String password});
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  
  @override
  Future<void> signInWithEmail({required String email, required String password}) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}