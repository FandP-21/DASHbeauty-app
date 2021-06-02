import 'dart:convert';

import 'package:shop_app/models/logout_model.dart';
import 'package:shop_app/models/otp_model.dart';
import 'package:shop_app/models/resendOtp_model.dart';
import 'package:shop_app/models/signin_model.dart';
import 'package:shop_app/models/singup_model.dart';

import '../ApiProvider.dart';

class SignInRepository {
  ApiProvider _apiProvider = ApiProvider();
  Future<SignInResponseModel> loginUser(SignInRequest user) async {
    final response = await _apiProvider.post("/v1/auth/mobile-signin", body:jsonEncode(user));
    return SignInResponseModel.fromJson(response);
  }

  Future<SignInResponseModel> forgetPassword(String email) async {
    final response = await _apiProvider.post("/v1/auth/forget-password", body: jsonEncode({"email": email}));
    return SignInResponseModel.fromJson(response);
  }
}

class SignUpRepository{
  ApiProvider _apiProvider = ApiProvider();
  Future<SignUpResponseModel> registerUser(RegisterRequest user) async {
    final response = await _apiProvider.post("/v1/auth/signup", body:jsonEncode(user));
    return SignUpResponseModel.fromJson(response);
  }
}

class OtpRepository{
  ApiProvider _apiProvider = ApiProvider();
  Future<OtpResponseModel> otpVerification(OtpRequest user) async {
    final response = await _apiProvider.patch("/v1/auth/verify-otp", body:jsonEncode(user));
    return OtpResponseModel.fromJson(response);
  }

  Future<ResendOtpModel> resendOtp(ResendOtpRequest user) async {
    final response = await _apiProvider.patch("/v1/auth/resend-otp", body:jsonEncode(user));
    return ResendOtpModel.fromJson(response);
  }
}

class LogoutRepository{
  ApiProvider _apiProvider = ApiProvider();
  Future<LogoutResponseModel> logout(String id) async {
    final response = await _apiProvider.patch("/v1/auth/logout/$id");
    return LogoutResponseModel.fromJson(response);
  }
}



