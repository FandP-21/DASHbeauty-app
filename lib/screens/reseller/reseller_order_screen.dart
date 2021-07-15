import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/home/components/home_header.dart';

import '../../size_config.dart';

class ResellerOrderScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _ResellerOrderScreenState createState() => _ResellerOrderScreenState();
}

class _ResellerOrderScreenState extends State<ResellerOrderScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              HomeHeader(),
              SizedBox(height: getProportionateScreenWidth(10)),

            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      ),
    );
  }
}
