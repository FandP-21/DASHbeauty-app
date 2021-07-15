import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/OrderBloc.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:shop_app/screens/cart/components/cart_card.dart';

import '../../size_config.dart';


class MyOrderScreen extends StatefulWidget {

  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {

    OrderBloc _bloc;


    @override
    void initState() {
      super.initState();

      _bloc = OrderBloc();
      _bloc.allOrderStream.listen((event) {
        setState(() {
          switch (event.status) {
            case Status.LOADING:
              Constants.onLoading(context);
              break;
            case Status.COMPLETED:
              Constants.stopLoader(context);
              // _logoutResponseModel = event.data;
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


    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
      ),
      body: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        /*child: ListView.builder(
          itemCount: demoCarts.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(demoCarts[index].product.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  demoCarts.removeAt(index);
                });
              },
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg"),
                  ],
                ),
              ),
              child: CartCard(cart: demoCarts[index]),
            ),
          ),
        ),*/
      )

    );
  }
}
