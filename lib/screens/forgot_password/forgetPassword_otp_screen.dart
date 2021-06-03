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

class ForgetPassOtpScreen extends StatefulWidget {
  String email;
  ForgetPassOtpScreen(this.email);

  @override
  _ForgetPassOtpScreenState createState() => _ForgetPassOtpScreenState();
}

class _ForgetPassOtpScreenState extends State<ForgetPassOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String otp;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  SignInBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Enter OTP",
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

                ///OTP Form after entering Email
                Form(
                  key: _formKey,
                  autovalidateMode: _autoValidate,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onSaved: (newValue) => otp = newValue,
                        // onChanged: (value) {
                        //   if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                        //     setState(() {
                        //       errors.remove(kEmailNullError);
                        //     });
                        //   } else if (emailValidatorRegExp.hasMatch(value) &&
                        //       errors.contains(kInvalidEmailError)) {
                        //     setState(() {
                        //       errors.remove(kInvalidEmailError);
                        //     });
                        //   }
                        //   return null;
                        // },
                        // validator: (value) {
                        //   if (value.isEmpty && !errors.contains(kEmailNullError)) {
                        //     setState(() {
                        //       errors.add(kEmailNullError);
                        //     });
                        //   } else if (!emailValidatorRegExp.hasMatch(value) &&
                        //       !errors.contains(kInvalidEmailError)) {
                        //     setState(() {
                        //       errors.add(kInvalidEmailError);
                        //     });
                        //   }
                        //   return null;
                        // },
                        decoration: InputDecoration(
                          labelText: "OTP",
                          hintText: "Enter OTP code",
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon:
                          CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      FormError(errors: errors),
                      SizedBox(height: SizeConfig.screenHeight * 0.1),
                      DefaultButton(
                        text: "Reset Password",
                        press: () => validatePassword(),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.1),
                      NoAccountText(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  validatePassword() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  ResetPasswordScreen(widget.email, otp)),
          (route) => false);
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    }
  }
}
