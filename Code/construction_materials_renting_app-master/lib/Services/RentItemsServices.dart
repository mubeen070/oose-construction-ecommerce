import 'package:CMRS/Models/ItemRentModel.dart';
import 'package:CMRS/Models/ItemsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../Controller/loading.dart';
import '../Controller/user.dart';
import '../Widgets/snackbar.dart';
import 'Reception.dart';

class RentItemServices {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  registerItem({required String name, String? description,String? quantity, String? category,int? price,String? itemId,required String? itemPic,String? from,String? to,String? status,int? days}) async {
    var x = ItemRentModel(
        name: name,
        description: description,
        registeredOn: Timestamp.now(),
        category: category,
        quantity: quantity,
        price: price,
        itemId: itemId,
        profileImageUrl: itemPic,
      from: from,
      to: to,
      status: status,
      days: days.toString()

    );
    var date = DateTime.now();
    var formattedDate = "${date.day}-${date.month}-${date.year}";
    try {
      await firestore.collection('users').doc(userCntr.user!.value.uid).collection("rent-Items").doc('${from}').collection('items').doc(itemId).set(x.toJson());
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
  Stream<List<ItemRentModel>>? streamAllRentItems() {
    try {
      return firestore.collection('users').doc(userCntr.user!.value.uid).collection("rent-Items").doc('${DateTime.now().toString()}').collection('items').snapshots().map((event) {
        loading(false);
        List<ItemRentModel> list = [];
        event.docs.forEach((element) {
          final admin = ItemRentModel.fromJson(element.data());
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
  Stream<List<ItemRentModel>>? streamAllOrderRentItems(String from,String? uid) {
    try {
      return firestore.collection('users').doc(uid).collection("rent-Items").doc('${from}').collection('items').snapshots().map((event) {
        loading(false);
        List<ItemRentModel> list = [];
        event.docs.forEach((element) {
          final admin = ItemRentModel.fromJson(element.data());
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
  update(ItemRentModel item,String index,String Value) async {
    try {
      loading(true);
      print(Value);
      await firestore.collection('users').doc(userCntr.user!.value.uid).collection("rent-Items").doc('${DateTime.now().toString()}').collection('items')
          .doc(item.itemId)
          .update({"$index": "$Value"}).then((value) =>alertSnackbar("Successfully Changed")).onError((error, stackTrace)=>alertSnackbar("Error this is error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
  updateInt(ItemRentModel item,String index,int Value) async {
    try {
      loading(true);
      print(Value);
      await firestore.collection('users').doc(userCntr.user!.value.uid).collection("rent-Items").doc('${DateTime.now().toString()}').collection('items')
          .doc(item.itemId)
          .update({"$index": Value}).then((value) => {alertSnackbar("Successfully Changed")}).onError((error, stackTrace) => alertSnackbar("Error this is error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }

  delete(ItemRentModel item,) async {
    try {
      loading(true);
      await firestore.collection('users').doc(userCntr.user!.value.uid).collection("rent-Items").doc('${DateTime.now().toString()}').collection('items')
          .doc(item.itemId)
          .delete().then((value) => {snackbar("Done!","Successfully Deleted,\nRefresh To see Changes")}).onError((error, stackTrace) => alertSnackbar("Error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}

