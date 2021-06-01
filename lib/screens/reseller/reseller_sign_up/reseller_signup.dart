import 'package:flutter/material.dart';
import 'components/body.dart';

class ResellerSignUpScreen extends StatelessWidget {
  static String routeName = "/reseller_sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Become Reseller"),
      ),
      body: Body(),
    );
  }
}
