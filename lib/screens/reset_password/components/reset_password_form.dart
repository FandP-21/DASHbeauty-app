import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/models/reset_password_model.dart';
import 'package:shop_app/models/singup_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/reset_password_bloc.dart';
import 'package:shop_app/networking/bloc/signup_bloc.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';


class ResetPasswordForm extends StatefulWidget {
  String email;
  String otp;
  ResetPasswordForm(this.email, this.otp);

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String password;
  String confirmPassword;
  String storeId;
  bool remember = false;
  final List<String> errors = [];
  ResetPasswordBloc _bloc;
  final focus = FocusNode();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;



  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    super.initState();

    _bloc = ResetPasswordBloc();
    _bloc.resetPasswordStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            Fluttertoast.showToast( msg: "SignIn to Continue");
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
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidate,
      child: Column(
        children: [
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Change Password",
            press: () => validateInputs(),
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirmPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirmPassword) {
          removeError(error: kMatchPassError);
        }
        confirmPassword = value;
      },
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }


  void validateInputs() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate() &&
        confirmPassword.isNotEmpty &&
        password.isNotEmpty) {
      var user = ResetPasswordRequest(
          email: widget.email,
          newPassword: password,
        confirmPassword: confirmPassword,
      );
      _bloc.resetPassword(user, widget.otp);
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    }
  }
  navigateToTab(BuildContext context) async {

   // prefs.setBool(Constants.REMEMBER_ME, rememberMe);


    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => SignInScreen()));
  }

}
