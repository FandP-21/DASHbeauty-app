import 'dart:async';
import 'package:shop_app/models/AllUserResponseModel.dart';
import 'package:shop_app/models/CommonRequest.dart';
import 'package:shop_app/models/UserResponseModel.dart';
import 'package:shop_app/models/list_favourite_product_model.dart';
import 'package:shop_app/networking/repository/Repository.dart';

import '../Response.dart';

class FavouriteBloc{
  FavouriteRepository _favouriteRepository;

  //get favourite by user
  StreamController _getFavBlocController;
  StreamSink<Response<ListFavoriteProductsModel>> get getFavDataSink =>
      _getFavBlocController.sink;
  Stream<Response<ListFavoriteProductsModel>> get getFavStream =>
      _getFavBlocController.stream;

  //create favourite
  StreamController _favCreateController;
  StreamSink<Response<FavProduct>> get addFavDataSink =>
      _favCreateController.sink;
  Stream<Response<FavProduct>> get addFavStream =>
      _favCreateController.stream;

  //delete user
  StreamController _removeFavController;
  StreamSink<Response<FavProduct>> get removeFavDataSink =>
      _removeFavController.sink;
  Stream<Response<FavProduct>> get removeFavStream =>
      _removeFavController.stream;

  FavouriteBloc() {
    _getFavBlocController = StreamController<Response<ListFavoriteProductsModel>>();
    _favCreateController = StreamController<Response<FavProduct>>();
    _removeFavController = StreamController<Response<FavProduct>>();

    _favouriteRepository = FavouriteRepository();
  }

  getFavourite(CommonRequest commonRequest) async {

    getFavDataSink.add(Response.loading('get users'));
    try {
      ListFavoriteProductsModel ordersResponseData =
      await _favouriteRepository.getFavouriteByUser(commonRequest);
      print(ordersResponseData);

      getFavDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      getFavDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }



  addToFavourite(String productId) async {

    addFavDataSink.add(Response.loading('add to favourite'));
    try {
      FavProduct favProductData =
      await _favouriteRepository.addToFavourite(productId);
      print(favProductData);

      addFavDataSink.add(Response.completed(favProductData));
    } catch (e) {
      addFavDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }



  removeFromFavourite(String userId) async {

    removeFavDataSink.add(Response.loading('remove from favourite'));
    try {
      FavProduct ordersResponseData =
      await _favouriteRepository.removeFromFavourite(userId);
      print(ordersResponseData);

      removeFavDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      removeFavDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }

  dispose() {
    _getFavBlocController.close();
    _favCreateController.close();
    _removeFavController.close();
  }
}