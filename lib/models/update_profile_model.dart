// To parse this JSON data, do
//
//     final updateProfileDetailsModel = updateProfileDetailsModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileDetailsModel updateProfileDetailsModelFromJson(String str) => UpdateProfileDetailsModel.fromJson(json.decode(str));

String updateProfileDetailsModelToJson(UpdateProfileDetailsModel data) => json.encode(data.toJson());

class UpdateProfileDetailsModel {
  UpdateProfileDetailsModel({
    this.date,
    this.token,
  });

  Date date;
  String token;

  factory UpdateProfileDetailsModel.fromJson(Map<String, dynamic> json) => UpdateProfileDetailsModel(
    date:json["date"] == null? null : Date.fromJson(json["date"]),
    token: json["token"] == null ?null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "date": date.toJson(),
    "token": token,
  };
}

class Date {
  Date({
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
  String storeId;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
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


class UpdateProfileRequest {
  UpdateProfileRequest({
    this.firstName,
    this.lastName,
    this.storeId,
  });

  String firstName;
  String lastName;
  String storeId;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) => UpdateProfileRequest(
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    storeId: json["store_id"] == null ? null : json["store_id"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "store_id": storeId,
  };
}
