import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/otp_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/otp_bloc.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/size_config.dart';

import 'otp_form.dart';
import 'package:shop_app/constants.dart' as Constants;

class Body extends StatefulWidget {
  String email;
  Body(this.email);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  OtpBloc _bloc;
  @override
  void initState() {
    super.initState();
    
    _bloc = OtpBloc();
    _bloc.resendOtpUpStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
           // navigateToTab(context);
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
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              Text("We sent your code to ${widget.email}"),
              buildTimer(),
              OtpForm(widget.email),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  navigateToTab(context);                },
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }

  void navigateToTab(BuildContext context) {
    var user = ResendOtpRequest(
      email: widget.email ,
    );
    _bloc.resendOtp(user);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => OtpScreen(widget.email)));
  }
}
