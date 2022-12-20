import 'package:CMRS/Models/UserModel.dart';
import 'package:CMRS/Services/UserServices.dart';
import 'package:get/get.dart';

import '../Models/AdminModel.dart';
import '../Services/AdminServices.dart';



final userCntr = Get.find<UserController>();

class UserController extends GetxController {
  Rx<UserModel>? user = UserModel().obs;
  RxList<UserModel>? allUsers = <UserModel>[].obs;
  // AdminModel get getAdmin => admin.value;
  @override
  void onReady() {
    initAdminStream();
  }

  initAdminStream() async {
    user!.bindStream(UserServices().streamUser()!);
    allUsers!.bindStream(UserServices().streamAllAdmins()!);
  }
}
