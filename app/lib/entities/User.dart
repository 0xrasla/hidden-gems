// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String message;
  UserClass user;

  User({
    required this.message,
    required this.user,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        message: json["message"],
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
      };
}

class UserClass {
  String name;
  String mobileNumber;
  String id;
  int v;

  UserClass({
    required this.name,
    required this.mobileNumber,
    required this.id,
    required this.v,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobileNumber": mobileNumber,
        "_id": id,
        "__v": v,
      };
}
