import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';

// Reusable Radio Button Widget
class RadioButtonList<T> extends StatelessWidget {
  final List<T> options;
  final T selectedValue;
  final ValueChanged<T> onChanged;

  RadioButtonList({
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: options.map((T value) {
        return RadioListTile<T>(
          title: Text(
              value.toString(),
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 15.sp
            ),
          ),
          value: value,
          activeColor: primaryColor,
          groupValue: selectedValue,
          onChanged: (T? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        );
      }).toList(),
    );
  }
}
