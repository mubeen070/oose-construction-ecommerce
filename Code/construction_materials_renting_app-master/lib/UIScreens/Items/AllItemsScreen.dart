import 'package:CMRS/Controller/user.dart';
import 'package:CMRS/Models/AdminModel.dart';
import 'package:CMRS/Widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/admin.dart';
import '../../Controller/item.dart';
import '../../Controller/loading.dart';
import '../../Widgets/loading.dart';
import 'UpdateItemsScreen.dart';

class AllItemsScreen extends StatelessWidget {
  const AllItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'All Items',showLogout: false),
      body: Stack(
        children: [
          Obx(() {
            return !loading()
                ?  SafeArea(
                child: Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: itemsCntr.allItems!.length,
                      itemBuilder: (ctx, index) {
                        try {
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              // decoration: BoxDecoration(
                              //   border: Border.all(color: Colors.black,width: 2.0),
                              //   borderRadius: BorderRadius.circular(2.0),
                              // ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black, width: 1.0),
                                          borderRadius: BorderRadius.circular(2.0),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${itemsCntr.allItems![index].profileImageUrl ?? ''}')),
                                        ),
                                      ),
                                      SizedBox(height: 5.0,),
                                      Text(
                                        "${itemsCntr.allItems![index].name}",
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('PKR ${itemsCntr.allItems![index].price}',style: TextStyle(color: Colors.red,fontSize: 20.0),),
                                          Text('-/Day'),
                                        ],
                                      ),
                                      Text(
                                          '${itemsCntr.allItems![index].quantity} remainings'),
                                      Visibility(
                                        visible: !adminCntr.admin!.value!.userType!.superAdmin,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            MaterialButton(onPressed: (){},color: Colors.red,child: Text('Add to Cart',style: TextStyle(color: Colors.white),),),
                                            MaterialButton(onPressed: (){},color: Colors.black,child: Text('Rent Now',style: TextStyle(color: Colors.white),),)

                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: adminCntr.admin!.value!.userType!.superAdmin,
                                        child: MaterialButton(
                                          color: Colors.black,
                                          onPressed: (){
                                            Get.to(()=>ItemUpdateScreen(index: index,));
                                          },
                                          child: Text('Update',style: TextStyle(color: Colors.white),),

                                        ),
                                      ),
                                      Divider(color: Colors.black,thickness: 1.0,),
                                    ],
                                  ),
                                )),
                          );
                        } catch (e) {
                          return LoadingWidget();
                        }
                      }),
                ))
                : LoadingWidget();
          }),
          LoadingWidget(),
        ],
      ),
    );
  }
}
