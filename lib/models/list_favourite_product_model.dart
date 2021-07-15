// To parse this JSON data, do
//
//     final listFavoriteProducts = listFavoriteProductsFromJson(jsonString);

import 'dart:convert';

ListFavoriteProductsModel listFavoriteProductsFromJson(String str) => ListFavoriteProductsModel.fromJson(json.decode(str));

String listFavoriteProductsToJson(ListFavoriteProductsModel data) => json.encode(data.toJson());

class ListFavoriteProductsModel {
  ListFavoriteProductsModel({
    this.data,
    this.totalReseult,
  });

  List<FavDatum> data;
  int totalReseult;

  factory ListFavoriteProductsModel.fromJson(Map<String, dynamic> json) => ListFavoriteProductsModel(
    data: List<FavDatum>.from(json["data"].map((x) => FavDatum.fromJson(x))),
    totalReseult: json["TotalReseult"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "TotalReseult": totalReseult,
  };
}

class FavDatum {
  FavDatum({
    this.id,
    this.createTime,
    this.updateTime,
    this.product,
  });

  int id;
  DateTime createTime;
  DateTime updateTime;
  FavProduct product;

  factory FavDatum.fromJson(Map<String, dynamic> json) => FavDatum(
    id: json["id"],
    createTime: DateTime.parse(json["createTime"]),
    updateTime: DateTime.parse(json["updateTime"]),
    product: FavProduct.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createTime": createTime.toIso8601String(),
    "updateTime": updateTime.toIso8601String(),
    "product": product.toJson(),
  };
}

class FavProduct {
  FavProduct({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.description,
    this.keywords,
    this.isActive,
    this.isDeleted,
    this.createTime,
    this.updateTime,
    this.categoryId,
    this.productImages,
  });

  String id;
  String name;
  String price;
  int quantity;
  String description;
  String keywords;
  bool isActive;
  bool isDeleted;
  DateTime createTime;
  DateTime updateTime;
  CategoryId categoryId;
  List<dynamic> productImages;

  factory FavProduct.fromJson(Map<String, dynamic> json) => FavProduct(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    quantity: json["quantity"],
    description: json["description"],
    keywords: json["keywords"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createTime: DateTime.parse(json["createTime"]),
    updateTime: DateTime.parse(json["updateTime"]),
    categoryId: CategoryId.fromJson(json["categoryId"]),
    productImages: List<dynamic>.from(json["productImages"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "quantity": quantity,
    "description": description,
    "keywords": keywords,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createTime": createTime.toIso8601String(),
    "updateTime": updateTime.toIso8601String(),
    "categoryId": categoryId.toJson(),
    "productImages": List<dynamic>.from(productImages.map((x) => x)),
  };
}

class CategoryId {
  CategoryId({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
