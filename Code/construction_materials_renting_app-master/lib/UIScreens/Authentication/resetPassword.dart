import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../Controller/loading.dart';
import '../../Services/Authentication.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_text.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/snackbar.dart';
import '../../Widgets/text_field.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 95.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 2.h),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Password Reset",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0.sp,
                                    color: Colors.blue),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              width: 8.w,
                              height: 4.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Icon(
                                  CupertinoIcons.clear,
                                  color: Colors.grey,
                                  size: 15.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: alignBodyText(
                            "By sumbitting your E-Mail you will recieve a mail in your mailbox with a link to reset your password after which you can login again",
                            textAlign: TextAlign.left),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.5.w, top: 2.h),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Email",
                            style: TextStyle(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                      textField("E-Mail", email,
                          textInputType: TextInputType.emailAddress,
                          widget: Column(children: [
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Text("E-Mail",
                                style: TextStyle(color: Colors.grey.shade400))
                          ])),
                      SizedBox(
                        height: 2.2.h,
                      ),
                      customButton("Reset Password", () {
                        GetUtils.isEmail(email.text)
                            ? {
                          FocusScope.of(context).unfocus(),
                          loading(true),
                          Authentication().forgotPassword(email.text)
                        }
                            : snackbar(
                          'Alert',
                          "Provide valid email",
                        );
                      }),
                      SizedBox(
                        height: 2.2.h,
                      ),
                      customButton("Abort, Go Back!", () {
                        Get.back();
                      },
                          bgColor: (Colors.white),
                          textColor: Colors.blue),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        LoadingWidget()
      ],
    );
  }
}
