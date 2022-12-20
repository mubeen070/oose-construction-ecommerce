import 'package:cloud_firestore/cloud_firestore.dart';

import 'ItemsModel.dart';

class ItemRentModel {
  String? name;
  String? category;
  Timestamp? registeredOn;
  String? profileImageUrl;
  String? quantity;
  String? description;
  String? from;
  String? to;
  String? orders;
  int? price;
  String? itemId;
  String? days;
  String? status;

  ItemRentModel(
      {this.name,
        this.category,
        this.registeredOn,
        this.profileImageUrl,
        this.quantity,
        this.description,
        this.price,
        this.itemId,
        this.from,
        this.to,
        this.orders,
        this.days,
        this.status
      });

  ItemRentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    registeredOn = json['registeredOn'];
    profileImageUrl = json['profileImageUrl'];
    quantity = json['quantity'];
    description = json['description'];
    price = json['price'];
    itemId = json['itemId'];
    from = json['from'];
    to = json['to'];
    orders = json['orders'];
    days = json['days'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['category'] = this.category;
    data['registeredOn'] = this.registeredOn;
    data['profileImageUrl'] = this.profileImageUrl;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['price'] = this.price;
    data['itemId'] = this.itemId;
    data['from'] = this.from;
    data['to'] = this.to;
    data['orders'] = this.orders;
    data['days'] = this.days;
    data['status'] = this.status;
    return data;
  }
}
