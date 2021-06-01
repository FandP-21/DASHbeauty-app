import 'package:flutter/material.dart';

import 'components/body.dart';

class ResellerSignInScreen extends StatelessWidget {
  static String routeName = "/reseller_sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reseller Sign In"),
      ),
      body: Body(),
    );
  }
}
