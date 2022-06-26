import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userName;
  final String userEmail;
  final String uid;

  UserModel(
      {required this.userName, required this.userEmail, required this.uid});

  Map<String, dynamic> toJson() {
    return {"userName": userName, "userEmail": userEmail, "uid": uid};
  }

  factory UserModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> map) {
    return UserModel(
        userName: map["userName"],
        userEmail: map["userEmail"],
        uid: map['uid']);
  }
}
