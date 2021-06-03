// To parse this JSON data, do
//
//     final resendOtpModel = resendOtpModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordModel resendOtpModelFromJson(String str) => ResetPasswordModel.fromJson(json.decode(str));

String resendOtpModelToJson(ResetPasswordModel data) => json.encode(data.toJson());

class ResetPasswordModel {
  ResetPasswordModel({
    this.message,
  });

  String message;

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) => ResetPasswordModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}

class ResetPasswordRequest {
  ResetPasswordRequest({
    this.newPassword,
    this.confirmPassword,
    this.email,
  });

  String newPassword;
  String confirmPassword;
  String email;

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) => ResetPasswordRequest(
    newPassword: json["new_password"],
    confirmPassword: json["confirm_password"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "new_password": newPassword,
    "confirm_password": confirmPassword,
    "email": email,
  };
}

