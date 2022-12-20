import 'package:CMRS/Models/ItemsModel.dart';
import 'package:CMRS/Services/ItemServices.dart';
import 'package:get/get.dart';

import '../Models/AdminModel.dart';
import '../Services/AdminServices.dart';



final itemsCntr = Get.find<ItemController>();

class ItemController extends GetxController {
  Rx<ItemModel>? items = ItemModel().obs;
  RxList<ItemModel>? allItems = <ItemModel>[].obs;
  // AdminModel get getAdmin => admin.value;
  @override
  void onReady() {
    initAdminStream();
  }

  initAdminStream() async {
    // items!.bindStream(ItemServices().streamItem()!);
    allItems!.bindStream(ItemServices().streamAllItems()!);
  }
}
