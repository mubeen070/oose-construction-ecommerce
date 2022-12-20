import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tab_container/tab_container.dart';
import '../../../services/authentication.dart';
import '../../Widgets/appbar.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_text.dart';
import '../../Widgets/dropdowntile.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/snackbar.dart';
import '../../Widgets/text_field.dart';
import 'SignUp.dart';

class AdminSignUp extends StatelessWidget {
  AdminSignUp({Key? key}) : super(key: key);
  final TextEditingController passController = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController designation = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController cnic = TextEditingController();
  final TextEditingController contactNo = TextEditingController();
  final RxBool isAdmin = true.obs;
  final RxString adminType = 'superAdmin'.obs;
  var gender = 'Male'.obs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar(title: "Register"),
            body: Padding(
              padding: EdgeInsets.all(8.sp),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                          color: Colors.blue,
                          child: Text('Register As User',style: TextStyle(color: Colors.white),),
                          onPressed: (){
                            Get.to(()=>SignUp());
                          }

                      )
                    ],
                  ),
                  alignHeadingText("Register As Admin to CMRS"),
                  SizedBox(
                    height: 2.h,
                  ),
                  alignBodyText(
                      "Smart Renting App"),
                  SizedBox(
                    height: 2.h,
                  ),
                  textField("Name", name),
                  textField("E-Mail-Address", email,
                      textInputType: TextInputType.emailAddress),
                  textField("Password", passController, obscureText: true),
                  textField("Address", address),
                  textField("CNIC", cnic,
                      textInputType: TextInputType.phone),
                  textField("Contact Number", contactNo,
                      textInputType: TextInputType.phone),
                  Obx(() => Column(
                    children: [
                      textField("Designation", designation),
                      dropDownTile(value: gender, list: [
                        'Male',
                        'Female',
                      ],text: "Gender"),
                    ],
                  )),
                  SizedBox(height: 6.h),
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
                          alignBlueTextButton("Terms and Conditions", () {}),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 3.5.w),
                      child:
                      alignBodyText(".", boxAlignment: Alignment.centerLeft)),
                  SizedBox(height: 1.h),
                  customButton("Register", (){
                    if (formValidation()) {
                      FocusScope.of(context).unfocus();
                      Authentication().createAccount(
                          name: name.text,
                          email: email.text,
                          pass: passController.text,
                          isAdmin: true,
                          adminType: adminType.value,
                          designation: designation.text,
                          address: address.text.trim(),
                          cnic: cnic.text.trim(),
                          contactNo: contactNo.text.trim(),
                          gender: gender.value
                      ).then((value)=>Get.back());
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
        LoadingWidget()
      ],
    );
  }

  bool formValidation() {
    if (name.text.isEmpty || passController.text.isEmpty) {
      alertSnackbar("All fields are required");
      return false;
    } else if (!GetUtils.isEmail(email.text)) {
      alertSnackbar("Email is not valid");
      return false;
    } else if (passController.text.length < 6) {
      alertSnackbar("Password must be of atleast 6 charachters");
      return false;
    } else if (isAdmin.value) {
      if (designation.text.isEmpty) {
        alertSnackbar("Designation required");
        return false;
      } else
        return true;
    } else
      return true;
  }

  checkBoxTile(
      {required String text, required bool value, required onChange(v)}) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(width: 5.w),
          alignBodyText(text),
          Spacer(),
          Checkbox(
              value: value,
              onChanged: (v) {
                value = v!;
                onChange(v);
              })
        ],
      ),
    );
  }
}
