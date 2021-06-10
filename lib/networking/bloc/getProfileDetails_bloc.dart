import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:shop_app/models/get_profile_details_model.dart';
import 'package:shop_app/models/singup_model.dart';
import 'package:shop_app/networking/repository/Repository.dart';

import '../Response.dart';

class GetProfileDetailsBloc {
  GetProfileDetailsRepository _getProfileDetailsRepository;
  StreamController _getProfileDetailsBlocController;
  StreamSink<Response<GetProfileDetailsModel>> get getProfileDetailsDataSink =>
      _getProfileDetailsBlocController.sink;
  Stream<Response<GetProfileDetailsModel>> get getProfileDetailsStream =>
      _getProfileDetailsBlocController.stream;


  GetProfileDetailsBloc() {
    _getProfileDetailsBlocController = StreamController<Response<GetProfileDetailsModel>>();
    _getProfileDetailsRepository = GetProfileDetailsRepository();
  }

  // bool isLoggedIn = false;

  getProfile() async {
    //  signUpDataSink.add(Response.loading('login'));
    try {
      GetProfileDetailsModel loginData = await _getProfileDetailsRepository.getProfile();
      print(loginData);

      // isLoggedIn = true;
      //print(prefs.getString(Constants.FIRSTNAME));

      getProfileDetailsDataSink.add(Response.completed(loginData));
    } catch (e) {
      getProfileDetailsDataSink.add(Response.error(e.toString()));
      //isLoggedIn = false;
      print(e);
    }
    return null;
  }

  dispose() {
    _getProfileDetailsBlocController.close();
  }
}
