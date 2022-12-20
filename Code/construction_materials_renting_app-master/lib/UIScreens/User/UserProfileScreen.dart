import 'package:CMRS/Controller/user.dart';
import 'package:flutter/material.dart';

import '../../Widgets/customTopContainer.dart';
import '../../Widgets/profileCustomBar.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              customTopContainer(centerTitle: "Profile Info",backButton: true,logout: true,),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 30.0),
                  color: Colors.white,
                  child: ListView(
                    children: [
                      Center(child: Text('${userCntr.user?.value.name?.toUpperCase()}',style: TextStyle(fontSize: 20.0,color: Colors.black,fontFamily: 'Brand-Bold',),)),
                      const Padding(
                        padding: EdgeInsets.only(top: 10,left:10.0,right:10.0,),
                        child: Divider(color: Colors.grey,thickness: 1.0,),
                      ),
                      profileInformation(title:'Email', text: '${userCntr.user!.value.email}', icon: Icons.person,),
                      profileInformation(title:'Registered On', text: '${userCntr.user!.value.registeredOn?.toDate()}', icon: Icons.date_range_outlined,),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 175.0, //
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white,width: 5.0),
                borderRadius: BorderRadius.circular(60.0),
              ),
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage:userCntr.user?.value.profileImageUrl!=null? NetworkImage('${userCntr.user?.value.profileImageUrl}'):null,
              ),
            ),

          ),

        ],
      ),
    );
  }
}