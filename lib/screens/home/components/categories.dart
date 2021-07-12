import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/HomeBloc.dart';
import 'package:shop_app/constants.dart' as Constants;

import '../../../size_config.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  HomeBloc _bloc;
  CategoryResponseModel _categoryResponseModel;
  int _limit = 10, _pageNo = 1;

  @override
  void initState() {
    super.initState();
    _bloc = HomeBloc();

    _bloc.getCategoryList(
        CategoryRequest(limit: "$_limit", page_no: "$_pageNo", search: ""));

    _bloc.categoryListStream.listen((event) {
      setState(() {
        switch (event.status) {
          case Status.LOADING:
            Constants.onLoading(context);
            break;
          case Status.COMPLETED:
            Constants.stopLoader(context);
            _categoryResponseModel = event.data;
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

    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(_categoryResponseModel!=null)
            ...List.generate(
            _categoryResponseModel.data.length,
                (index) {
              if (_categoryResponseModel.data[index].isActive)
                return CategoryCard(categoryData: _categoryResponseModel.data[index]);

              return SizedBox.shrink(); // here by default width and height is 0
            },
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.categoryData,
    @required this.press,
  }) : super(key: key);

  final Data categoryData;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(categoryData.image),
            ),
            SizedBox(height: 5),
            Text(categoryData.name, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
