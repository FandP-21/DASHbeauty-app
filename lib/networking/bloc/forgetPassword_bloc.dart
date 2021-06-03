import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:shop_app/models/forgot_password_model.dart';
import 'package:shop_app/models/singup_model.dart';
import 'package:shop_app/networking/repository/Repository.dart';

import '../Response.dart';

class ForgetPasswordBloc {
  ForgetPasswordRepository _forgetPasswordRepository;
  StreamController _forgetPasswordController;
  StreamSink<Response<ForgotPasswordModel>> get forgetPasswordDataSink =>
      _forgetPasswordController.sink;
  Stream<Response<ForgotPasswordModel>> get forgetPasswordStream =>
      _forgetPasswordController.stream;


  ForgetPasswordBloc() {
    _forgetPasswordController = StreamController<Response<ForgotPasswordModel>>();
    _forgetPasswordRepository = ForgetPasswordRepository();
  }

  // bool isLoggedIn = false;

  forgetPassword(ForgotPasswordRequest email) async {
    //  signUpDataSink.add(Response.loading('login'));
    try {
      ForgotPasswordModel loginData = await _forgetPasswordRepository.forgetPassword(email);
      print(loginData);

      // isLoggedIn = true;
      //print(prefs.getString(Constants.FIRSTNAME));

      forgetPasswordDataSink.add(Response.completed(loginData));
    } catch (e) {
      forgetPasswordDataSink.add(Response.error(e.toString()));
      //isLoggedIn = false;
      print(e);
    }
    return null;
  }

  dispose() {
    _forgetPasswordController.close();
  }
}
