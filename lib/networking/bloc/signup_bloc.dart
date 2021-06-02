import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:shop_app/models/singup_model.dart';
import 'package:shop_app/networking/repository/Repository.dart';

import '../Response.dart';

class SignUpBloc {
  SignUpRepository _signUpRepository;
  StreamController _signUpBlocController;
  StreamSink<Response<SignUpResponseModel>> get signUpDataSink =>
      _signUpBlocController.sink;
  Stream<Response<SignUpResponseModel>> get signUpStream =>
      _signUpBlocController.stream;


  SignUpBloc() {
    _signUpBlocController = StreamController<Response<SignUpResponseModel>>();
    _signUpRepository = SignUpRepository();
  }

 // bool isLoggedIn = false;

  registerUser(RegisterRequest user) async {
  //  signUpDataSink.add(Response.loading('login'));
    try {
      SignUpResponseModel loginData = await _signUpRepository.registerUser(user);
      print(loginData);

     // isLoggedIn = true;
      //print(prefs.getString(Constants.FIRSTNAME));

      signUpDataSink.add(Response.completed(loginData));
    } catch (e) {
      signUpDataSink.add(Response.error(e.toString()));
      //isLoggedIn = false;
      print(e);
    }
    return null;
  }

  dispose() {
    _signUpBlocController.close();
  }
}
