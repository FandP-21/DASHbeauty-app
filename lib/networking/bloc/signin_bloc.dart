import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:shop_app/models/logout_model.dart';
import 'package:shop_app/models/signin_model.dart';
import 'package:shop_app/networking/repository/Repository.dart';

import '../Response.dart';

class SignInBloc {
  SignInRepository _signInRepository;
  StreamController _signInBlocController;

  LogoutRepository _logoutRepository;
  StreamController _logoutBlocController;

  StreamSink<Response<SignInResponseModel>> get signInDataSink =>
      _signInBlocController.sink;
  Stream<Response<SignInResponseModel>> get signInStream =>
      _signInBlocController.stream;

  StreamSink<Response<LogoutResponseModel>> get logoutDataSink =>
      _logoutBlocController.sink;
  Stream<Response<LogoutResponseModel>> get logoutStream =>
      _logoutBlocController.stream;



  SignInBloc() {
    _signInBlocController = StreamController<Response<SignInResponseModel>>();
    _signInRepository = SignInRepository();
    _logoutBlocController = StreamController<Response<LogoutResponseModel>>();
    _logoutRepository = LogoutRepository();

  }

  bool isLoggedIn = false;

  loginUser(SignInRequest user) async {
    signInDataSink.add(Response.loading('login'));
    try {
      SignInResponseModel loginData = await _signInRepository.loginUser(user);
      print(loginData);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Constants.AUTHTOKEN, loginData.userDetails.accessToken);

      prefs.setString(Constants.USERID,loginData.userDetails.id);
      // prefs.setString(Constants.DRIVERID,loginData.driverId);
      prefs.setString(Constants.EMAIL,user.email);
      prefs.setString(Constants.FIRSTNAME,loginData.userDetails.firstName);
      prefs.setString(Constants.LASTNAME,loginData.userDetails.lastName);
      prefs.setString(Constants.PROFILEPIC,loginData.userDetails.profilePic);
      // prefs.setString(Constants.STATUS,loginData.status);
      // prefs.setString(Constants.LEGALENTITY,loginData.legalEntity);
      // prefs.setInt(Constants.EXPIRESIN,loginData.expiresIn);

      isLoggedIn = true;
      //print(prefs.getString(Constants.FIRSTNAME));

      signInDataSink.add(Response.completed(loginData));
    } catch (e) {
      signInDataSink.add(Response.error(e.toString()));
      isLoggedIn = false;
      print(e);
    }
    return null;
  }

  logout(String id) async {
    logoutDataSink.add(Response.loading('login'));
    try {
      LogoutResponseModel loginData = await _logoutRepository.logout(id);
      print(loginData);

      logoutDataSink.add(Response.completed(loginData));
    } catch (e) {
      logoutDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }



  dispose() {
    _signInBlocController.close();
    _logoutBlocController.close();

  }
}
