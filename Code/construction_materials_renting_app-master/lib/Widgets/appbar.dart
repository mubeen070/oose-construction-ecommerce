import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../services/authentication.dart';

AppBar appBar(
    {required String title,
      bool hideBackButton = false,
      bool showLogout = true}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: Visibility(
      visible: !hideBackButton,
      child: Container(
        width: double.infinity,
        height: 5.h,
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            children: [
              SizedBox(
                width: 5.w,
              ),
              Icon(
                CupertinoIcons.chevron_back,
                size: 22.sp,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(color: Colors.black),
    ),
    actions: [
      Visibility(
        visible: showLogout,
        child: Padding(
          padding: EdgeInsets.all(10.0.sp),
          child: InkWell(
            onTap: () => Authentication().signOut(),
            child: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ),
      )
    ],
  );
}
