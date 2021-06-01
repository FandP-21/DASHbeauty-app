// To parse this JSON data, do
//
//     final signInResponseModel = signInResponseModelFromJson(jsonString);

import 'dart:convert';

SignInResponseModel signInResponseModelFromJson(String str) => SignInResponseModel.fromJson(json.decode(str));

String signInResponseModelToJson(SignInResponseModel data) => json.encode(data.toJson());

class SignInResponseModel {
  SignInResponseModel({
    this.userDetails,
  });

  UserDetails userDetails;

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) => SignInResponseModel(
    userDetails: UserDetails.fromJson(json["user_details"]),
  );

  Map<String, dynamic> toJson() => {
    "user_details": userDetails.toJson(),
  };
}

class UserDetails {
  UserDetails({
    this.accessToken,
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.profilePic,
    this.gender,
  });

  String accessToken;
  String id;
  String firstName;
  String middleName;
  String lastName;
  String email;
  String profilePic;
  String gender;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    accessToken: json["access_token"],
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    email: json["email"],
    profilePic: json["profile_pic"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "id": id,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "email": email,
    "profile_pic": profilePic,
    "gender": gender,
  };
}

class SignInRequest{
String email;
String password;
String device_type;String device_model;String device_token;String app_version;String os_version;

SignInRequest({this.email, this.password, this.device_type, this.device_model, this.device_token, this.app_version, this.os_version});

SignInRequest.fromJson(Map<String, dynamic> json) {
email = json['email'];
password = json['password'];
device_type = json['device_type'];
device_model = json['device_model'];
device_token = json['device_token'];
app_version = json['app_version'];
os_version = json['os_version'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['email'] = this.email;
data['password'] = this.password;
data['device_type'] = this.device_type;
data['device_model'] = this.device_model;
data['device_token'] = this.device_token;
data['app_version'] = this.app_version;
data['os_version'] = this.os_version;

return data;
}
}
