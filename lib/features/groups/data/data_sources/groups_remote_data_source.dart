import 'package:chat_app/features/groups/data/models/groups_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class GroupsRemoteDataSource {
  Future<void> createGroup(
      {required String groupName,
      required List<String> members,
      required List<String> memberNames,
      required List<String> image});
  Stream<List<GroupsModel>> getGroups();
  Future<List<Map<String, dynamic>>> getAllUsers();
  Future<void> resetGroupUnreadCount(String groupId);
}

class GroupsRemoteDataSourceImpl implements GroupsRemoteDataSource {
  @override
  Future<void> createGroup(
      {required String groupName,
      required List<String> members,
      required List<String> memberNames,
      required List<String> image}) async {
    String myUid = FirebaseAuth.instance.currentUser!.uid;
    String groupId = FirebaseFirestore.instance.collection("groups").doc().id;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection("users").doc(myUid).get();
    String myName = "unknown".tr();
    String myImage = "";
    if (userDoc.exists && userDoc.data() != null) {
      var data = userDoc.data() as Map<String, dynamic>;
      myName = data['name'] ?? "without_name".tr();
      myImage = data['profile_pic_url'] ?? "";
    }
    if (!members.contains(myUid)) {
      members.add(myUid);
      memberNames.add(myName);
      image.add(myImage);
    }
    Map<String, int> initialUnreadCounts = {};
    for (String memberId in members) {
      initialUnreadCounts[memberId] = 0;
    }
    GroupsModel groupModel = GroupsModel(
      id: groupId,
      name: groupName,
      members: members,
      memberNames: memberNames,
      adminsId: [myUid],
      image: image,
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      lastMessage: "the_group_was_successfully_created".tr(),
      lastMessageTime: DateTime.now().millisecondsSinceEpoch.toString(),
      unreadCounts: initialUnreadCounts,
    );

    await FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .set(groupModel.toJson());
  }

  @override
  Stream<List<GroupsModel>> getGroups() {
    String myUid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection("groups")
        .where("members", arrayContains: myUid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => GroupsModel.fromJson(doc.data()))
            .toList());
  }

  @override
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    String myUid = FirebaseAuth.instance.currentUser!.uid;

    var querySnapshot =
        await FirebaseFirestore.instance.collection("users").get();

    List<Map<String, dynamic>> usersList = [];

    for (var doc in querySnapshot.docs) {
      if (doc.id != myUid) {
        var data = doc.data();
        usersList.add({
          "id": doc.id,
          "name": data['name'] ?? "without_name".tr(),
          "phone": data['phone'] ?? "",
          "image": data['profile_pic_url'] ?? "",
          "selected": false,
        });
      }
    }
    return usersList;
  }

  @override
  Future<void> resetGroupUnreadCount(String groupId) async {
    String myUid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('groups').doc(groupId).update({
      'unread_counts.$myUid': 0,
    });
  }
}
