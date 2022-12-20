import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String? name;
  String? category;
  Timestamp? registeredOn;
  String? profileImageUrl;
  String? quantity;
  String? description;
  int? price;
  String? itemId;

  ItemModel(
      {this.name,
        this.category,
        this.registeredOn,
        this.profileImageUrl,
        this.quantity,
        this.description,this.price,this.itemId});

  ItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    registeredOn = json['registeredOn'];
    profileImageUrl = json['profileImageUrl'];
    quantity = json['quantity'];
    description = json['description'];
    price = json['price'];
    itemId = json['itemId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['category'] = this.category;
    data['registeredOn'] = this.registeredOn;
    data['profileImageUrl'] = this.profileImageUrl;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['price'] = price;
    data['itemId'] = itemId;
    return data;
  }
}
