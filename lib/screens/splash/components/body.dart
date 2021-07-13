import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/size_config.dart';

// This is the best practice
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to DASHbeauty, Let’s shop!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
      "We help people conect with store \naround Canada",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];

  Widget continueButton = FlatButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Text(
      "Continue",
      style: TextStyle(
        fontSize: getProportionateScreenWidth(18),
        color: Colors.white,
      ),
    ),
  );


  void buttonState() async {

    await new Future.delayed(const Duration(seconds: 10));
    continueButton;

  }
@override
  void initState() {
    // TODO: implement initState
    buttonState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Image.asset(
                "assets/logo/logo_design_transparent.png",
                width: getProportionateScreenWidth(250),
              ),
              Spacer(),

              InkWell(onTap: () {
                Navigator.pushNamed(context, SignInScreen.routeName);
              }, child: continueButton),
              SizedBox(height: 40,),

            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
