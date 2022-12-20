import 'dart:math';

import 'package:CMRS/UIScreens/Items/Rent/rentAgreementScreen.dart';
import 'package:CMRS/Widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/cart.dart';
import '../../../Controller/loading.dart';
import '../../../Services/CartServices.dart';
import '../../../Widgets/loading.dart';
import '../../../Widgets/warning.dart';
import '../Rent/RentScreen.dart';
class RentScreen extends StatelessWidget {

  var from = DateTime.now().obs;
  var to = DateTime.now().obs;
  var totalprice = 0.obs;

  RentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Rent Items",showLogout: false),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 50.0,
        color: Colors.blue,
        child: MaterialButton(
          onPressed: () {
            showDialog(context: context, builder: (ctx){
              return AlertDialog(
                title: Text('Check out'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: List.generate(cartCntr.allItems!.length, (index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage('${cartCntr.allItems![index].profileImageUrl}'),
                          ),
                          title: Text('${cartCntr.allItems![index].name}'),
                          subtitle: Text('From ${from.value} to ${to.value}, Total ${totalprice.value} days'),
                          trailing: Text('Price ${cartCntr.allItems![index].price!*totalprice.value}'),
                        );

                      }),
                    ),
                    MaterialButton(
                      color: Colors.black,
                      onPressed: (){
                      Get.to(()=>RentAgreementScreen(from: from.value,to: to.value,price: totalprice.value,));
                    },
                    child: Text('Procced To Payments',style: TextStyle(color: Colors.white),),)
                  ],
                ),
              );

            });
          },
          color: Colors.black,
          child: Text(
            'Check out',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              Obx(() {
                return !loading()
                    ?  ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartCntr.allItems!.length,
                    itemBuilder: (ctx, index) {
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
                                      border: Border.all(
                                          color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.circular(2.0),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${cartCntr.allItems![index].profileImageUrl ?? ''}')),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "${cartCntr.allItems![index].name}",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'PKR ${cartCntr.allItems![index].price}',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 20.0),
                                      ),
                                      Text('-/Day'),
                                    ],
                                  ),
                                  Text(
                                      cartCntr.allItems![index].quantity!=null?'${cartCntr.allItems![index].quantity} Items':'Click To Set Quantity'),
                                  Divider(
                                    color: Colors.black,
                                    thickness: 1.0,
                                  ),
                                ],
                              ),
                            )),
                      );
                    })
                    : LoadingWidget();
              }),
              LoadingWidget(),
            ],
          ),
          MaterialButton(
              color: Colors.red,
              onPressed: (){
                showDialog(context: context, builder: (ctx){
                  return AlertDialog(
                    content: Obx(() => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            Text('${from?.value??'From'}'),
                            MaterialButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015, 8),
                                    lastDate: DateTime(2101));
                                if(picked!=null){
                                  from!.value=picked;
                                }
                              },child: Text('Select From'),),

                          ],
                        ),
                        Column(
                          children: [
                            Text('${to!.value??'To'}'),
                            MaterialButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015, 8),
                                    lastDate: DateTime(2101));
                                if(picked!=null){
                                  to.value = picked;
                                }
                              },child: Text('Select To'),),
                            MaterialButton(
                              color: Colors.blue,
                              onPressed: (){
                                final difference = to!.value.difference(from!.value).inDays;
                                totalprice.value = difference.toInt();
                                print(difference);
                                Get.back();
                              },child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Done',style: TextStyle(fontSize: 20.0,color: Colors.white,),),
                            ),)
                          ],
                        ),
                      ],
                    )),
                  );
                });

              },child: Text('Select date')),
        ],
      ),
    );
  }
}