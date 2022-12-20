import 'package:CMRS/Controller/rent.dart';
import 'package:CMRS/Controller/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/cart.dart';
import '../../Controller/item.dart';
import '../../Controller/loading.dart';
import '../../Controller/order.dart';
import '../../Services/CartServices.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/roundedButton.dart';
import '../Items/Rent/RentDetailsScreen.dart';
import '../Items/cart/Cart.dart';
import '../Items/order/AllOrderDetailsScreen.dart';
import '../Items/order/Order.dart';
import 'UserProfileScreen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Wellcome ${userCntr.user?.value.name?.toUpperCase()??'Sir'}!',
            style: TextStyle(color: Colors.black),
          ),
          // leading: CircleAvatar(
          //   backgroundColor: Colors.blue,
          //   backgroundImage:
          //       NetworkImage('${userCntr.user.value.profileImageUrl ?? ''}'),
          // ),
        ),
        body: Stack(
          children: [
            Obx(() {
              return !loading()
                  ? Padding(
                padding: const EdgeInsets.only(top: 38.0),
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
                                        border: Border.all(
                                            color: Colors.black, width: 1.0),
                                        borderRadius: BorderRadius.circular(2.0),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${itemsCntr.allItems![index].profileImageUrl ?? ''}')),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "${itemsCntr.allItems![index].name}",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'PKR ${itemsCntr.allItems![index].price}',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 20.0),
                                        ),
                                        Text('-/Day'),
                                      ],
                                    ),
                                    Text(
                                        '${itemsCntr.allItems![index].quantity} remainings'),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MaterialButton(
                                          onPressed: () {
                                            var quantity = 0.obs;
                                            showDialog(context: context, builder: (ctx){
                                              return AlertDialog(
                                                content: Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
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
                                                                    '${itemsCntr.allItems![index].profileImageUrl ?? ''}')),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        Text(
                                                          "${itemsCntr.allItems![index].name}",
                                                          style: TextStyle(fontSize: 20.0),
                                                        ),
                                                        Divider(),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              'PKR ${itemsCntr.allItems![index].price}',
                                                              style: TextStyle(
                                                                  color: Colors.red, fontSize: 20.0),
                                                            ),
                                                            Text('-/Day'),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                                '${itemsCntr.allItems![index].quantity} remainings'),
                                                            Obx(() => Container(
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black,width: 2.0),
                                                                borderRadius: BorderRadius.circular(2.0),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Text(
                                                                    'Select Quantity',
                                                                  ),
                                                                  Text(
                                                                    quantity.value.toString(),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: <Widget>[
                                                                      RoundIconButton(
                                                                        onPressed: () {
                                                                          if(quantity.value>0){
                                                                            quantity.value--;
                                                                          }
                                                                        },
                                                                        icon: Icons.maximize_sharp,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 10.0,
                                                                      ),
                                                                      RoundIconButton(
                                                                        onPressed: () {
                                                                          if(quantity.value<num.parse(itemsCntr.allItems![index].quantity.toString())){
                                                                                    quantity.value++;
                                                                                  }
                                                                                },
                                                                        icon: Icons.add,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                          ],
                                                        ),

                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            MaterialButton(
                                                              onPressed: () {
                                                                CartServices().registerItem(name: itemsCntr.allItems![index].name.toString(), itemPic: itemsCntr.allItems![index].profileImageUrl,itemId: itemsCntr.allItems![index].itemId,price: itemsCntr.allItems![index].price,description: itemsCntr.allItems![index].description,quantity: quantity.value.toString());
                                                              },
                                                              color: Colors.red,
                                                              child: Text(
                                                                'Add to Cart',
                                                                style: TextStyle(color: Colors.white),
                                                              ),
                                                            ),
                                                            MaterialButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              color: Colors.black,
                                                              child: Text(
                                                                'Cancel',
                                                                style: TextStyle(color: Colors.white),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Divider(
                                                          color: Colors.black,
                                                          thickness: 1.0,
                                                        ),
                                                      ]
                                                  ),
                                                ),
                                              );
                                            });
                                          },
                                          color: Colors.red,
                                          child: Text(
                                            'Add to Cart',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () {},
                                          color: Colors.black,
                                          child: Text(
                                            'Rent Now',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      thickness: 1.0,
                                    ),
                                  ],
                                ),
                              )),
                        );
                      } catch (e) {
                        return LoadingWidget();
                      }
                    }),
              )
                  : LoadingWidget();
            }),
            LoadingWidget(),
            Container(
              width: double.infinity,
              height: 50.0,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: (){
                    Get.put(CartController());
                    Get.to(()=>Cart());

                    }, icon: Icon(Icons.shopping_cart,color: Colors.white,)),
                  IconButton(onPressed: (){
                    Get.put(OrderController());
                    Get.to(()=>OrderDetailScreen());}, icon: Icon(Icons.calendar_month,color: Colors.white,)),
                  IconButton(onPressed: (){Get.to(()=>ProfilePage());}, icon: Icon(Icons.person,color: Colors.white,)),
                ],
              ),
            )
          ],
        ),
      );

  }
}
