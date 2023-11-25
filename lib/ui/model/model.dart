// To parse this JSON data, do
//
//     final modelProduct = modelProductFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelProduct modelProductFromJson(String str) => ModelProduct.fromJson(json.decode(str));

String modelProductToJson(ModelProduct data) => json.encode(data.toJson());

class ModelProduct {
    List<Product> products;
    int total;
    int skip;
    int limit;

    ModelProduct({
        required this.products,
        required this.total,
        required this.skip,
        required this.limit,
    });

    factory ModelProduct.fromJson(Map<String, dynamic> json) => ModelProduct(
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };
}

class Product {
    int id;
    String title;
    int price;
    String thumbnail;

    Product({
        required this.id,
        required this.title,
        required this.price,
        required this.thumbnail,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "thumbnail": thumbnail,
    };
}
