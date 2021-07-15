import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:shop_app/models/logout_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/signin_bloc.dart';
import 'package:shop_app/screens/my_orders/my_order_screen.dart';
import 'package:shop_app/screens/profile/change_password_screen.dart';
import 'package:shop_app/screens/profile/change_storeID_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import '../my_account_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  SharedPreferences prefs;
  SignInBloc _bloc;
  LogoutResponseModel _logoutResponseModel;
  @override
  void initState() {
    super.initState();

    getPref();

    _bloc = SignInBloc();
    _bloc.logoutStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            _logoutResponseModel = event.data;
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
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
         // ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyAccount()))
          ),
          ProfileMenu(
            text: "Change Store-ID",
            icon: "assets/icons/Bell.svg",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangeStoreID()));
            },
          ),
          ProfileMenu(
            text: "Change Password",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePassword()));
            },
          ),
          ProfileMenu(
            text: "My Orders",
            icon: "assets/icons/Question mark.svg",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyOrderScreen()));
            },
          ),
          ProfileMenu(
            text: "Payments",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () => _logoutDialog(),
          ),
        ],
      ),
    );
  }

  Future<void> _logoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      // user must tap button!
      builder: (BuildContext context) {
        return Container(
            child: AlertDialog(
              contentPadding: EdgeInsets.all(30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13.0))),
              content: SingleChildScrollView(
                child: Center(
                  child: ListBody(
                    children: <Widget>[
                      Text(
                        'Log Out',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: Constants.FontFamily,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Are you sure you want to logout?",
                        style: TextStyle(
                            color: Color(0xFF595857),
                            fontFamily: Constants.FontFamily,
                            fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Color(0XFFFF0000),
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: Constants.FontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        logout();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 50,
                  child: FlatButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Color(0xFF595857),
                          fontFamily: Constants.FontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ));
      },
    );
  }
  void logout() async {
    // prefs.remove(Constants.EMAIL);
    _bloc.logout(prefs.getString(Constants.USERID));
    prefs.clear();
  }

  Future<void> getPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void navigateToTab(BuildContext context) {


    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
            (route) => false);
  }



}
