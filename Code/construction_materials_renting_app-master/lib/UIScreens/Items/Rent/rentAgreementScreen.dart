import 'package:CMRS/Controller/cart.dart';
import 'package:CMRS/UIScreens/Items/order/Order.dart';
import 'package:CMRS/Widgets/appbar.dart';
import 'package:CMRS/Widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Services/RentItemsServices.dart';

class RentAgreementScreen extends StatelessWidget {
   RentAgreementScreen({Key? key,this.from,this.to,this.price,}) : super(key: key);

   DateTime? from,to;
   int? price;
   int totalPrice = 0;


  var _agreedToTerms = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: 'Terms and Conditions',showLogout: false),
    body: SingleChildScrollView(
    child: Column(
    children: [
    Text('1 :Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
    Text('2: Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisqu'),
      Text('3 :Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
      Text('4: Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisqu'),
      Text('5 :Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
      Text('6: Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisqu'),
      Text('7 :Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
      Text('8: Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisqu'),
      Row(
        children: [
          Obx(() => Checkbox(
          value: _agreedToTerms.value,
          onChanged: (value) {
            _agreedToTerms.value = value!;
          },
    ),),
    Text('I have read and agree to the terms and conditions'),
        ],
      ),
    MaterialButton(
      color: Colors.black,
    onPressed: (){
        final items = cartCntr.allItems;
        for(var item in items!){
          totalPrice += (item.price!*price!)!;
          RentItemServices().registerItem(name: item.name.toString(), itemPic: item.profileImageUrl,quantity: item.quantity,itemId: item.itemId,price: item.price!*price!,from: from.toString(),to: to.toString(),description: item.description,days: price);
        }
      _agreedToTerms.value?Get.to(Order(from: from.toString(),to: to.toString(),price: totalPrice,days: price,totalItems: cartCntr.allItems?.length,)):alertSnackbar('Please agreed to our term and services');
    },
    child: Text('Proceed',style: TextStyle(color: Colors.white),),
    ),
    ],
    ),
    ),);
    }
}
