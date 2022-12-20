import 'package:CMRS/Widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/cart.dart';
import '../../../Controller/loading.dart';
import '../../../Services/CartServices.dart';
import '../../../Widgets/loading.dart';
import '../../../Widgets/warning.dart';
import '../Rent/RentScreen.dart';
class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Cart",showLogout: false),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 50.0,
        color: Colors.blue,
        child: MaterialButton(
          onPressed: () {
            Get.to(()=>RentScreen());
          },
          color: Colors.black,
          child: Text(
            'Rent Now',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Stack(
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
                                    MaterialButton(
                                      color: Colors.red,
                                      onPressed: (){
                                      WarningDialog(
                                        title: "Do want to remove from cart",
                                        onYes: (){
                                          CartServices().delete(cartCntr.allItems![index]);
                                        },
                                        context: context,
                                      );
                                    },child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.delete_forever,color: Colors.white,),
                                        Text('Remove From Cart',style: TextStyle(color: Colors.white),),
                                      ],
                                    ),),
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
    );
  }
}