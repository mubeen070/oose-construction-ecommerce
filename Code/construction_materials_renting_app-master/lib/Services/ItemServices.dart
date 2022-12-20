import 'package:CMRS/Models/ItemsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../Controller/loading.dart';
import '../Widgets/snackbar.dart';
import 'Reception.dart';

class ItemServices {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  registerItem({required String name, String? description,String? quantity, String? category,int? price,String? itemId,required String? itemPic}) async {
    var x = ItemModel(
      name: name,
      description: description,
      registeredOn: Timestamp.now(),
      category: category,
      quantity: quantity,
      price: price,
        itemId: itemId,
      profileImageUrl: itemPic
    );
    try {
      await firestore.collection("items").doc(itemId).set(x.toJson()).then((value) => snackbar('Done', 'Successfully Added Item'));
      loading(false);
    } catch (e) {
      loading(false);
      alertSnackbar("Can't add Item");
    }
  }

  // Stream<ItemModel> streamItem()  {
  //   return  firestore
  //       .collection("items")
  //       .doc(auth.currentUser!.uid)
  //       .snapshots()
  //       .map((event) => ItemModel.fromJson(event.data()!));
  // }
  Stream<List<ItemModel>>? streamAllItems() {
    try {
      return firestore.collection("items").snapshots().map((event) {
        loading(false);
        List<ItemModel> list = [];
        event.docs.forEach((element) {
          final admin = ItemModel.fromJson(element.data());
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
  update(ItemModel item,String index,String Value) async {
    try {
      loading(true);
      print(Value);
      await firestore
          .collection("items")
          .doc(item.itemId)
          .update({"$index": "$Value"}).then((value) =>alertSnackbar("Successfully Changed")).onError((error, stackTrace)=>alertSnackbar("Error this is error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
  updateInt(ItemModel item,String index,int Value) async {
    try {
      loading(true);
      print(Value);
      await firestore
          .collection("items")
          .doc(item.itemId)
          .update({"$index": Value}).then((value) => {alertSnackbar("Successfully Changed")}).onError((error, stackTrace) => alertSnackbar("Error this is error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }

  delete(ItemModel item,) async {
    try {
      loading(true);
      await firestore
          .collection("items")
          .doc(item.itemId)
          .delete().then((value) => {snackbar("Done!","Successfully Deleted,\nRefresh To see Changes")}).onError((error, stackTrace) => alertSnackbar("Error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}

