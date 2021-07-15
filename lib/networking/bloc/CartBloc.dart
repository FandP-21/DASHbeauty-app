import 'dart:async';

import 'package:shop_app/models/AllUserResponseModel.dart';
import 'package:shop_app/models/CommonRequest.dart';
import 'package:shop_app/models/UserResponseModel.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/list_cart_model.dart';
import 'package:shop_app/networking/repository/Repository.dart';

import '../Response.dart';


class CartBloc{
  CartRepository _cartRepository;

  //get cart data
  StreamController _cartBlocController;
  StreamSink<Response<ListCartItemModel>> get cartDataSink =>
      _cartBlocController.sink;
  Stream<Response<ListCartItemModel>> get cartStream =>
      _cartBlocController.stream;


  //add to cart
  StreamController _cartCreateController;
  StreamSink<Response<CartModel>> get addCartDataSink =>
      _cartCreateController.sink;
  Stream<Response<CartModel>> get addCartStream =>
      _cartCreateController.stream;


  //delete cart
  StreamController _deleteCartController;
  StreamSink<Response<CartModel>> get deleteCartSink =>
      _deleteCartController.sink;
  Stream<Response<CartModel>> get deleteCartStream =>
      _deleteCartController.stream;

  //update user
  StreamController _updateCartController;
  StreamSink<Response<CartModel>> get updateCartDataSink =>
      _updateCartController.sink;
  Stream<Response<CartModel>> get updateCartStream =>
      _updateCartController.stream;

  CartBloc() {
    _cartBlocController = StreamController<Response<ListCartItemModel>>();
    _cartCreateController = StreamController<Response<CartModel>>();
    _deleteCartController = StreamController<Response<CartModel>>();
    _updateCartController = StreamController<Response<CartModel>>();

    _cartRepository = CartRepository();
  }

  getCart(CommonRequest commonRequest) async {
    cartDataSink.add(Response.loading('get cart'));
    try {
      ListCartItemModel ordersResponseData =
      await _cartRepository.getCart(commonRequest);
      print(ordersResponseData);

      cartDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      cartDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }

  addToCart(CartRequest request) async {

    addCartDataSink.add(Response.loading('add to cart'));
    try {
      CartModel ordersResponseData =
      await _cartRepository.addToCart(request);
      print(ordersResponseData);

      addCartDataSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      addCartDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }



  deleteCart(String userId) async {

    deleteCartSink.add(Response.loading('delete cart'));
    try {
      CartModel ordersResponseData =
      await _cartRepository.deleteCart(userId);
      print(ordersResponseData);

      deleteCartSink.add(Response.completed(ordersResponseData));
    } catch (e) {
      deleteCartSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }

  //to update cart
  updateUser(String id, CartRequest request) async {

    updateCartDataSink.add(Response.loading('Update Product'));
    try {
      CartModel userResponseData =
      await _cartRepository.updateCart(id, request);
      print(userResponseData);

      updateCartDataSink.add(Response.completed(userResponseData));
    } catch (e) {
      updateCartDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }

  dispose() {
    _cartBlocController.close();
    _cartCreateController.close();
    _deleteCartController.close();
    _updateCartController.close();
  }
}