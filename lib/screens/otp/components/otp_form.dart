import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/otp_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/otp_bloc.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/reset_password/reset_password.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/constants.dart' as Constants;
import '../../../constants.dart';

class OtpForm extends StatefulWidget {
  String email;
  OtpForm(this.email, {
    Key key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  OtpBloc _bloc;

  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;
  String pin1;
  String pin2;
  String pin3;
  String pin4;
  String pin5;
  String pin6;



  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();

    _bloc = OtpBloc();
    _bloc.otpUpStream.listen((event) {
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
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidate,
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          Wrap(
            //crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            runSpacing: 20,
            spacing: 20,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onSaved: (newValue) => pin1 = newValue,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onSaved: (newValue) => pin2 = newValue,

                  onChanged: (value) => nextField(value, pin3FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onSaved: (newValue) => pin3 = newValue,

                  onChanged: (value) => nextField(value, pin4FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onSaved: (newValue) => pin4 = newValue,

                  onChanged: (value) => nextField(value, pin5FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin5FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onSaved: (newValue) => pin5 = newValue,

                  onChanged: (value) => nextField(value, pin6FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin6FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onSaved: (newValue) => pin6 = newValue,

                  onChanged: (value) {
                    if (value.length == 1) {
                      pin6FocusNode.unfocus();
                      // Then you need to check is the code is correct or not
                    }
                  },
                ),
              ),

            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Continue",
            press: () => validateInputs(),
          )
        ],
      ),
    );
  }

  void validateInputs() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate() &&
        pin1.isNotEmpty &&
        pin3.isNotEmpty) {
      var user = OtpRequest(
          email: widget.email ,
          otp: pin1+pin2+pin3+pin4+pin5+pin6,
      );
      _bloc.otpVerification(user);
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
            builder: (BuildContext context) => HomeScreen()));

  }

}
