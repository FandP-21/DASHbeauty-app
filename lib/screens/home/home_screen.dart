import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/networking/Response.dart';
import 'package:shop_app/networking/bloc/HomeBloc.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/favourite/favouriteScreen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/constants.dart' as Constants;
import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';
import 'components/category_product_screen.dart';
import 'components/home_header.dart';
import 'components/icon_btn_with_counter.dart';
import 'components/search_field.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey expansionTileKey = GlobalKey();
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
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchField(),
                SizedBox(
                  width: 5,
                ),
                IconBtnWithCounter(
                  svgSrc: "assets/icons/Cart Icon.svg",
                  press: () => Navigator.pushNamed(context, CartScreen.routeName),
                ),
                SizedBox(
                  width: 5,
                ),
                IconBtnWithCounter(
                  svgSrc: "assets/icons/Bell.svg",
                  numOfitem: 3,
                  press: () {},
                ),
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          height: 200,
          child: Column(
            children: [
              DrawerHeader(
                  child: Center(
                child: Container(
                  height: 300,
                  child: Text(
                    "Menu",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(26),
                      color: Colors.black,
                    ),
                  ),
                ),
              )),
              ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  ListTile(
                    leading: IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/Shop Icon.svg",
                        color: kPrimaryColor,
                      ),
                    ),
                    title: Text('Home'),
                    onTap: () {
                      // Update the state of the app
                      Navigator.pushNamed(context, HomeScreen.routeName);
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/Heart Icon.svg",
                        color: kPrimaryColor,
                      ),
                    ),
                    title: Text('Favourite'),
                    onTap: () {
                      // Update the state of the app
                      Navigator.pushNamed(context, FavouriteScreen.routeName)
                          .then((value) => Navigator.pop(context));
                      // Then close the drawer
                      //Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/User Icon.svg",
                        color: kPrimaryColor,
                      ),
                    ),
                    title: Text('Profile'),
                    onTap: () {
                      // Update the state of the app
                      Navigator.pushNamed(context, ProfileScreen.routeName)
                          .then((value) => Navigator.pop(context));
                      // Then close the drawer
                      //Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/Cart Icon.svg",
                        color: kPrimaryColor,
                      ),
                      //  press: () => Navigator.pushNamed(context, CartScreen.routeName),
                    ),
                    title: Text('Your Cart'),
                    onTap: () {
                      // Update the state of the app
                      // Navigator.pushNamed(context, CartScreen.routeName).then((value) => Navigator.pop(context));
                      // Then close the drawer
                      //Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    listItem(
                        title: "Browse Categories",
                        icon: Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }

  Widget listItem({String title, IconData icon}) {
    final GlobalKey expansionTileKey = GlobalKey();
    return Material(
      child: Theme(
        data: ThemeData(accentColor: Constants.kPrimaryColor),
        child: ExpansionTile(
          key: expansionTileKey,
          onExpansionChanged: (value) {
            if (value) {
              _scrollToSelectedContent(expansionTileKey: expansionTileKey);
            }
          },
          trailing: Icon(
            icon,
            size: 40,
          ),
          title: Text(
            title,
          ),
          children: [
            if (title == "Browse Categories") cardWidget(),
          ],
        ),
      ),
    );
  }

  ///Card widget
  Widget cardWidget() {
    for (Data data in _categoryResponseModel.data)
      if (data.isActive)
        return Padding(
          padding: EdgeInsets.only(right: 10),
          child: ListTile(
            title: Text(data.name),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoryProductScreen(data)));
            },
          ),
        );
  }

  void _scrollToSelectedContent({GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: Duration(milliseconds: 200));
      });
    }
  }
}
