import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/products/products_screen.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class AllProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "All Products", press: () {
            Navigator.pushNamed(context, ProductsScreen.routeName);
          }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
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
    );
  }
}
