import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? Id;
  final String? username;
  final String? age;
  UserModel({this.Id, this.username, this.age});

  factory UserModel.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      username: snapshot["username"],
      age: snapshot["age"],
      Id: snapshot["id"],
    );
  }
  Map<String, dynamic> toJson() => {
    "username" : username,
    "age" : age,
    "id"  : Id,
  };

}
