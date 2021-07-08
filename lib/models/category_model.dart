// To parse this JSON data, do
//
//     final signUpResponseModel = signUpResponseModelFromJson(jsonString);

import 'dart:convert';

CategoryResponseModel categoryResponseModelFromJson(String str) => CategoryResponseModel.fromJson(json.decode(str));

String categoryResponseModelToJson(CategoryResponseModel data) => json.encode(data.toJson());

class CategoryResponseModel {
  CategoryResponseModel({
    this.data,
    this.totalReseult,
  });

  List<Data> data;
  int totalReseult;

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) => CategoryResponseModel(
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    totalReseult: json["TotalReseult"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "TotalReseult": totalReseult,
  };

}

class Data {
  int id;
  String name;
  String image;
  bool isActive;
  bool isDeleted;
  DateTime createTime;
  DateTime updateTime;

  Data({
    this.id,
    this.name,
    this.image,
    this.isActive,
    this.isDeleted,
    this.createTime,
    this.updateTime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null :json["id"],
    name: json["name"] == null ? null :json["name"],
    image: json["image"] == null ? null :json["image"],
    isActive: json["isActive"] == null ? null :json["isActive"],
    isDeleted: json["isDeleted"] == null ? null :json["isDeleted"],
    createTime: json["createTime"] == null ? null :DateTime.parse(json["createTime"]),
    updateTime: json["updateTime"] == null ? null :DateTime.parse(json["updateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createTime": createTime.toIso8601String(),
    "updateTime": updateTime.toIso8601String(),
  };
}

class CategoryRequest {
  String limit = "10";
  String page_no = "1";
  String search = "";

  CategoryRequest({this.limit, this.page_no, this.search});

  CategoryRequest.fromJson(Map<String, dynamic> json) {
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