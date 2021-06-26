import 'dart:convert';

import 'package:shop_app/models/ListProductModel.dart';
import 'package:shop_app/models/forgot_password_model.dart';
import 'package:shop_app/models/get_profile_details_model.dart';
import 'package:shop_app/models/logout_model.dart';
import 'package:shop_app/models/otp_model.dart';
import 'package:shop_app/models/resendOtp_model.dart';
import 'package:shop_app/models/reset_password_model.dart';
import 'package:shop_app/models/signin_model.dart';
import 'package:shop_app/models/singup_model.dart';
import 'package:shop_app/models/update_profile_model.dart';

import '../ApiProvider.dart';

class SignInRepository {
  ApiProvider _apiProvider = ApiProvider();
  Future<SignInResponseModel> loginUser(SignInRequest user) async {
    final response = await _apiProvider.post("/v1/auth/mobile-signin", body:jsonEncode(user));
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

class ResetPasswordRepository{
  ApiProvider _apiProvider = ApiProvider();
  Future<ResetPasswordModel> resetPassword(ResetPasswordRequest user, String otp) async {
    final response = await _apiProvider.post("/v1/auth/reset-password/$otp", body: jsonEncode(user));
    return ResetPasswordModel.fromJson(response);
  }
}

class ForgetPasswordRepository{
  ApiProvider _apiProvider = ApiProvider();
  Future<ForgotPasswordModel> forgetPassword(ForgotPasswordRequest email) async {
    final response = await _apiProvider.post("/v1/auth/forget-password", body: jsonEncode(email));
    return ForgotPasswordModel.fromJson(response);
  }
}

class GetProfileDetailsRepository{
  ApiProvider _apiProvider = ApiProvider();
  Future<GetProfileDetailsModel> getProfile() async {
    final response = await _apiProvider.get("/v1/auth/profile");
    return GetProfileDetailsModel.fromJson(response);
  }

  Future<UpdateProfileDetailsModel> updateProfile(UpdateProfileRequest updateProfile) async {
    final response = await _apiProvider.put("/v1/auth/profile", body: updateProfile);
    return UpdateProfileDetailsModel.fromJson(response);
  }
}

class ProductListRepository{
  ApiProvider _apiProvider = ApiProvider();
  Future<ListProductModel> getStoreProduct(ProductRequest productRequest) async {
    final response = await _apiProvider.get("/v1/products/by_store?limit=${productRequest.limit}&"
        "page_no=${productRequest.page_no}&search=${productRequest.search}");
    return ListProductModel.fromJson(response);
  }
}


