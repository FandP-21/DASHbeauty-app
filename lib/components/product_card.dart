import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/ListProductModel.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/list_favourite_product_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/FavouriteBloc.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';
import 'package:shop_app/constants.dart' as Constants;

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.product,
    this.favProduct,
  }) : super(key: key);

  final double width, aspectRetio;
  final Datum product;
  final FavDatum favProduct;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  FavouriteBloc _favbloc;
  //FavDatum _addFavModel;
  int _limit = 10, _pageNo = 1;

  bool cardTapped = false;
  int selectedValue = 0;

  @override
  void initState() {
    super.initState();

    _favbloc = FavouriteBloc();

    /// add favourite
    _favbloc.addFavStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            widget.favProduct;
           // _addFavModel = event.data as FavDatum;
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

    /// delete favourite
    _favbloc.removeFavStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            // _addFavModel = event.data as FavDatum;
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
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DetailsScreen.routeName,
        arguments: ProductDetailsArguments(
            product:
                widget.product == null ? widget.favProduct : widget.product),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            height: 150,
            width: 200,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: widget.product == null
                ? Hero(
                    tag: widget.favProduct.id.toString(),
                    child: widget.favProduct.product.productImages.isEmpty
                        ? Icon(Icons.not_interested)
                        : Image.network(widget
                            .favProduct.product.productImages[0].image),
                  )
                : Hero(
                    tag: "Product",//widget.product.id.toString(),
                    child: widget.product.productImages.isEmpty
                        ? Icon(Icons.not_interested)
                        : Image.network(
                            widget.product.productImages[0].image),
                  ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              child: Text(
                widget.product == null
                    ? widget.favProduct.product.name
                    : widget.product.name,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
            ),
          ),
          Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${widget.product == null ? widget.favProduct.product.price : widget.product.price}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),

                //if (_addFavModel != null && _addFavModel.product != null)
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    setState(() {
                      if (cardTapped = false) {
                        cardTapped = true;
                        _favbloc.addToFavourite(widget.product == null? widget.favProduct.product.id:1);//widget.product.id);
                      } else {
                        _favbloc.removeFromFavourite(widget.favProduct.id.toString());

                        cardTapped = false;

                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                    height: getProportionateScreenWidth(28),
                    width: getProportionateScreenWidth(28),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.15),
                      /*product.isFavourite
                          ? kPrimaryColor.withOpacity(0.15)
                          : kSecondaryColor.withOpacity(0.1),*/
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      color: /*Color(
                          0xFFFF4848),*/
                          widget.product == null ? widget.favProduct.id: widget.product.id != null ?  Color(0xFFFF4848):Colors.grey ,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
