import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../Controller/admin.dart';
import '../Controller/cart.dart';
import '../Controller/item.dart';
import '../Controller/loading.dart';
import '../Controller/user.dart';
import '../Models/UserType.dart';
import '../UIScreens/Admin/AdminHomePage.dart';
import '../UIScreens/User/HomeScreen.dart';
import '../UIScreens/WaitingRoom/waitingRoom.dart';
import 'Authentication.dart';

class Reception {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  Future<UserType> fetchUserType() async {
    String type = "none";
    try {
      type = await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) => value['userType'].toString());
    } catch (e) {
      try {
        type = await firestore
            .collection("admins")
            .doc(auth.currentUser!.uid)
            .get()
            .then((value) => value['userType'].toString());
      } catch (e) {
        return UserType().instance(type);
      }
      return UserType().instance(type);
    }
    return UserType().instance(type);
  }

  userReception() async {
    final type = await fetchUserType();
    if (type.user) {
      final a = Get.put(UserController());
      a.initAdminStream();
      Get.put(ItemController());
      Get.offAll(() => HomePage());
    } else if (type.pendingAdmin) {
      loading(true);
      Get.put(AdminController());
      Get.put(ItemController());
      Get.offAll(() => WaitingRoom());
    } else if (type.superAdmin) {
      loading(true);
      Get.put(AdminController());
      Get.put(ItemController());
      Get.offAll(() => SuperAdmin());
    }  else  {
      Authentication().signOut();
    }
  }
}
