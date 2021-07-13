import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/ListProductModel.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/ProductListBloc.dart';
import 'package:shop_app/screens/products/products_screen.dart';
import 'package:shop_app/constants.dart' as Constants;
import '../../../components/product_card.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  ProductListBloc _bloc;
  ListProductModel _listProductModel;
  int _limit = 10, _pageNo = 1;

  @override
  void initState() {
    super.initState();

    _bloc = ProductListBloc();
    _bloc.getStoreProduct(
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
    SizeConfig().init(context);
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: "All Products",
              press: () {
                Navigator.pushNamed(context, ProductsScreen.routeName);
              }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            physics: ScrollPhysics(),
            children: [
              if(_listProductModel!=null && _listProductModel.data != null)
              for (Datum data in _listProductModel.data)
                if (data.isActive) ProductCard(product: data)
            ],
          ),
        ),

        // SizedBox(height: getProportionateScreenWidth(10)),
        // ...List.generate(
        //   _listProductModel.data.length,
        //   (index) {
        //     if (_listProductModel.data[index].isActive)
        //       return ProductCard(product: _listProductModel.data[index]);
        //
        //     return SizedBox
        //         .shrink(); // here by default width and height is 0
        //   },
        // ),
        SizedBox(width: getProportionateScreenWidth(20)),
      ],
    );
  }
}
