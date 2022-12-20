import 'dart:math';

import 'package:CMRS/Controller/rent.dart';
import 'package:CMRS/Controller/user.dart';
import 'package:CMRS/Models/ItemRentModel.dart';
import 'package:CMRS/Services/RentItemsServices.dart';
import 'package:CMRS/UIScreens/Items/Rent/rentAgreementScreen.dart';
import 'package:CMRS/UIScreens/User/HomeScreen.dart';
import 'package:CMRS/Widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/cart.dart';
import '../../../Controller/loading.dart';
import '../../../Services/CartServices.dart';
import '../../../Widgets/loading.dart';
import '../../../Widgets/warning.dart';
import '../Rent/RentScreen.dart';
class RentDetailsScreen extends StatelessWidget {

  RentDetailsScreen({Key? key,this.from,this.uid}) : super(key: key);

  String? from,uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Rent Items",showLogout: false),
      bottomNavigationBar: MaterialButton(
        color: Colors.black,
        child: Text('Go to Main-Menu',style: TextStyle(color: Colors.white),),
          onPressed: (){
        Get.offAll(()=>HomePage());
      }),
      body: Stack(
        children: [
          Stack(
            children: [
              Obx(() {
                return !loading()
                    ?  StreamBuilder<List<ItemRentModel>>(
                  stream: RentItemServices().streamAllOrderRentItems(from!,uid),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    try{
                      if(snapshot.hasData){
                        final items = snapshot.data;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: items.length,
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
                                                      '${items![index].profileImageUrl ?? ''}')),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "${items![index].name}",
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          Divider(),
                                          Text(
                                            'PKR ${items[index].price}',
                                            style: TextStyle(
                                                color: Colors.red, fontSize: 20.0),
                                          ),
                                          Text(
                                              items![index].quantity!=null?'${items![index].quantity} Items':'Click To Set Quantity'),
                                          Text(
                                              items![index].from!=null?'From ${items![index].from} to ${items![index].to}':''),
                                          Text(
                                              items![index].to!=null?'${DateTime.parse(items![index].to!).difference(DateTime.now()).inDays} days remaining':'Click To Set Quantity'),
                                          Divider(
                                            color: Colors.black,
                                            thickness: 1.0,
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            });
                      }else{
                        return Text('Error ${snapshot.error}');
                      }
                    }catch(e){
                      return Text('Error $e');
                    }


                  },
                )
                    : LoadingWidget();
              }),
              LoadingWidget(),
            ],
          ),
        ],
      ),
    );
  }
}