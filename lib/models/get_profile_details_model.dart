// To parse this JSON data, do
//
//     final getProfileDetailsModel = getProfileDetailsModelFromJson(jsonString);

import 'dart:convert';

GetProfileDetailsModel getProfileDetailsModelFromJson(String str) => GetProfileDetailsModel.fromJson(json.decode(str));

String getProfileDetailsModelToJson(GetProfileDetailsModel data) => json.encode(data.toJson());

class GetProfileDetailsModel {
  GetProfileDetailsModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.roleId,
    this.storeId,
  });

  String userId;
  String firstName;
  String lastName;
  String email;
  int roleId;
  dynamic storeId;

  factory GetProfileDetailsModel.fromJson(Map<String, dynamic> json) => GetProfileDetailsModel(
    userId: json["userId"] == null ? null:json["userId"],
    firstName: json["firstName"] == null ? null:json["firstName"],
    lastName: json["lastName"] == null ? null: json["lastName"],
    email: json["email"] == null ? null:json["email"],
    roleId: json["roleId"] == null ? null:json["roleId"],
    storeId: json["storeId"] == null ? null:json["storeId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "roleId": roleId,
    "storeId": storeId,
  };
}
