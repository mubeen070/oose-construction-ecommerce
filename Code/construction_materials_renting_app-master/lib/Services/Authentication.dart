import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../Controller/loading.dart';
import '../UIScreens/Authentication/Login.dart';
import '../Widgets/snackbar.dart';
import 'AdminServices.dart';
import 'Reception.dart';
import 'UserServices.dart';

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;
  createAccount(
      {required String name,
        required String email,
        required String pass,
        required bool isAdmin, String? adminType, String? designation, String? address,String? cnic,String? contactNo,String? gender}) async {
    loading(true);
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (user.user != null) {
        isAdmin
            ? AdminServices().registerAdmin(
            name: name,
            appliedFor: adminType,
            designation: designation,
            user: user.user!,address: address,cinc: cnic,contactNo: contactNo,gender: gender)
            : UserServices().registerUser(name: name, user: user.user!);
      } else {
        loading(false);
        alertSnackbar(
          "Unknown Error",
        );
      }
    } catch (e) {
      loading(false);
      alertSnackbar(e.toString().contains(']')
          ? e.toString().split(']').last
          : e.toString()); //TODO firebase errors list
    }
  }

  signinWithEmail(String email, String pass) async {
    try {
      loading(true);
      await auth
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((value) {
        if (value.user != null) {
          loading(false);
          Reception().userReception();
        } else {
          loading(false);
          alertSnackbar("Unknown error");
        }
      });
    } catch (e) {
      loading(false);
      alertSnackbar(e.toString().split(']').last); //TODO firebase exception
    }
  }

  forgotPassword(String email) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.sendPasswordResetEmail(email: email);
      loading(false);
      snackbar('Success', 'Password reset email sent to ${email}');
    } catch (e) {
      loading(false);
      alertSnackbar(e.toString().split(']').last); //TODO firebase exception
    }
  }

  signOut() async {
    try {
      await auth.signOut();
      Get.offAll(() => Signin());
    } catch (e) {
      snackbar("Error Signing Out", e.toString()); //TODO firebase exception
    }
  }
}
