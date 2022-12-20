import 'package:cloud_firestore/cloud_firestore.dart';

import 'UserType.dart';

class AdminModel {
  String? uid;
  String? name;
  String? email;
  Timestamp? registeredOn;
  String? designation;
  String? appliedFor;
  String? type;
  String? gender;
  String? contactNo;
  String? profilePic;
  String? address;
  String? cnic;
  UserType? userType;

  AdminModel(
      {this.uid,this.name,
        this.email,
        this.registeredOn,
        this.designation,
        this.appliedFor,
        this.type,
        this.gender,
        this.contactNo,
        this.profilePic,
        this.address,
        this.cnic,
        this.userType});

  AdminModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    registeredOn = json['registeredOn'];
    designation = json['designation'];
    appliedFor = json['appliedFor'];
    type = json['userType'];
    gender = json['approvedBy'];
    contactNo = json['approvedOn'];
    profilePic = json['profilePic'];
    address = json['address'];
    cnic = json['cnic'];
    userType = UserType().instance(json['userType']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['registeredOn'] = this.registeredOn;
    data['designation'] = this.designation;
    data['appliedFor'] = this.appliedFor;
    data['userType'] = this.type;
    data['approvedBy'] = this.gender;
    data['approvedOn'] = this.contactNo;
    data['profilePic'] = this.profilePic;
    data['address'] = this.address;
    data['cnic'] = this.cnic;
    return data;
  }
}
