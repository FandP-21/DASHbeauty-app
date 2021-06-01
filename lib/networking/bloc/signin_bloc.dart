import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:shop_app/models/signin_model.dart';
import 'package:shop_app/networking/repository/Repository.dart';

import '../Response.dart';

class SignInBloc {
  SignInRepository _signInRepository;
  StreamController _signInBlocController;
  StreamSink<Response<SignInResponseModel>> get signInDataSink =>
      _signInBlocController.sink;
  Stream<Response<SignInResponseModel>> get signInStream =>
      _signInBlocController.stream;


  SignInBloc() {
    _signInBlocController = StreamController<Response<SignInResponseModel>>();
    _signInRepository = SignInRepository();
  }

  bool isLoggedIn = false;

  loginUser(SignInRequest user) async {
    signInDataSink.add(Response.loading('login'));
    try {
      SignInResponseModel loginData = await _signInRepository.loginUser(user);
      print(loginData);

  /*    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Constants.AUTHTOKEN, loginData.userDetails.accessToken);

      prefs.setString(Constants.USERID,loginData.userId);
      prefs.setString(Constants.DRIVERID,loginData.driverId);
      prefs.setString(Constants.EMAIL,user.email);
      prefs.setString(Constants.FIRSTNAME,loginData.firstName);
      prefs.setString(Constants.LASTNAME,loginData.lastName);
      prefs.setString(Constants.STATUS,loginData.status);
      prefs.setString(Constants.LEGALENTITY,loginData.legalEntity);
      prefs.setInt(Constants.EXPIRESIN,loginData.expiresIn);*/

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


/*  forgetPassword(String email) async {
    loginDataSink.add(Response.loading('login'));
    try {
      LoginResponseModel loginData = await _loginRepository.forgetPassword(email);
      print(loginData);

      loginDataSink.add(Response.completed(loginData));
    } catch (e) {
      loginDataSink.add(Response.error(e.toString()));
      isLoggedIn = false;
      print(e);
    }
    return null;
  }*/

/*  updateToken(String driverId,String token) async {
    updateTokenSink.add(Response.loading('login'));
    try {
      bool _data = await _loginRepository.updateToken(driverId, token);
      print(_data);

      updateTokenSink.add(Response.completed(true));
    } catch (e) {
      updateTokenSink.add(Response.error(e.toString()));
      isLoggedIn = false;
      print(e);
    }
    return null;
  }*/


  dispose() {
    _signInBlocController.close();
  }
}
