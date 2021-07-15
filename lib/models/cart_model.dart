// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.product,
    this.user,
    this.quantity,
    this.id,
  });

  Product product;
  User user;
  int quantity;
  int id;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    product: Product.fromJson(json["product"]),
    user: User.fromJson(json["user"]),
    quantity: json["quantity"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "product": product.toJson(),
    "user": user.toJson(),
    "quantity": quantity,
    "id": id,
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.description,
    this.keywords,
    this.isActive,
    this.isDeleted,
  });

  String id;
  String name;
  String price;
  int quantity;
  String description;
  String keywords;
  bool isActive;
  bool isDeleted;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    quantity: json["quantity"],
    description: json["description"],
    keywords: json["keywords"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
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
  };
}

class User {
  User({
    this.userId,
    this.roleId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.phoneNo,
    this.profilePic,
    this.storeId,
    this.timezone,
    this.status,
    this.isDeleted,
    this.isVerified,
    this.zipCode,
    this.gender,
    this.countryCode,
    this.title,
    this.preferredLanguage,
    this.preferredCurrency,
    this.registerVia,
    this.dob,
  });

  String userId;
  int roleId;
  String firstName;
  String middleName;
  String lastName;
  String email;
  String phoneNo;
  String profilePic;
  String storeId;
  String timezone;
  int status;
  bool isDeleted;
  bool isVerified;
  String zipCode;
  String gender;
  String countryCode;
  String title;
  String preferredLanguage;
  String preferredCurrency;
  String registerVia;
  String dob;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["userId"],
    roleId: json["roleId"],
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    email: json["email"],
    phoneNo: json["phoneNo"],
    profilePic: json["profilePic"],
    storeId: json["storeId"],
    timezone: json["timezone"],
    status: json["status"],
    isDeleted: json["isDeleted"],
    isVerified: json["isVerified"],
    zipCode: json["zipCode"],
    gender: json["gender"],
    countryCode: json["countryCode"],
    title: json["title"],
    preferredLanguage: json["preferredLanguage"],
    preferredCurrency: json["preferredCurrency"],
    registerVia: json["registerVia"],
    dob: json["dob"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "roleId": roleId,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "email": email,
    "phoneNo": phoneNo,
    "profilePic": profilePic,
    "storeId": storeId,
    "timezone": timezone,
    "status": status,
    "isDeleted": isDeleted,
    "isVerified": isVerified,
    "zipCode": zipCode,
    "gender": gender,
    "countryCode": countryCode,
    "title": title,
    "preferredLanguage": preferredLanguage,
    "preferredCurrency": preferredCurrency,
    "registerVia": registerVia,
    "dob": dob,
  };
}
