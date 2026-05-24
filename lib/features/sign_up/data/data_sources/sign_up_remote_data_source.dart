import 'package:chat_app/features/sign_up/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SignUpRemoteDataSource {
  Future<UserModel> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String countryCode});
  Future<UserModel> signInWithGoogle(
      {required String phone, required String countryCode});
}

class SignUpRemoteDataSourceImpl extends SignUpRemoteDataSource {
  @override
  Future<UserModel> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String countryCode}) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        phone: phone,
        countryCode: countryCode,
        gender: '',
        birthday: '',
        profilePicUrl: null);

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

  @override
  Future<UserModel> signInWithGoogle(
      {required String phone, required String countryCode}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final userDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid);
    final userDoc = await userDocRef.get();

    if (!userDoc.exists) {
      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? googleUser?.displayName ?? '',
        email: userCredential.user!.email ?? googleUser!.email,
        phone: phone,
        countryCode: countryCode,
        gender: '',
        birthday: '',
        profilePicUrl: userCredential.user!.photoURL ?? googleUser?.photoUrl,
      );

      await userDocRef.set({
        ...userModel.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      return userModel; 
    } else {
      return UserModel.fromJson(userDoc.data()!);
    }
  }
}
