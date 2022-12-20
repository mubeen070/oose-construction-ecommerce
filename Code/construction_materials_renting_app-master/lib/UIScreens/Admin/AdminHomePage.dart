import 'package:CMRS/Controller/loading.dart';
import 'package:CMRS/Controller/order.dart';
import 'package:CMRS/UIScreens/Items/AddItem.dart';
import 'package:CMRS/UIScreens/Items/AllItemsScreen.dart';
import 'package:CMRS/Widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/item.dart';
import '../../Controller/user.dart';
import '../../Services/Authentication.dart';
import '../../Widgets/appbar.dart';
import '../Items/order/OrderManagmentScreen.dart';
import 'ReadUpdateDeleteItemsScreen.dart';
class SuperAdmin extends StatelessWidget {
  const SuperAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Admin", hideBackButton: true),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        color: Colors.blue,
                        child: Text('Add Item',style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          Get.to(()=>AddItemScreen());
                        }),
                    MaterialButton(
                        color: Colors.blue,
                        child: Text('Read Item',style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          Get.to(()=>RUDItemsScreen());
                        }),
                    MaterialButton(
                        color: Colors.blue,
                        child: Text('All Orders',style: TextStyle(color: Colors.white),),
                        onPressed: (){
                         final a =Get.put(OrderController());
                         a.initAdminStream();
                          Get.to(()=>OrderManagmentScreen());
                        }),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


// ListView.builder(
// itemCount: adminCntr.allAadmins!.length,
// itemBuilder: (context, index) {
// return Padding(
// padding: EdgeInsets.all(8.0),
// child: AdminCard(
// context: context,
// admin: adminCntr.allAadmins![index]),
// );
// }),