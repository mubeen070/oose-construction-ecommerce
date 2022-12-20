import 'package:CMRS/Services/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class customTopContainer extends StatelessWidget {
  customTopContainer({
    Key? key,
    this.backButton,
    this.centerTitle,
    this.logout,
  }) : super(key: key);

  bool? backButton;
  String? centerTitle;
  bool? logout;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 230.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
          // image: DecorationImage(
          //   image: AssetImage("images/backfround.jpg"),
          //   fit: BoxFit.cover,
          // ),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(50.0),),
        ),
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: 30.0,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                        visible:backButton??false,
                        child: IconButton(onPressed: (){
                          Get.back();
                        }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,))),
                    Text("${centerTitle??''}",style: TextStyle(color: Colors.white,fontFamily: 'Brand-Bold',fontSize: 20.0),),
                    Visibility(
                        visible:logout??false,
                        child: IconButton(onPressed: (){
                          Authentication().signOut();
                        }, icon: Icon(Icons.logout,color: Colors.white,))),

                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}