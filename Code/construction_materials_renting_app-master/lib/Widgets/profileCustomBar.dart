import 'package:flutter/material.dart';


class profileInformation extends StatelessWidget {
  profileInformation({
    Key? key,
    required this.title,
    required this.text,
    required this.icon,
  }) : super(key: key);

  String title,text;
  IconData icon;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: [
          Container(
              width:70.0,
              height:70.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child:  Center(child: Icon(icon,color: Colors.white,size: 20.0,))),
          SizedBox(width: 20.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$title',style: TextStyle(fontFamily: 'Brand-Regular',fontSize: 15),),
              Text('$text',style: TextStyle(fontFamily: "Brand-Bold",fontSize: 20.0),)
            ],
          )
        ],
      ),
    );
  }
}