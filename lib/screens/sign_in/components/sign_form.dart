import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/helper/keyboard.dart';
import 'package:shop_app/models/signin_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/signin_bloc.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/constants.dart' as Constants;
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {




  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  bool passwordVisible = true;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  TextEditingController _editControllerEmail = TextEditingController();
  TextEditingController _editControllerPassword = TextEditingController();
  final List<String> errors = [];
  final focus = FocusNode();
  SignInBloc _bloc;
  SharedPreferences pref;

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

    _bloc = SignInBloc();
    _bloc.signInStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
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

    initPref();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidate,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: 30),
          buildPasswordFormField(),
          SizedBox(height: 30),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: 20),
          DefaultButton(
            text: "Continue",
            press: () => validateInputs(),
            /*{
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },*/
          ),
        ],
      ),
    );
  }

  void validateInputs() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate() &&
        email.isNotEmpty &&
        password.isNotEmpty) {
      var user = SignInRequest(
          email: email,
          password: password,
          device_type: "1",
          device_model: "RNE-L22",
          device_token: "123abc#%456",
          app_version: "1.0",
          os_version: "7.0");
      _bloc.loginUser(user);
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    }
  }


  TextFormField buildPasswordFormField() {
    return TextFormField(
      focusNode: focus,
      obscureText: passwordVisible,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
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
        suffixIcon: passwordVisible
            ? InkWell(
                onTap: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                child: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"))
            : InkWell(
                onTap: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    if (passwordVisible == false) passwordVisible = true;
                  });
                },
                child: CustomSurffixIcon(
                  svgIcon: "assets/icons/Lock.svg",
                  svgIconColor: Colors.deepOrange,
                ),
              ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _editControllerEmail,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(focus);
      },
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  Future<void> initPref() async {

    await SharedPreferences.getInstance();

    if(pref.getString(Constants.EMAIL) != null){
      setState(() {
        // _password = prefs.getString(Constants.PASSWORD);
        email = pref.getString(Constants.EMAIL);
      });
    }


  }
  navigateToTab(BuildContext context) async {

    // prefs.setBool(Constants.REMEMBER_ME, rememberMe);


    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen()),(route) => false);
  }
}
