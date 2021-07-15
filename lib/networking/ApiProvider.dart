import 'dart:io';

import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:io' show Platform;

import 'CustomException.dart';

class ApiProvider{
  // final String _baseUrl = "http://192.168.2.21:3000";
  // final String _baseUrl = "http://35.183.182.55:3000";
  final String _baseUrl = "https://api.dashbeautyshop.com";

  Future<dynamic> patch(String url,{var body}) async {
    var responseJson;
    try {
      var token = await getAuthToken();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      print(token);
      final response = await http.patch(Uri.parse(_baseUrl + url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },body: body);
      print(response.request);
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      var token = await getAuthToken();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      print(token);
      final response = await http.get(Uri.parse(_baseUrl + url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "Authorization": "Bearer " + token,
      });
      responseJson = _response(response);
    } on SocketException {
      throw NoInternetException(Constants.NO_INTERNET);
    }
    return responseJson;
  }

  Future<dynamic> post(String url, {var body}) async {
    var responseJson;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            //'accept': '*/*'
          },
          body: body);
      print(response.request);
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  ///upload image
  Future<dynamic> uploadImage(String url, {var body}) async {
    var responseJson;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    try {
      var token = await getAuthToken();

      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: {
            "Authorization": "Bearer " + token,
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: body);
      print(response.request);
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url,{var body}) async {
    var responseJson;
    var response;
    try {
      var token = await getAuthToken();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      if(body==null){
        response = await http.put(Uri.parse(_baseUrl + url),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              "Authorization": "Bearer " + token,
            });
      }else{
        response = await http.put(Uri.parse(_baseUrl + url),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              "Authorization": "Bearer " + token,
            },
            body: json.encode(body));
      }
      print(response.request);
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postWithToken(String url, {var body}) async {
    var responseJson;
    try {
      var token = await getAuthToken();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      final response = await http.post(Uri.parse(_baseUrl+ url),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Authorization": "Bearer " + token
          },
          body: body);
      print(response.request);
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var responseJson;
    try {
      var token = await getAuthToken();
      print(token);
      final response = await http.delete(Uri.parse(_baseUrl + url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "Authorization": "Bearer " + token,
      });
      responseJson = _response(response);
    } on SocketException {
      throw NoInternetException(Constants.NO_INTERNET);
    }
    return responseJson;
  }


  Future<String> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Constants.AUTHTOKEN);
    return token;
  }

  dynamic _response(http.Response response) {
    print(response.statusCode);

    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 201:
      case 204:
        return "Success";
      case 400:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw BadRequestException(msg);
      case 401:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw InvalidInputException(msg);
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        var responseJson = json.decode(response.body.toString());
        var error =
        responseJson["errors"] != null ? responseJson["errors"] : "";
        var msg = "";
        if (error != "") {
          msg = error["message"] != null ? error["message"] : "";
        }
        throw BadRequestException(msg ?? response.body.toString());
    // } else {
    //   throw BadRequestException(response.body.toString());
    // }
      case 422:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw BadRequestException(msg);
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

}