// To parse this JSON data, do
//
//     final listProductModel = listProductModelFromJson(jsonString);

import 'dart:convert';

ListProductModel listProductModelFromJson(String str) => ListProductModel.fromJson(json.decode(str));

String listProductModelToJson(ListProductModel data) => json.encode(data.toJson());

class ListProductModel {
  ListProductModel({
    this.data,
    this.totalReseult,
  });

  List<Datum> data;
  int totalReseult;

  factory ListProductModel.fromJson(Map<String, dynamic> json) => ListProductModel(
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
  List<ProductImage> productImages;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null :json["id"],
    name: json["name"] == null ? null :json["name"],
    price: json["price"] == null ? null :json["price"],
    quantity: json["quantity"] == null ? null :json["quantity"],
    description: json["description"] == null ? null :json["description"],
    keywords: json["keywords"] == null ? null :json["keywords"],
    isActive: json["isActive"] == null ? null :json["isActive"],
    isDeleted: json["isDeleted"] == null ? null :json["isDeleted"],
    createTime: json["createTime"] == null ? null :DateTime.parse(json["createTime"]),
    updateTime: json["updateTime"] == null ? null :DateTime.parse(json["updateTime"]),
    categoryId: json["categoryId"] == null ? null :CategoryId.fromJson(json["categoryId"]),
    productImages: json["productImages"] == null ? null :List<ProductImage>.from(json["productImages"].map((x) => ProductImage.fromJson(x))),
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
    "productImages": List<ProductImage>.from(productImages.map((x) => x)),
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

class ProductImage {
  ProductImage({
    this.id,
    this.image,
  });

  int id;
  String image;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}


class ProductRequest {
  String limit = "10";
  String page_no = "1";
  String search = "";

  ProductRequest({this.limit, this.page_no, this.search});

  ProductRequest.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    page_no = json['page_no'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['page_no'] = this.page_no;
    data['search'] = this.search;
    return data;
  }
}
