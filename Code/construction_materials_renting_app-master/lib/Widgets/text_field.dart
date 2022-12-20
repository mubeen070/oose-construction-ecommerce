import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

textField(String hint, TextEditingController controller,
    {Widget? widget, bool? obscureText,TextInputType textInputType = TextInputType.text,bool? readOnly,String? text}) {

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
    child: TextField(
      readOnly: readOnly??false,
      style: TextStyle(color: Colors.blue),
      controller: controller,
      keyboardType: textInputType,
      cursorColor: Colors.lightBlue,
      decoration: InputDecoration(
        helperText: text,
          suffixIcon: widget ?? SizedBox(),
          border: UnderlineInputBorder(
              ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlue)),
          hintText: hint,
          hintStyle: TextStyle(fontWeight: FontWeight.w300)),
      obscureText: obscureText ?? false,
    ),
  );
}
/*
textField(String hint, TextEditingController controller,
    {Widget? widget, bool obscureText = false}) {
  final visible = Get.find<IntroController>();
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
    child: Obx(() {
      return TextField(
        style: TextStyle(color: MyColors.blue),
        controller: controller,
        cursorColor: MyColors.lightBlue,
        decoration: InputDecoration(
            suffixIcon: obscureText
                ? GestureDetector(
                    onTap: () {
                      visible.obscureText.value = !visible.obscureText.value;
                    },
                    child: Icon(
                      visible.obscureText.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: MyColors.lightBlue,
                    ))
                : widget ?? SizedBox(),
            border: UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyColors.lightBlue)),
            hintText: hint,
            hintStyle: TextStyle(fontWeight: FontWeight.w300)),
        obscureText: obscureText,
      );
    }),
  );
}
*/