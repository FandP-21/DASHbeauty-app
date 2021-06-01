import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';
import 'package:shop_app/constants.dart' as Constants;
Future<void> main() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var token = prefs.getString(Constants.EMAIL);


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /*String token;
  MyApp(this.token);*/
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      routes: routes,
    );
  }
}
