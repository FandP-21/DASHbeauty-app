import 'dart:convert';

import 'package:shop_app/models/signin_model.dart';

import '../ApiProvider.dart';

class SignInRepository {
  ApiProvider _apiProvider = ApiProvider();
  Future<SignInResponseModel> loginUser(SignInRequest user) async {
    final response = await _apiProvider.post("/v1/auth/mobile-signin", body:jsonEncode(user));
    return SignInResponseModel.fromJson(response);
  }

/*  Future<LoginResponseModel> forgetPassword(String user) async {
    final response = await _apiProvider.post("/login/reset/$user", body: {});
    return LoginResponseModel.fromJson(response);
  }

  Future<bool> updateToken(String driverId,String token) async {
    //users/d30da614-bf69-4586-a3fb-98689a463c56/externalIds/EXPO_PUSH/abc
    await _apiProvider.put('/users/$driverId/externalIds/ONE_SIGNAL_DRIVER/$token',body: {
      "externalIdProvider": "ONE_SIGNAL_DRIVER",
      "id": token
    });
    return true;
  }*/
}


