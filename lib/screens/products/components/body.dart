import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/products/components/products_header.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
     // padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(

        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          ProductsHeader(),
          SizedBox(height: getProportionateScreenHeight(40)),
          Wrap(
            //spacing: 40,
            spacing: 30,
            runSpacing: 40,
            alignment: WrapAlignment.spaceBetween,
            children: [

             // SizedBox(height: getProportionateScreenWidth(10)),
              ...List.generate(
                demoProducts.length,
                    (index) {
                  if (demoProducts[index].isPopular)
                    return ProductCard(product: demoProducts[index]);

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ],
      ),
    );
  }
}
