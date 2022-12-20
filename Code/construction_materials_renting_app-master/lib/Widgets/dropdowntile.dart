import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:sizer/sizer.dart';

import 'custom_text.dart';

dropDownTile({required RxString value, required List<String> list,String? text}) {
  return Row(
    children: [
      SizedBox(width: 5.w),
      alignBodyText(text??"Select Role:"),
      Spacer(),
      DropdownButton(
          value: value.value,
          items: list.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (v) {
            value.value = v!.toString();
          }),
    ],
  );
}
