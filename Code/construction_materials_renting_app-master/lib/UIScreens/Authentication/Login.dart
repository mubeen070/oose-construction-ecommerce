import 'package:CMRS/UIScreens/Authentication/resetPassword.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../services/authentication.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_text.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/snackbar.dart';
import '../../Widgets/text_field.dart';
import 'SignUp.dart';

class Signin extends StatelessWidget {
  Signin({Key? key}) : super(key: key);
  final TextEditingController passController = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          // appBar: appBar(title: "Sign in"),
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 85.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      alignHeadingText("SignIn"),
                      SizedBox(
                        height: 3.h,
                      ),
                      alignBodyText("Welcome To CMRS"),
                      SizedBox(
                        height: 2.h,
                      ),
                      alignBlueTextButton(
                          "Don't have an account?\nGo to Sign Up", () {
                        Get.to(() => SignUp());
                      }),
                      SizedBox(
                        height: 2.h,
                      ),
                      textField("E-Mail-Address", email,
                          textInputType: TextInputType.emailAddress),
                      textField("Password", passController, obscureText: true),
                      Padding(
                          padding: EdgeInsets.only(left: 3.5.w, bottom: 2.h),
                          child: alignBlueTextButton("Forgot Password?", () {
                            Get.to(() => ResetPassword());
                          }, alignment: Alignment.centerLeft)),
                      Padding(
                          padding: EdgeInsets.only(left: 3.5.w),
                          child: alignBodyText(
                              "By clicking Register you agree to our",
                              boxAlignment: Alignment.center)),
                      FittedBox(
                        child: Padding(
                          padding: EdgeInsets.only(left: 3.5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              alignBlueTextButton("Privacy Policy", () {}),
                              alignBodyText(" and  "),
                              alignBlueTextButton(
                                  "Terms and Conditions", () {}),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 3.5.w),
                          child: alignBodyText(".",
                              boxAlignment: Alignment.centerLeft)),
                      Spacer(),
                      customButton("Continue", () {
                        if (formValidation()) {
                          FocusScope.of(context).unfocus();
                          Authentication()
                              .signinWithEmail(email.text, passController.text);
                        }
                      }),
                      SizedBox(height: 2.h)
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

  bool formValidation() {
    if (email.text.isEmpty && passController.text.isEmpty) {
      alertSnackbar("All fields are required");
      return false;
    } else if (!GetUtils.isEmail(email.text)) {
      alertSnackbar("Email is not valid");
      return false;
    } else {
      return true;
    }
  }
}
