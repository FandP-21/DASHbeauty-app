import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/CommonRequest.dart';
import 'package:shop_app/models/ListProductModel.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/CartBloc.dart';
import 'package:shop_app/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:shop_app/constants.dart' as Constants;

class Body extends StatefulWidget {
  final Datum product;

  const Body({Key key, @required this.product}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  TextEditingController _quantityController = TextEditingController();

  CartBloc _bloc;
  CartModel _addCartModel;
  int _limit = 10, _pageNo = 1;
  String _quantity;

  @override
  void initState() {
    super.initState();

    _bloc = CartBloc();

    _bloc.addCartStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            _addCartModel = event.data;
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
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    //ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width:100,
                              child: TextField(
                                controller: _quantityController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  hintText: "1",
                                ),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black),
                                keyboardType: TextInputType.number,
                                onSubmitted: (String val) {
                                  _quantity = val;
                                },

                              ),
                            ),
                            Container(
                              width: 200,
                              child: DefaultButton(
                                text: "Add To Cart",
                                press: () {
                                  validateInputs();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void validateInputs(){
    if (_quantity == null) {

      var user = CartRequest(productId: widget.product.id, quantity: "1");
      _bloc.addToCart(user);
    }
    else {
      var user = CartRequest(productId: widget.product.id, quantity: _quantity);
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxx"+_quantity);
      _bloc.addToCart(user);
    }
  }
}
