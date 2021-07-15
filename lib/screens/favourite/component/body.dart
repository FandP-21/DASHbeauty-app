import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/CommonRequest.dart';
import 'package:shop_app/models/ListProductModel.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/list_favourite_product_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/FavouriteBloc.dart';
import 'package:shop_app/networking/bloc/ProductListBloc.dart';
import 'package:shop_app/screens/products/components/products_header.dart';
import 'package:shop_app/constants.dart' as Constants;
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FavouriteBloc _bloc;
  ListFavoriteProductsModel _listFavModel;
  int _limit = 10, _pageNo = 1;

  @override
  void initState() {
    super.initState();

    _bloc = FavouriteBloc();
    _bloc.getFavourite(
        CommonRequest(limit: "$_limit", page_no: "$_pageNo", search: ""));

    _bloc.getFavStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            _listFavModel = event.data;
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
          _listFavModel != null?GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            physics: ScrollPhysics(),
            children: [
              if (_listFavModel != null && _listFavModel.data != null)
                for (FavDatum data in _listFavModel.data)
                  if (data.product.isActive)
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: ProductCard(
                        product: null,
                        favProduct: data,
                      ),
                    )
            ],
          ): Center(
            child: Text("No Saved Product"),
          ),
          /* Wrap(
            //spacing: 40,
            spacing: 30,
            runSpacing: 40,
            alignment: WrapAlignment.spaceBetween,
            children: [

              ...List.generate(
                _listFavModel.data.length,
                    (index) {
                  if (_listFavModel.data[index] != null)
                    return ProductCard(product: _listFavModel.data[index]);

                  return SizedBox.shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),*/
        ],
      ),
    );
  }
}
