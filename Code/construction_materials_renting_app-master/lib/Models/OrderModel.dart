import 'package:cloud_firestore/cloud_firestore.dart';

import 'ItemRentModel.dart';

class OrderModel {
  String? uid;
  String? email;
  Timestamp? registeredOn;
  String? transactionId;
  String? contactNo;
  String? profilePic;
  String? address;
  String? cnic;
  int? totalItems;
  int? totalPrice;
  String? from;
  String? to;
  int? days;
  String? status;

  OrderModel(
      {this.email,
        this.uid,
        this.registeredOn,
        this.transactionId,
        this.contactNo,
        this.profilePic,
        this.address,
        this.cnic,
      this.from,
        this.to,
        this.totalPrice,
        this.totalItems,
        this.days,
        this.status,
      });

  OrderModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uid = json['uid'];
    registeredOn = json['registeredOn'];
    transactionId = json['transactionId'];
    contactNo = json['contactNo'];
    profilePic = json['profilePic'];
    address = json['address'];
    cnic = json['cnic'];
    from = json['from'];
    to = json['to'];
    totalItems = json['totalItems'];
    totalPrice = json['totalPrice'];
    days = json['days'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['registeredOn'] = this.registeredOn;
    data['transactionId'] = this.transactionId;
    data['contactNo'] = this.contactNo;
    data['profilePic'] = this.profilePic;
    data['address'] = this.address;
    data['cnic'] = this.cnic;
    data['from'] = this.from;
    data['to'] = this.to;
    data['totalPrice'] = this.totalPrice;
    data['days'] = this.days;
    data['status'] = this.status;
    data['totalItems'] = this.totalItems;
    data['uid']= this.uid;
    return data;
  }
}
