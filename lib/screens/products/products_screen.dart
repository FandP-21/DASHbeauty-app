import 'package:flutter/material.dart';

import 'components/body.dart';
class ProductsScreen extends StatefulWidget {
  static String routeName = "/products_screen";

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(),
        //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
      ),
    );
  }
}
