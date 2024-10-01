import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';

void customRadioBottomSheet<T>({
  required bottomSheetTitle,
  required BuildContext context,
  required List<T> options,
  required T selectedValue,
  required ValueChanged<T> onChanged,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              Text(
                  bottomSheetTitle,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 20.sp
                ),
              ),
              SizedBox(height: 15.h),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: options.map((T value) {
                  return RadioListTile<T>(
                    title: Text(
                      value.toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    value: value,
                    activeColor: primaryColor,
                    groupValue: selectedValue,
                    onChanged: (T? newValue) {
                      if (newValue != null) {
                        onChanged(newValue);
                        Navigator.pop(context); // Close bottom sheet after selection
                      }
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    },
  );
}
