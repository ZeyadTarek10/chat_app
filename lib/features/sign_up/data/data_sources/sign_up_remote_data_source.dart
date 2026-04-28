import 'package:chat_app/features/sign_up/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class  SignUpRemoteDataSource {
  Future<UserModel> createUserWithEmailAndPassword({required String email, required String password, required String name,
    required String phone, required String countryCode});
}

class SignUpRemoteDataSourceImpl extends SignUpRemoteDataSource {
  
  @override
  Future<UserModel> createUserWithEmailAndPassword({required String email, required String password, required String name,
    required String phone, required String countryCode}) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    UserModel userModel = UserModel(
      uid: userCredential.user!.uid,
      name: name,
      email: email,
      phone: phone, countryCode: countryCode, gender: '', birthday: '', profilePicUrl: null
    );

    if (userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uid)
          .set({
        ...userModel.toJson(),
        'createdAt': DateTime.now(),
      });
    }
    return userModel;
  }
}