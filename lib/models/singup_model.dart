// To parse this JSON data, do
//
//     final signUpResponseModel = signUpResponseModelFromJson(jsonString);

import 'dart:convert';

SignUpResponseModel signUpResponseModelFromJson(String str) => SignUpResponseModel.fromJson(json.decode(str));

String signUpResponseModelToJson(SignUpResponseModel data) => json.encode(data.toJson());

class SignUpResponseModel {
  SignUpResponseModel({
    this.message,
  });

  String message;

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) => SignUpResponseModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}

class RegisterRequest {
  RegisterRequest({
    this.signupVia,
    this.roleId,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    this.gender,
    this.deviceType,
    this.deviceModel,
    this.deviceToken,
    this.appVersion,
    this.osVersion,
    this.storeId,
  });

  String signupVia;
  int roleId;
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;
  String gender;
  int deviceType;
  String deviceModel;
  String deviceToken;
  String appVersion;
  String osVersion;
  String storeId;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => RegisterRequest(
    signupVia: json["signup_via"],
    roleId: json["role_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    password: json["password"],
    confirmPassword: json["confirm_password"],
    gender: json["gender"],
    deviceType: json["device_type"],
    deviceModel: json["device_model"],
    deviceToken: json["device_token"],
    appVersion: json["app_version"],
    osVersion: json["os_version"],
    storeId: json["store_id"],
  );

  Map<String, dynamic> toJson() => {
    "signup_via": signupVia,
    "role_id": roleId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
    "confirm_password": confirmPassword,
    "gender": gender,
    "device_type": deviceType,
    "device_model": deviceModel,
    "device_token": deviceToken,
    "app_version": appVersion,
    "os_version": osVersion,
    "store_id": storeId,
  };
}
