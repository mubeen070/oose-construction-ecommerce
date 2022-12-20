import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

alignBodyText(
  String text, {
  Alignment? boxAlignment,
  TextAlign? textAlign,
  TextStyle? style,
}) {
  return Align(
    alignment: boxAlignment ?? Alignment.center,
    child: Text(
      """$text""",
      textAlign: textAlign ?? TextAlign.center,
      style: style ?? TextStyle(color: Colors.black),
      overflow: TextOverflow.clip,
    ),
  );
}

alignHeadingText(
  String text, {
  Alignment? alignment,
  TextStyle? style,
}) {
  return Align(
    alignment: alignment ?? Alignment.center,
    child: Text(
      "$text",
      style: style ??
          TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.0.sp),
    ),
  );
}
