import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/models/update_profile_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/getProfileDetails_bloc.dart';
import 'package:shop_app/constants.dart' as Constants;
import '../../constants.dart';
import '../../size_config.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final _formKey = GlobalKey<FormState>();
  String oldPassword;
  String password;
  String confirmPassword;
  final List<String> errors = [];
  final focus = FocusNode();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  GetProfileDetailsBloc _bloc;
  SharedPreferences prefs;
  UpdateProfileDetailsModel _updateProfileDetailsModel;

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

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  Form(
                    key: _formKey,
                    autovalidateMode: _autoValidate,
                    child: Column(
                      children: [
                        TextFormField(
                          obscureText: true,
                          onSaved: (newValue) => oldPassword = newValue,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kPassNullError);
                            } else if (value.length >= 8) {
                              removeError(error: kShortPassError);
                            }
                            oldPassword = value;
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
                            labelText: "Old Password",
                            hintText: "Enter your current password",
                            // If  you are using latest version of flutter then lable text and hint text shown like this
                            // if you r using flutter less then 1.20.* then maybe this is not working properly
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        TextFormField(
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
                            labelText: "New Password",
                            hintText: "Enter New password",
                            // If  you are using latest version of flutter then lable text and hint text shown like this
                            // if you r using flutter less then 1.20.* then maybe this is not working properly
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        TextFormField(
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
                            labelText: "Confirm New Password",
                            hintText: "Re-enter your New password",
                            // If  you are using latest version of flutter then lable text and hint text shown like this
                            // if you r using flutter less then 1.20.* then maybe this is not working properly
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                          ),
                        ),
                        FormError(errors: errors),
                        SizedBox(height: getProportionateScreenHeight(40)),
                        DefaultButton(
                          text: "Change Store-ID",
                          press: () => validateInputs(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateInputs() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate() &&
        oldPassword.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      /*var user = UpdateProfileRequest(
        storeId: storeId,
        firstName: "Jon",
        lastName: "Doe",
      );
      _bloc.updateProfile(user);*/
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    }
  }
}
