import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/components/no_account_text.dart';
import 'package:shop_app/models/forgot_password_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/forgetPassword_bloc.dart';
import 'package:shop_app/networking/bloc/reset_password_bloc.dart';
import 'package:shop_app/networking/bloc/signin_bloc.dart';
import 'package:shop_app/screens/forgot_password/forgetPassword_otp_screen.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/reset_password/reset_password.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String email;
  String otp;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  ForgetPasswordBloc _bloc;
  //ResetPasswordBloc _resetPasswordBloc;

  void initState() {
    _bloc = ForgetPasswordBloc();
    //_resetPasswordBloc = ResetPasswordBloc();

    _bloc.forgetPasswordStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            Fluttertoast.showToast(
                msg: "We have sent a OTP to you email address.");
            navigateToTab(context);
            break;
          case Status.ERROR:
            print(event.message);
            Constants.stopLoader(context);
            if (event.message == "Invalid Request: null") {
              Constants.showMyDialog("Invalid Credentials.", context);
            } else {
              Constants.showMyDialog(event.message, context);
            }
            break;
        }
      });
    });

    /* _resetPasswordBloc.resetPasswordStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            Fluttertoast.showToast( msg: "SignIn to Continue");
            navigateToSignIn(context);
            break;
          case Status.ERROR:
            print(event.message);
            Constants.stopLoader(context);
            if (event.message == "Invalid Request: null") {
              Constants.showMyDialog("Invalid Credentials.", context);
            } else {
              Constants.showMyDialog(event.message, context);
            }
            break;
        }
      });
    });*/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
            key: _formKey,
            autovalidateMode: _autoValidate,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) => email = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                      setState(() {
                        errors.remove(kEmailNullError);
                      });
                    } else if (emailValidatorRegExp.hasMatch(value) &&
                        errors.contains(kInvalidEmailError)) {
                      setState(() {
                        errors.remove(kInvalidEmailError);
                      });
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty && !errors.contains(kEmailNullError)) {
                      setState(() {
                        errors.add(kEmailNullError);
                      });
                    } else if (!emailValidatorRegExp.hasMatch(value) &&
                        !errors.contains(kInvalidEmailError)) {
                      setState(() {
                        errors.add(kInvalidEmailError);
                      });
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
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
                  text: "Continue",
                  press: () => validateInputs(),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                NoAccountText(),
              ],
            ),
          );
  }

  void validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      var user = ForgotPasswordRequest(email: email);

      _bloc.forgetPassword(user);
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    }
  }

  navigateToTab(BuildContext context) async {
    // prefs.setBool(Constants.REMEMBER_ME, rememberMe);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ForgetPassOtpScreen(email)),(route) => false);
  }

  validatePassword() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  ResetPasswordScreen(email, otp)),
          (route) => false);
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    }
  }
}
