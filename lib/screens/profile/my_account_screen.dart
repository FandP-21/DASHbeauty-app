import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/models/get_profile_details_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/getProfileDetails_bloc.dart';
import 'package:shop_app/constants.dart' as Constants;
import '../../size_config.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {

GetProfileDetailsBloc _bloc;
GetProfileDetailsModel _getProfileDetailsModel;

  @override
  void initState() {
    super.initState();

    _bloc = GetProfileDetailsBloc();

    _bloc.getProfile();
    _bloc.getProfileDetailsStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            _getProfileDetailsModel = event.data;
            //navigateToTab(context);
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

   // initPref();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
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
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  if (_getProfileDetailsModel != null)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: _getProfileDetailsModel.email,
                      enabled: false,
                      // If  you are using latest version of flutter then lable text and hint text shown like this
                      // if you r using flutter less then 1.20.* then maybe this is not working properly
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon:
                          CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  if (_getProfileDetailsModel != null && _getProfileDetailsModel.storeId != null)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Store-ID",
                      hintText: _getProfileDetailsModel.storeId,
                      enabled: false,
                      // If  you are using latest version of flutter then lable text and hint text shown like this
                      // if you r using flutter less then 1.20.* then maybe this is not working properly
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon:
                      CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
