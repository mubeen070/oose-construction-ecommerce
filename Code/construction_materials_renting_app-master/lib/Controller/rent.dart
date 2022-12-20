import 'package:CMRS/Models/ItemsModel.dart';
import 'package:CMRS/Services/ItemServices.dart';
import 'package:get/get.dart';

import '../Models/AdminModel.dart';
import '../Models/ItemRentModel.dart';
import '../Services/AdminServices.dart';
import '../Services/RentItemsServices.dart';



final rentItemsCntr = Get.find<RentItemController>();

class RentItemController extends GetxController {
  Rx<ItemRentModel>? items = ItemRentModel().obs;
  RxList<ItemRentModel>? allItems = <ItemRentModel>[].obs;
  // AdminModel get getAdmin => admin.value;
  @override
  void onReady() {
    initAdminStream();
  }

  initAdminStream() async {
    // items!.bindStream(ItemServices().streamItem()!);
    allItems!.bindStream(RentItemServices().streamAllRentItems()!);
  }
}
