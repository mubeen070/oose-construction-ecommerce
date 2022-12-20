import 'dart:async';

import 'package:CMRS/Controller/user.dart';
import 'package:CMRS/UIScreens/Items/Rent/RentScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/loading.dart';
import '../../../Controller/order.dart';
import '../../../Controller/rent.dart';
import '../../../Models/OrderModel.dart';
import '../../../Widgets/appbar.dart';
import '../../../Widgets/loading.dart';
import '../../User/HomeScreen.dart';
import '../Rent/RentDetailsScreen.dart';

class OrderDetailScreen extends StatelessWidget {
  OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'All Orders',showLogout: false),
      bottomNavigationBar: MaterialButton(
          color: Colors.black,
          child: Text('Go back',style: TextStyle(color: Colors.white),),
          onPressed: (){
            Get.back();
          }),
      body: Stack(
        children: [
          Obx(() {
            return !loading()
                ? ListView.builder(
              itemCount: orderCntr.allItems!.length,
                itemBuilder: (ctx,index){
                if(userCntr.user?.value.email==orderCntr.allItems![index].email){
                  Rx<String> _remainingTime = ''.obs;
                  Timer.periodic(Duration(seconds: 1), (timer) {
                    var currentDate = DateTime.now();
                    var remainingTime = DateTime.parse(orderCntr.allItems![index].to!).difference(currentDate);
                    var remainingDays = remainingTime.inDays;
                    var remainingHours = remainingTime.inHours % 24;
                    var remainingMinutes = remainingTime.inMinutes % 60;
                    var remainingSeconds = remainingTime.inSeconds % 60;

                    _remainingTime.value = '$remainingDays days, $remainingHours hours, $remainingMinutes minutes, $remainingSeconds seconds';
                    if (remainingTime.isNegative) {
                      _remainingTime.value = "Times Up";
                      timer.cancel();
                    }

                  });
                  return Column(
                    children: [
                      ListTile(
                        title: Text('${orderCntr.allItems![index].totalItems} Rented'),
                        subtitle: Text('Status ${orderCntr.allItems![index].status=='newOrder'?'Pending':'Started'}'),
                        trailing: Text('From ${orderCntr.allItems![index].from} to ${orderCntr.allItems![index].to}'),
                        onTap: (){
                          Get.put(UserController());
                          Get.to(()=>RentDetailsScreen(from: orderCntr.allItems![index].from,uid: userCntr.user!.value.uid,));
                        },
                      ),
                      ListTile(
                        title: Obx(() => Text('${_remainingTime}')),
                      ),
                    ],
                  );
                }else{
                  return LoadingWidget();
                }

                })
                : LoadingWidget();
          }),
          LoadingWidget(),
        ],
      ),
    );

  }
}
