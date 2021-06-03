import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/components/no_account_text.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/signin_bloc.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/reset_password/reset_password.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:fluttertoast/fluttertoast.dart';


import '../../../constants.dart';
import 'forget_pass_form.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

 final _formKey = GlobalKey<FormState>();
 List<String> errors = [];
 String otp;
 AutovalidateMode _autoValidate = AutovalidateMode.disabled;
 SignInBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    ) ;
  }
}

