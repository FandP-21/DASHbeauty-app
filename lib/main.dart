import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';
import 'package:shop_app/constants.dart' as Constants;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString(Constants.EMAIL);
  var splash = prefs.getBool(Constants.SPLASHSHOWEN);

  runApp(MyApp(token, splash));
}

class MyApp extends StatefulWidget {
  String token;
  bool splash;
  MyApp(this.token, this.splash);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: widget.splash == true ? widget.token == null ? SignInScreen() : HomeScreen(): SplashScreen() ,
      // We use routeName so that we dont need to remember the name
      routes: routes,
    );
  }
}
