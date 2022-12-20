import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';

WarningDialog(
    {required BuildContext context,
      required String title,
      required Function onYes}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 25.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 3.h),
              Center(
                child: Text(
                  "Alert",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.sp),
                child: Text("$title", textAlign: TextAlign.center),
              ),
              Spacer(),
              Divider(color: Colors.black),
              Container(
                height: 7.h,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: SizedBox(
                        width: 30.w,
                        child: Text(
                          "No",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    VerticalDivider(color: Colors.black),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        onYes();
                      },
                      child: SizedBox(
                        width: 30.w,
                        child: Text(
                          "Yes",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
