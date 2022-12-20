import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Controller/loading.dart';
import '../Models/AdminModel.dart';
import '../Widgets/snackbar.dart';
import 'Reception.dart';


class AdminServices {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  registerAdmin(
      {required String name,
        required String? appliedFor,
        required String? designation,
        required User user,String? address,String? cinc,String? contactNo,String? gender}) async {
    var x = AdminModel(
        uid: user.uid,
        name: name,
        email: user.email,
        registeredOn: Timestamp.now(),
        type: "pendingAdmin",
        gender: gender);
    try {
      await firestore.collection("admins").doc(user.uid).set(x.toJson()).then((value) => snackbar("Note","Sucessfully registered,Please wait for admin response")).onError((error, stackTrace) => alertSnackbar("Error[$Error]Can't Register"));
      Reception().userReception();
      loading(false);

    } catch (e) {
      loading(false);
      alertSnackbar("Can't register");
    }
  }

  // Stream<AdminModel>? streamAdmin() {
  //   try {
  //     return firestore
  //         .collection("admins")
  //         .doc(auth.currentUser!.uid)
  //         .snapshots()
  //         .map((event) {
  //       loading(false);
  //       return AdminModel.fromJson(event.data()!);
  //     });
  //   } catch (e) {
  //     loading(false);
  //     return null;
  //   }
  // }

  Stream<List<AdminModel>>? streamAllAdmins() {
    try {
      return firestore.collection("admins").snapshots().map((event) {
        loading(false);
        List<AdminModel> list = [];
        event.docs.forEach((element) {
          final admin = AdminModel.fromJson(element.data());
        });
        loading(false);
        return list;
      });
    } catch (e) {
      loading(false);
      return null;
    }
  }

  approveAdmin(AdminModel admin) async {
    try {
      loading(true);
      print("objectUID");
      print(admin.uid);
      await firestore
          .collection("admins")
          .doc(admin.uid)
          .update({"userType": "admin"});
      loading(false);
    } catch (e) {
      print(e.toString());
      loading(false);
    }
  }
  update(AdminModel admin,String index,String Value) async {
    try {
      loading(true);
      print(Value);
      await firestore
          .collection("admins")
          .doc(admin.uid)
          .update({"$index": "$Value"}).then((value) => {alertSnackbar("Successfully Changed")}).onError((error, stackTrace) => alertSnackbar("Error this is error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }

  delete(AdminModel admin,) async {
    try {
      loading(true);
      await firestore
          .collection("admins")
          .doc(admin.uid)
          .delete().then((value) => {snackbar("Done!","Successfully Deleted,\nRefresh To see Changes")}).onError((error, stackTrace) => alertSnackbar("Error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }


  blockrequest(AdminModel admin) async {
    try {
      loading(true);
      await firestore
          .collection("admins")
          .doc(admin.uid)
          .update({"userType": "blocked"});
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}
