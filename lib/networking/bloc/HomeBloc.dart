import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart' as Constants;
import 'package:shop_app/models/ListProductModel.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/get_profile_details_model.dart';
import 'package:shop_app/models/singup_model.dart';
import 'package:shop_app/models/update_profile_model.dart';
import 'package:shop_app/networking/repository/Repository.dart';

import '../Response.dart';

class HomeBloc {
  CategoryListRepository _categoryListRepository;

  //get profile
  StreamController _categoryListBlocController;
  StreamSink<Response<CategoryResponseModel>> get categoryListDataSink =>
      _categoryListBlocController.sink;
  Stream<Response<CategoryResponseModel>> get categoryListStream =>
      _categoryListBlocController.stream;

  HomeBloc() {
    _categoryListBlocController = StreamController<Response<CategoryResponseModel>>();
    _categoryListRepository = CategoryListRepository();
  }

  getCategoryList(CategoryRequest categoryRequest) async {
    categoryListDataSink.add(Response.loading('get category data'));
    try {
      CategoryResponseModel categoryResponseModel = await _categoryListRepository.getCategoryList(categoryRequest);
      print(categoryResponseModel);
      categoryListDataSink.add(Response.completed(categoryResponseModel));
    } catch (e) {
      categoryListDataSink.add(Response.error(e.toString()));
      print(e);
    }
    return null;
  }

  dispose() {
    _categoryListBlocController.close();
  }
}
