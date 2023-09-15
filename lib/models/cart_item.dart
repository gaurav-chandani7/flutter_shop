import 'package:flutter_shop/models/product.dart';

class CartItem extends Product {
  num? quantity;
  CartItem(
      {int? id,
      String? title,
      num? price,
      String? description,
      String? category,
      String? image,
      Rating? rating,
      this.quantity})
      : super(
            id: id,
            title: title,
            price: price,
            description: description,
            category: category,
            image: image,
            rating: rating);

  CartItem.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null ? Rating?.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['image'] = image;
    data['rating'] = rating!.toJson();
    return data;
  }
}
