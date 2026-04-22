import 'package:chat_app/features/sign_up/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class  SignUpRemoteDataSource {
  Future<UserModel> createUserWithEmailAndPassword({required String email, required String password, required String name,
    required String phone,});
}

class SignUpRemoteDataSourceImpl extends SignUpRemoteDataSource {
  
  @override
  Future<UserModel> createUserWithEmailAndPassword({required String email, required String password, required String name,
    required String phone,}) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    UserModel userModel = UserModel(
      uid: userCredential.user!.uid,
      name: name,
      email: email,
      phone: phone,
    );

    if (userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uid)
          .set({
        'uid': userModel.uid,
        'name': name,
        'phone': phone,
        'email': email,
        'createdAt': DateTime.now(),
      });
    }
    return userModel;
  }
}