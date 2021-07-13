import 'dart:convert';

import 'package:shop_app/models/AllUserResponseModel.dart';
import 'package:shop_app/models/CommonRequest.dart';
import 'package:shop_app/models/ListProductModel.dart';
import 'package:shop_app/models/UserResponseModel.dart';
import 'package:shop_app/models/category_model.dart';
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
import 'package:shop_app/constants.dart' as Constants;

class SignInRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<SignInResponseModel> loginUser(SignInRequest user) async {
    final response = await _apiProvider.post("/v1/auth/mobile-signin",
        body: jsonEncode(user));
    return SignInResponseModel.fromJson(response);
  }
}

class SignUpRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<SignUpResponseModel> registerUser(RegisterRequest user) async {
    final response =
        await _apiProvider.post("/v1/auth/signup", body: jsonEncode(user));
    return SignUpResponseModel.fromJson(response);
  }
}

class OtpRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<OtpResponseModel> otpVerification(OtpRequest user) async {
    final response =
        await _apiProvider.patch("/v1/auth/verify-otp", body: jsonEncode(user));
    return OtpResponseModel.fromJson(response);
  }

  Future<ResendOtpModel> resendOtp(ResendOtpRequest user) async {
    final response =
        await _apiProvider.patch("/v1/auth/resend-otp", body: jsonEncode(user));
    return ResendOtpModel.fromJson(response);
  }
}

class LogoutRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<LogoutResponseModel> logout(String id) async {
    final response = await _apiProvider.patch("/v1/auth/logout/$id");
    return LogoutResponseModel.fromJson(response);
  }
}

class ResetPasswordRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<ResetPasswordModel> resetPassword(
      ResetPasswordRequest user, String otp) async {
    final response = await _apiProvider.post("/v1/auth/reset-password/$otp",
        body: jsonEncode(user));
    return ResetPasswordModel.fromJson(response);
  }
}

class ForgetPasswordRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<ForgotPasswordModel> forgetPassword(
      ForgotPasswordRequest email) async {
    final response = await _apiProvider.post("/v1/auth/forget-password",
        body: jsonEncode(email));
    return ForgotPasswordModel.fromJson(response);
  }
}

class GetProfileDetailsRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<GetProfileDetailsModel> getProfile() async {
    final response = await _apiProvider.get("/v1/auth/profile");
    return GetProfileDetailsModel.fromJson(response);
  }

  Future<UpdateProfileDetailsModel> updateProfile(
      UpdateProfileRequest updateProfile) async {
    final response =
        await _apiProvider.put("/v1/auth/profile", body: updateProfile);
    return UpdateProfileDetailsModel.fromJson(response);
  }
}

class ProductListRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<ListProductModel> getStoreProduct(
      ProductRequest productRequest) async {
    final response = await _apiProvider.get(
        "/v1/products/by_store?limit=${productRequest.limit}&"
        "page_no=${productRequest.page_no}&search=${productRequest.search}");
    return ListProductModel.fromJson(response);
  }
}

class CategoryListRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<CategoryResponseModel> getCategoryList(
      CategoryRequest categoryRequest) async {
    final response = await _apiProvider.get(
        "/v1/category?limit=${categoryRequest.limit}&"
            "page_no=${categoryRequest.page_no}&search=${categoryRequest.search}");
    return CategoryResponseModel.fromJson(response);
  }
}


class OrderRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<AllUserResponseModel> getAllOrderByUserId(String userId, String limit,String page_no) async {
    final response = await _apiProvider.get(
        "${Constants.GET_ORDER_BY_UESR}$userId?limit=$limit&"
            "page_no=$page_no}");
    return AllUserResponseModel.fromJson(response);
  }

  Future<AllUserResponseModel> getAllOrders(UserRequest request) async {
    final response = await _apiProvider.get(
        "${Constants.GET_ORDERS}?limit=${request.limit}&page_no=${request.page_no}}");
    return AllUserResponseModel.fromJson(response);
  }

}

class FavouriteRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<AllUserResponseModel> getFavouriteByUser(CommonRequest request) async {
    final response = await _apiProvider.get(
        "${Constants.GET_FAVOURITE}?limit=${request.limit}&page_no=${request.page_no}&search=${request.search}");
    return AllUserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> addToFavourite(String productId) async {
    final response = await _apiProvider.postWithToken(
        Constants.GET_FAVOURITE, jsonEncode(productId));
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> removeFromFavourite(String productId) async {
    final response = await _apiProvider.delete("${Constants.GET_FAVOURITE}/$productId");
    return UserResponseModel.fromJson(response);
  }

}

class AddressRepository{
  ApiProvider _apiProvider = ApiProvider();

  Future<AllUserResponseModel> getAddressByUser(CommonRequest request) async {
    final response = await _apiProvider.get(
        "${Constants.GET_ADDRESS}?limit=${request.limit}&page_no=${request.page_no}&search=${request.search}");
    return AllUserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> createAddressByUser(AddressRequest addressRequest) async {
    final response = await _apiProvider.postWithToken(
        Constants.GET_ADDRESS, jsonEncode(addressRequest));
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> updateAddressByUser(String addressId, AddressRequest addressRequest) async {
    final response = await _apiProvider.put("${Constants.GET_ADDRESS}/$addressId", body: jsonEncode(addressRequest));
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> deleteAddressByUser(String addressId) async {
    final response = await _apiProvider.delete("${Constants.GET_ADDRESS}/$addressId");
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> getAddressByUserWithAddressId(String addressId) async {
    final response = await _apiProvider.get("${Constants.GET_ADDRESS}/$addressId");
    return UserResponseModel.fromJson(response);
  }
}

class CartRepository{
  ApiProvider _apiProvider = ApiProvider();

  Future<AllUserResponseModel> getCart(CommonRequest request) async {
    final response = await _apiProvider.get(
        "${Constants.ADMIN_CART}?limit=${request.limit}&page_no=${request.page_no}");
    return AllUserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> addToCart(CartRequest request) async {
    final response = await _apiProvider.postWithToken(
        Constants.ADMIN_CART, jsonEncode(request));
    return UserResponseModel.fromJson(response);
  }


  Future<UserResponseModel> updateCart(String id, CartRequest request) async {
    final response = await _apiProvider.put("${Constants.ADMIN_CART}/$id", body: jsonEncode(request));
    return UserResponseModel.fromJson(response);
  }

  Future<UserResponseModel> deleteCart(String userId) async {
    final response = await _apiProvider.delete("${Constants.ADMIN_CART}/$userId");
    return UserResponseModel.fromJson(response);
  }

}
