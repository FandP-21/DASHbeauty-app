import 'package:flutter/material.dart';

import 'components/body.dart';

class ResetPasswordScreen extends StatelessWidget {
  static String routeName = "/reset_password";
  String email;
  String otp;
  ResetPasswordScreen(this.email, this.otp );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: Body(email, otp),
    );
  }
}
