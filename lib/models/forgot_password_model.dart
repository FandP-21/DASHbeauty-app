// To parse this JSON data, do
//
//     final forgotPasswordModel = forgotPasswordModelFromJson(jsonString);

import 'dart:convert';

ForgotPasswordModel forgotPasswordModelFromJson(String str) => ForgotPasswordModel.fromJson(json.decode(str));

String forgotPasswordModelToJson(ForgotPasswordModel data) => json.encode(data.toJson());

class ForgotPasswordModel {
  ForgotPasswordModel({
    this.message,
  });

  String message;

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => ForgotPasswordModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}

class ForgotPasswordRequest {
  ForgotPasswordRequest({
    this.email,
  });

  String email;

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) => ForgotPasswordRequest(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
