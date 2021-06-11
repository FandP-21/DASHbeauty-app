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
    date: Date.fromJson(json["date"]),
    token: json["Token"],
  );

  Map<String, dynamic> toJson() => {
    "date": date.toJson(),
    "Token": token,
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
    userId: json["userId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    roleId: json["roleId"],
    storeId: json["storeId"],
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
    firstName: json["first_name"],
    lastName: json["last_name"],
    storeId: json["store_id"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "store_id": storeId,
  };
}
