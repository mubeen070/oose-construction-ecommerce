import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

textButton(String title , Function func) {
  return SizedBox(
    height: 3.h,
    child: ElevatedButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.zero,
      ),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black, decoration: TextDecoration.underline),
      ),
      onPressed: () =>func(),
    ),
  );
}
