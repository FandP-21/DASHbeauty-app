import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';
import 'components/home_header.dart';
import 'components/icon_btn_with_counter.dart';
import 'components/search_field.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchField(),
                IconBtnWithCounter(
                  svgSrc: "assets/icons/Cart Icon.svg",
                  //  press: () => Navigator.pushNamed(context, CartScreen.routeName),
                ),
                IconBtnWithCounter(
                  svgSrc: "assets/icons/Bell.svg",
                  numOfitem: 3,
                  press: () {},
                ),
              ],
            ),
          )
        ],
      ),
     drawer: Drawer(

        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Image.asset('assets/logo/logo_design_transparent.png'),
            ),
            ListTile(
              leading: IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home != null
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
              ),
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                Navigator.pushNamed(context, HomeScreen.routeName);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
