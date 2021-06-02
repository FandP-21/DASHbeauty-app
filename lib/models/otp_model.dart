// To parse this JSON data, do
//
//     final otpResponseModel = otpResponseModelFromJson(jsonString);

import 'dart:convert';

OtpResponseModel otpResponseModelFromJson(String str) => OtpResponseModel.fromJson(json.decode(str));

String otpResponseModelToJson(OtpResponseModel data) => json.encode(data.toJson());

class OtpResponseModel {
  OtpResponseModel({
    this.userDetails,
  });

  UserDetails userDetails;

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) => OtpResponseModel(
    userDetails: UserDetails.fromJson(json["userDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "userDetails": userDetails.toJson(),
  };
}

class UserDetails {
  UserDetails({
    this.id,
    this.email,
    this.firstName,
    this.middleName,
    this.lastName,
    this.phoneNo,
    this.profilePic,
    this.gender,
    this.accessToken,
  });

  String id;
  String email;
  String firstName;
  String middleName;
  String lastName;
  String phoneNo;
  String profilePic;
  String gender;
  String accessToken;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    phoneNo: json["phone_no"],
    profilePic: json["profile_pic"],
    gender: json["gender"],
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "phone_no": phoneNo,
    "profile_pic": profilePic,
    "gender": gender,
    "access_token": accessToken,
  };
}

class OtpRequest {
  OtpRequest({
    this.email,
    this.otp,
  });

  String email;
  String otp;

  factory OtpRequest.fromJson(Map<String, dynamic> json) => OtpRequest(
    email: json["email"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "otp": otp,
  };
}


class ResendOtpRequest {
  ResendOtpRequest({
    this.email,
  });

  String email;

  factory ResendOtpRequest.fromJson(Map<String, dynamic> json) => ResendOtpRequest(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}


