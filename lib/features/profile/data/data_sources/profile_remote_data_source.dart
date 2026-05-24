import 'package:chat_app/features/sign_up/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getUser();
  Future<void> updateUser(UserModel user);
  Future<void> logout();
  Future<void> updateProfilePicture({required String newImageUrl, required String uid});
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl();

  @override
  Future<UserModel> getUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
   if (currentUser == null) {
      throw Exception("user_is_not_logged_in".tr());
    }
    final doc = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!);
    } else {
      throw Exception("user_data_not_found".tr());
    }
  }

  @override
  Future<void> updateUser(UserModel user) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update(user.toJson());
    }
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
  
  @override
  Future<void> updateProfilePicture({required String newImageUrl, required String uid}) async{
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'profile_pic_url': newImageUrl});
  }
}
