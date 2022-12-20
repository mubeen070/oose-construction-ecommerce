import 'package:get/get.dart';
import '../Models/OrderModel.dart';
import '../Services/OrderServices.dart';
import '../UIScreens/Authentication/constants.dart';

final orderCntr = Get.find<OrderController>();

class OrderController extends GetxController {
  Rx<OrderModel>? items = OrderModel().obs;
  RxList<OrderModel>? allItems = <OrderModel>[].obs;
  // AdminModel get getAdmin => admin.value;
  @override
  void onReady() {
    initAdminStream();
  }

  initAdminStream() async {
    // items!.bindStream(OrderServices().streamItem()!);
    allItems!.bindStream(OrderServices().streamAllOrders()!);
  }
}
