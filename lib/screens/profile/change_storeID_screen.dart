import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/models/get_profile_details_model.dart';
import 'package:shop_app/models/update_profile_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/getProfileDetails_bloc.dart';
import 'package:shop_app/constants.dart' as Constants;
import '../../constants.dart';
import '../../size_config.dart';

class ChangeStoreID extends StatefulWidget {
  @override
  _ChangeStoreIDState createState() => _ChangeStoreIDState();
}

class _ChangeStoreIDState extends State<ChangeStoreID> {
  final _formKey = GlobalKey<FormState>();
  String storeId;
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

    _bloc = GetProfileDetailsBloc();

    _bloc.updateProfileDetailsStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            _updateProfileDetailsModel = event.data;
            Fluttertoast.showToast(msg: "Store-Id Updated, Happy Shopping");
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

    SharedPreferences.getInstance().then((value) => {
      prefs = value,
      value.setString(Constants.AUTHTOKEN, _updateProfileDetailsModel.token),
    });
    // initPref();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Store-ID"),
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
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) => storeId = newValue,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          removeError(error: kStoreIdNullError);
                          return "";
                        }
                        return null;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          addError(error: kStoreIdNullError);
                          return "";
                        }
                        return null;
                      },
                      focusNode: focus,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Store-ID",
                        hintText: "Enter New Reseller Store-ID ",
                        // If  you are using latest version of flutter then lable text and hint text shown like this
                        // if you r using flutter less then 1.20.* then maybe this is not working properly
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
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
        storeId.isNotEmpty) {
      var user = UpdateProfileRequest(
          storeId: storeId,
        firstName: "Jon",
        lastName: "Doe",
      );
      _bloc.updateProfile(user);
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    }
  }
}
