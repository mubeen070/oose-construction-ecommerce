import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Controller/loading.dart';
import '../Models/UserModel.dart';
import '../Widgets/snackbar.dart';
import 'Reception.dart';

class UserServices {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  registerUser({required String name, required User user}) async {
    var x = UserModel(
      name: name,
      email: user.email,
      registeredOn: Timestamp.now(),
      status: "",
      type: "user",
      uid: user.uid,
    );
    try {
      await firestore.collection("users").doc(user.uid).set(x.toJson());
      loading(false);
      Reception().userReception();
    } catch (e) {
      loading(false);
      alertSnackbar("Can't register user");
    }
  }

  Stream<UserModel> streamUser()  {
    return  firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .snapshots()
        .map((event) => UserModel.fromJson(event.data()!));
  }
  Stream<List<UserModel>>? streamAllAdmins() {
    try {
      return firestore.collection("users").snapshots().map((event) {
        loading(false);
        List<UserModel> list = [];
        event.docs.forEach((element) {
          final admin = UserModel.fromJson(element.data());
        });
        loading(false);
        return list;
      });
    } catch (e) {
      loading(false);
      return null;
    }
  }
}
