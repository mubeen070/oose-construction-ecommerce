import 'package:CMRS/Models/UserModel.dart';
import 'package:CMRS/UIScreens/User/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../Controller/loading.dart';
import '../Controller/user.dart';
import '../Models/OrderModel.dart';
import '../Widgets/snackbar.dart';

class OrderServices {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  registerItem({String? transactionId,int? totalItems, String? contactno,int? price,String? itemPic,String? from,String? to,int? days,String? address,String? cnic}) async {
    var x = OrderModel(
      uid: userCntr.user?.value.uid,
        email: userCntr.user?.value.email,
        transactionId: transactionId,
      totalItems: totalItems,
      contactNo: contactno,
      totalPrice: price,
      profilePic: itemPic,
      from: from,
      to: to,
      status: 'newOrder',
      registeredOn: Timestamp.now(),
      days: days,
      address: address,
      cnic: cnic,
    );
    try {
      await firestore.collection("orders").doc(transactionId).set(x.toJson()).then((value) {
        snackbar('Information', 'After reviewing your details by admin your order will process');
        Get.offAll(HomePage());
      });
      loading(false);
    } catch (e) {
      loading(false);
      print('Cannot add Item');
    }
  }

  // Stream<ItemModel> streamItem()  {
  //   return  firestore
  //       .collection("items")
  //       .doc(auth.currentUser!.uid)
  //       .snapshots()
  //       .map((event) => ItemModel.fromJson(event.data()!));
  // }
  Stream<List<OrderModel>>? streamAllOrders() {
    try {
      return firestore.collection("orders").snapshots().map((event) {
        loading(false);
        List<OrderModel> list = [];
        event.docs.forEach((element) {
          final admin = OrderModel.fromJson(element.data());
          list.add(admin);
        });
        loading(false);
        return list;
      });
    } catch (e) {
      loading(false);
      return null;
    }
  }

  Stream<List<OrderModel>>? streamSpecificUserOrders(UserModel user) {
    try {
      return firestore.collection("orders").snapshots().map((event) {
        loading(false);
        List<OrderModel> list = [];
        event.docs.forEach((element) {
          final admin = OrderModel.fromJson(element.data());
          list.add(admin);
        });
        loading(false);
        return list;
      });
    } catch (e) {
      loading(false);
      return null;
    }
  }
  update(OrderModel item,String index,String Value) async {
    try {
      loading(true);
      print(Value);
      await firestore.collection("orders").doc(item.uid)
          .update({"$index": "$Value"}).then((value) =>alertSnackbar("Successfully Changed")).onError((error, stackTrace)=>alertSnackbar("Error this is error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
  updateInt(OrderModel item,String index,int Value) async {
    try {
      loading(true);
      print(Value);
      await firestore.collection("orders").doc(item.uid)
          .update({"$index": Value}).then((value) => {alertSnackbar("Successfully Changed")}).onError((error, stackTrace) => alertSnackbar("Error this is error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }

  delete(OrderModel item,) async {
    try {
      loading(true);
      await firestore.collection("orders").doc(item.uid)
          .delete().then((value) => {print("Successfully Deleted,\nRefresh To see Changes")});
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}

