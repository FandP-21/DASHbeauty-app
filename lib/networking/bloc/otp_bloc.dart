import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:shop_app/models/logout_model.dart';
import 'package:shop_app/models/otp_model.dart';
import 'package:shop_app/models/resendOtp_model.dart';
import 'package:shop_app/models/singup_model.dart';
import 'package:shop_app/networking/repository/Repository.dart';

import '../Response.dart';

class OtpBloc {
  OtpRepository _otpRepository;
  StreamController _otpBlocBlocController;
  StreamSink<Response<OtpResponseModel>> get otpDataSink =>
      _otpBlocBlocController.sink;
  Stream<Response<OtpResponseModel>> get otpUpStream =>
      _otpBlocBlocController.stream;

  StreamController _resendOtpBlocController;
  StreamSink<Response<ResendOtpModel>> get resendOtpDataSink =>
      _resendOtpBlocController.sink;
  Stream<Response<ResendOtpModel>> get resendOtpUpStream =>
      _resendOtpBlocController.stream;

  OtpBloc() {
    _otpBlocBlocController = StreamController<Response<OtpResponseModel>>();
    _resendOtpBlocController = StreamController<Response<ResendOtpModel>>();
    _otpRepository = OtpRepository();
  }

  bool isLoggedIn = false;

  otpVerification(OtpRequest user) async {
     otpDataSink.add(Response.loading('login'));
    try {
      OtpResponseModel loginData = await _otpRepository.otpVerification(user);
      print(loginData);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Constants.AUTHTOKEN, loginData.userDetails.accessToken);

      prefs.setString(Constants.USERID,loginData.userDetails.id);
      // prefs.setString(Constants.DRIVERID,loginData.driverId);
      prefs.setString(Constants.EMAIL,user.email);
      prefs.setString(Constants.FIRSTNAME,loginData.userDetails.firstName);
      prefs.setString(Constants.LASTNAME,loginData.userDetails.lastName);
      prefs.setString(Constants.PROFILEPIC,loginData.userDetails.profilePic);

      isLoggedIn = true;
      //print(prefs.getString(Constants.FIRSTNAME));

      otpDataSink.add(Response.completed(loginData));
    } catch (e) {
      otpDataSink.add(Response.error(e.toString()));
      isLoggedIn = false;
      print(e);
    }
    return null;
  }

  resendOtp(ResendOtpRequest user) async {
    resendOtpDataSink.add(Response.loading('login'));
    try {
      ResendOtpModel loginData = (await _otpRepository.resendOtp(user)) as ResendOtpModel;
      print(loginData);

      resendOtpDataSink.add(Response.completed(loginData));
    } catch (e) {
      resendOtpDataSink.add(Response.error(e.toString()));
      isLoggedIn = false;
      print(e);
    }
    return null;
  }

  dispose() {
    _otpBlocBlocController.close();
    _resendOtpBlocController.close();
  }
}
