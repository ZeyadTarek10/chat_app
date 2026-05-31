import 'package:chat_app/core/services/google_sign_in_service.dart';
import 'package:chat_app/features/sign_up/data/models/user_model.dart';
import 'package:chat_app/injection_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    final googleUser = await getIt<GoogleSignInService>().signIn();
    if (googleUser == null) {
      throw Exception('Google sign in was cancelled');
    }

    final googleAuth = googleUser.authentication;
    final idToken = googleAuth.idToken;
    if (idToken == null) {
      throw Exception(
          'Missing Google ID token. Check serverClientId / SHA-1 / OAuth client configuration.');
    }

    final credential = GoogleAuthProvider.credential(idToken: idToken);

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final firebaseUser = userCredential.user;
    if (firebaseUser == null) {
      throw Exception('Firebase sign-in failed: user is null.');
    }

    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid);
    final userDoc = await userDocRef.get();

    if (!userDoc.exists) {
      final userModel = UserModel(
        uid: firebaseUser.uid,
        name: firebaseUser.displayName ?? googleUser.displayName ?? '',
        email: firebaseUser.email ?? googleUser.email,
        phone: phone,
        countryCode: countryCode,
        gender: '',
        birthday: '',
        profilePicUrl: firebaseUser.photoURL ?? googleUser.photoUrl,
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
