import 'dart:async';

import 'package:CMRS/Services/OrderServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/loading.dart';
import '../../../Controller/order.dart';
import '../../../Controller/user.dart';
import '../../../Widgets/appbar.dart';
import '../../../Widgets/loading.dart';
import '../Rent/RentDetailsScreen.dart';

class OrderManagmentScreen extends StatelessWidget {
  OrderManagmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'All Orders',showLogout: false),
      bottomNavigationBar: MaterialButton(
          color: Colors.black,
          child: Text('Go to Main-Menu',style: TextStyle(color: Colors.white),),
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
                  try{
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
                          onTap: (){
                            Get.put(UserController());
                            Get.to(()=>RentDetailsScreen(from: orderCntr.allItems![index].from,uid: orderCntr.allItems![index].uid,));
                          },
                          title: Text('${orderCntr.allItems![index].totalItems} Items Rented'),
                          trailing: Text('From ${orderCntr.allItems![index].from} to ${orderCntr.allItems![index].to}'),
                        ),
                        ListTile(
                          title: Text(
                              orderCntr.allItems![index].to!=null?'${DateTime.parse(orderCntr.allItems![index].to!).difference(DateTime.now()).inDays>=0?'${DateTime.parse(orderCntr.allItems![index].to!).difference(DateTime.now()).inDays} days remaining':'Timeup ${DateTime.parse(orderCntr.allItems![index].to!).difference(DateTime.now()).inDays*-1} days ago'}':''),
                          subtitle: Text('Transaction ID ${orderCntr.allItems![index].transactionId}'),
                          trailing: Text('Status ${orderCntr.allItems![index].status=='newOrder'?'Pending':'Started'}'),
                        ),
                        ListTile(
                          onTap: (){
                            showDialog(context: context, builder: (cts){
                              return AlertDialog(
                                title: Text('CNIC Image'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: NetworkImage('${orderCntr.allItems![index].profilePic}')),
                                      ),
                                    ),
                                    MaterialButton(onPressed: (){Get.back();},child: Text('Go Back'),)
                                  ],
                                ),
                              );
                            });
                          },
                          title: Text(
                              'Cnic ${orderCntr.allItems![index].cnic}'),
                          subtitle: Text('Contact No ${orderCntr.allItems![index].contactNo}'),
                          trailing: Text('Address ${orderCntr.allItems![index].address}'),
                        ),
                        Text('Total Price: ${orderCntr.allItems![index].totalPrice}'),
                        ListTile(
                          title: Obx(() => Text('${_remainingTime}')),
                        ),
                        Visibility(
                          visible : orderCntr.allItems![index].status == 'newOrder',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MaterialButton(
                                color: Colors.black,
                                onPressed: (){
                                  OrderServices().update(orderCntr.allItems![index], 'status', 'Accepted');
                                },child: Text('Approve',style: TextStyle(color: Colors.white),),),
                              MaterialButton(
                                color: Colors.red,
                                onPressed: (){
                                  OrderServices().update(orderCntr.allItems![index], 'status', 'Rejected');
                                },child: Text('Reject',style: TextStyle(color: Colors.white),),),
                            ],
                          ),
                        ),
                        Divider(thickness: 1.0,color: Colors.black,)
                      ],
                    );
                  }catch(e){
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
