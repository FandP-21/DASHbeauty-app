import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/ListProductModel.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/ProductListBloc.dart';
import 'package:shop_app/screens/favourite/component/products_header.dart';
import 'package:shop_app/constants.dart' as Constants;
import '../../../size_config.dart';

class CategoryProductScreen extends StatefulWidget {
  static String routeName = "/favourite_screen";
  Data data;

  CategoryProductScreen(this.data);

  @override
  _CategoryProductScreenState createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  ProductListBloc _bloc;
  ListProductModel _listProductModel;
  int _limit = 10, _pageNo = 1;

  @override
  void initState() {
    super.initState();
    _bloc = ProductListBloc();

    _bloc.getCategoryProduct(
        ProductRequest(limit: "$_limit", page_no: "$_pageNo", search: ""),
        widget.data.id.toString());

    _bloc.productListStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            _listProductModel = event.data;
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
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              ProductsHeader(),
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                widget.data.name,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black,
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
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
        ),
      ),
    );
  }
}
