import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/products/products_screen.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Products", press: () {
            Navigator.pushNamed(context, ProductsScreen.routeName);
          }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,

                (index) {
                  if (demoProducts[index].isPopular)
                    return Padding(
                      padding: EdgeInsets.only(left: getProportionateScreenWidth(10), right: getProportionateScreenWidth(10)),
                      //child: ProductCard(product: demoProducts[index]),
                    );
                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              //SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
