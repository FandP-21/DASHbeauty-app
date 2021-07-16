import 'package:flutter/material.dart';
import 'package:shop_app/models/CommonRequest.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/list_cart_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/CartBloc.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  CartBloc _bloc;
  ListCartItemModel _cartModel;
  int _limit = 10, _pageNo = 1;

  @override
  void initState() {
    super.initState();
    _bloc = CartBloc();

    _bloc.getCart(
        CommonRequest(limit: "$_limit", page_no: "$_pageNo", search: ""));

    _bloc.cartStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            _cartModel = event.data;
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
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(_cartModel.data),
      bottomNavigationBar: CheckoutCard(_cartModel.data),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${_cartModel.data.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
