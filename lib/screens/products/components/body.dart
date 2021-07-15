import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/ListProductModel.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/ProductListBloc.dart';
import 'package:shop_app/screens/products/components/products_header.dart';

import '../../../size_config.dart';
import 'package:shop_app/constants.dart' as Constants;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ProductListBloc _bloc;
  ListProductModel _listProductModel;
  int _limit = 10, _pageNo = 1;

  @override
  void initState() {
    super.initState();

    _bloc = ProductListBloc();
    _bloc.getProduct(
        ProductRequest(limit: "$_limit", page_no: "$_pageNo", search: ""));
    _bloc.productListStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            _listProductModel = event.data;
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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          ProductsHeader(),
          SizedBox(height: getProportionateScreenHeight(40)),
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: GridView.count(
              childAspectRatio: 0.82,
              shrinkWrap: true,
              crossAxisCount: 2,
              scrollDirection: Axis.vertical,
              mainAxisSpacing: 30,
              physics: ScrollPhysics(),
              children: [
                if(_listProductModel!=null && _listProductModel.data != null)
                  for (Datum data in _listProductModel.data)
                    if (data.isActive) Padding(
                      padding: EdgeInsets.only(right: 10,left: 10),
                      child: ProductCard(product: data),
                    )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToTab(BuildContext context) {

  }
}
