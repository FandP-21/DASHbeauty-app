import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Row(
          children: [
            Image.asset(
              "assets/logo/logo_design_transparent.png",
              width: getProportionateScreenWidth(250),
            ),
            Image.asset(
              "assets/logo/logo_beauty_transparent.png",
              color: kPrimaryColor,
              width: getProportionateScreenWidth(250),
            ),
          ],
        ),
        //fontSize: getProportionateScreenWidth(36),
        SizedBox(height: 10,),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
