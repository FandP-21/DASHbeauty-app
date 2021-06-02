import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/splash/components/body.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/constants.dart' as Constants;


class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isSpashShowen = true;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    updatePref();
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }

  Future<void> updatePref() async {
    await SharedPreferences.getInstance().then((value) => value.setBool(Constants.SPLASHSHOWEN, isSpashShowen));
  }
}
