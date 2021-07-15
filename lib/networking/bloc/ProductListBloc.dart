import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:shop_app/models/ListProductModel.dart';
import 'package:shop_app/models/get_profile_details_model.dart';
import 'package:shop_app/models/singup_model.dart';
import 'package:shop_app/models/update_profile_model.dart';
import 'package:shop_app/networking/repository/Repository.dart';

import '../Response.dart';

class ProductListBloc {
  ProductListRepository _productListRepository;

  //get products
  StreamController _productListBlocController;
  StreamSink<Response<ListProductModel>> get productListDataSink =>
      _productListBlocController.sink;
  Stream<Response<ListProductModel>> get productListStream =>
      _productListBlocController.stream;

  ProductListBloc() {
    _productListBlocController = StreamController<Response<ListProductModel>>();
    _productListRepository = ProductListRepository();
  }

  // bool isLoggedIn = false;

  getStoreProduct(ProductRequest productRequest) async {
    productListDataSink.add(Response.loading('get profile data'));
    try {
      ListProductModel loginData = await _productListRepository.getStoreProduct(productRequest);
      print(loginData);

      // isLoggedIn = true;
      //print(prefs.getString(Constants.FIRSTNAME));

      productListDataSink.add(Response.completed(loginData));
    } catch (e) {
      productListDataSink.add(Response.error(e.toString()));
      //isLoggedIn = false;
      print(e);
    }
    return null;
  }


  getCategoryProduct(ProductRequest productRequest, String id) async {
    productListDataSink.add(Response.loading('get product category wise'));
    try {
      ListProductModel loginData = await _productListRepository.getCategoryProduct(productRequest,id);
      print(loginData);

      // isLoggedIn = true;
      //print(prefs.getString(Constants.FIRSTNAME));

      productListDataSink.add(Response.completed(loginData));
    } catch (e) {
      productListDataSink.add(Response.error(e.toString()));
      //isLoggedIn = false;
      print(e);
    }
    return null;
  }

  dispose() {
    _productListBlocController.close();
  }
}
