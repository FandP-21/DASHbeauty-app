import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:shop_app/models/reset_password_model.dart';
import 'package:shop_app/models/singup_model.dart';
import 'package:shop_app/networking/repository/Repository.dart';

import '../Response.dart';

class ResetPasswordBloc {
  ResetPasswordRepository _resetPasswordRepository;
  StreamController _resetPasswordBlocController;
  StreamSink<Response<ResetPasswordModel>> get resetPasswordDataSink =>
      _resetPasswordBlocController.sink;
  Stream<Response<ResetPasswordModel>> get resetPasswordStream =>
      _resetPasswordBlocController.stream;


  ResetPasswordBloc() {
    _resetPasswordBlocController = StreamController<Response<ResetPasswordModel>>();
    _resetPasswordRepository = ResetPasswordRepository();
  }

  // bool isLoggedIn = false;

  resetPassword(ResetPasswordRequest user, String otp) async {
    //  signUpDataSink.add(Response.loading('login'));
    try {
      ResetPasswordModel loginData = await _resetPasswordRepository.resetPassword(user, otp);
      print(loginData);

      // isLoggedIn = true;
      //print(prefs.getString(Constants.FIRSTNAME));

      resetPasswordDataSink.add(Response.completed(loginData));
    } catch (e) {
      resetPasswordDataSink.add(Response.error(e.toString()));
      //isLoggedIn = false;
      print(e);
    }
    return null;
  }

  dispose() {
    _resetPasswordBlocController.close();
  }
}
