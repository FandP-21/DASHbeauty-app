// To parse this JSON data, do
//
//     final listCartItemModel = listCartItemModelFromJson(jsonString);

import 'dart:convert';

ListCartItemModel listCartItemModelFromJson(String str) => ListCartItemModel.fromJson(json.decode(str));

String listCartItemModelToJson(ListCartItemModel data) => json.encode(data.toJson());

class ListCartItemModel {
  ListCartItemModel({
    this.data,
    this.totalReseult,
  });

  List<Datum> data;
  int totalReseult;

  factory ListCartItemModel.fromJson(Map<String, dynamic> json) => ListCartItemModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalReseult: json["TotalReseult"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "TotalReseult": totalReseult,
  };
}

class Datum {
  Datum({
    this.id,
    this.createTime,
    this.product,
  });

  int id;
  DateTime createTime;
  Product product;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    createTime: DateTime.parse(json["createTime"]),
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createTime": createTime.toIso8601String(),
    "product": product.toJson(),
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.productImages,
  });

  String id;
  String name;
  List<dynamic> productImages;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    productImages: List<dynamic>.from(json["productImages"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "productImages": List<dynamic>.from(productImages.map((x) => x)),
  };
}
