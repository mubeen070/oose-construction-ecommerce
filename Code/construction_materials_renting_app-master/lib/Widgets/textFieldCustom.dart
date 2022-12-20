import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

textFieldCustom(String? hint, TextEditingController controller,
    {Widget? widget, bool? obscureText,TextInputType textInputType = TextInputType.text,bool? readOnly,String? text}) {
  controller.text = text??'';
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
    child: TextField(
      readOnly: readOnly??false,
      style: TextStyle(color: Colors.black),
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        focusColor: Colors.blue,
          border: UnderlineInputBorder(),
          focusedBorder: UnderlineInputBorder(),
          suffixIcon: widget ?? SizedBox(),
          hintText: hint??'',
          hintStyle: TextStyle(fontWeight: FontWeight.w300)),
      obscureText: obscureText ?? false,
    ),
  );
}