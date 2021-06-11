import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/size_config.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kStoreIdNullError = "Please Enter your Store-ID";

const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short (minimum 8 letters)";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}


//MARK: - SHARED PREFRENCE KEY
const String AUTHTOKEN = "auth_token";

const String REMEMBER_ME = "remember_me";

const String USERID = "userId";
const String EMAIL = "email";
const String DRIVERID = "driverId";
const String PASSWORD = "password";
const String FIRSTNAME = "firstName";
const String LASTNAME = "lastName";
const String STATUS = "status";
const String SPLASHSHOWEN = "splashshowen";
const String PROFILEPIC = "profilePic";


const String NO_INTERNET = "No Internet";

//END Points
const String GoogleAPI = "/auth/google";
const String FacebookAPI = "/auth/facebook";
const String AppleAPI = "/auth/apple/app";

const PrimaryColor = Color(0xFF576ED6);
const darkGreyColor = Color(0xFF808080);
const greyColor = Color(0xFF6F6E76);
const lightBlueColor = Color(0xFFD6DBF3);

const String FontRegular = "Inter";
const String FontMedium = "FoundersGrotesk-Medium";
const String FontFamily = "Inter";

const String TERMS_URL = "https://google.com/terms";
const String PRIVACY_URL = "https://google.com/privacy";


var hasUnreadNotifcation = false;

String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
  DateTime date = DateTime.parse(dateString);
  final date2 = DateTime.now();
  final difference = date2.difference(date);
  if ((difference.inDays / 365).floor() >= 2) {
    return '${(difference.inDays / 365).floor()} years ago';
  } else if ((difference.inDays / 365).floor() >= 1) {
    return (numericDates) ? '1 year ago' : 'Last year';
  } else if ((difference.inDays / 30).floor() >= 2) {
    return '${(difference.inDays / 365).floor()} months ago';
  } else if ((difference.inDays / 30).floor() >= 1) {
    return (numericDates) ? '1 month ago' : 'Last month';
  } else if ((difference.inDays / 7).floor() >= 2) {
    return '${(difference.inDays / 7).floor()} weeks ago';
  } else if ((difference.inDays / 7).floor() >= 1) {
    return (numericDates) ? '1 week ago' : 'Last week';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays >= 1) {
    return (numericDates) ? '1 day ago' : 'Yesterday';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} hours ago';
  } else if (difference.inHours >= 1) {
    return (numericDates) ? '1 hour ago' : 'An hour ago';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inMinutes >= 1) {
    return (numericDates) ? '1 minute ago' : 'A minute ago';
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds} seconds ago';
  } else {
    return 'Just now';
  }
}

void onLoading(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.white.withOpacity(0.5),
    // background color
    barrierDismissible: false,
    // should dialog be dismissed when tapped outside
    barrierLabel: "Dialog",
    // label for barrier
    transitionDuration: Duration(milliseconds: 400),
    // how long it takes to popup dialog after button click
    pageBuilder: (_, __, ___) {
      // your widget implementation
      return SizedBox.expand(
        // makes widget fullscreen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset('assets/upclip--loading.json', width: 30, height: 30)
          ],
        ),
      );
    },
  );
}

void stopLoader(BuildContext context) {
  Navigator.pop(context);
}

Future<void> showMyDialog(String msg, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Alert',
          style: TextStyle(
              color: Colors.black,
              fontFamily: FontRegular,
              fontWeight: FontWeight.w600,
              fontSize: 20),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                msg,
                style: TextStyle(
                    color: Colors.grey, fontFamily: FontRegular, fontSize: 16),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: FlatButton(
                color: Colors.pink,
                child: Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontRegular,
                      fontSize: 16),
                ),
                onPressed: () async {
                  if(msg.contains("Unauthorised")){
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear();

                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        SignInScreen()), (Route<dynamic> route) => false);
                  }else{
                    Navigator.of(context).pop();
                  }

                },
              ),
            ),
          )
        ],
      );
    },
  );
}
