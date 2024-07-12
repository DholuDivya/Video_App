import 'package:flutter/material.dart';
import 'package:vimeo_clone/config/constants.dart';

import '../../config/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    this.controller,
    this.validator,
    this.label,
    required this.obscureText,
    this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      cursorColor: Theme.of(context).colorScheme.tertiary,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: primaryColor,
                width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1.0
            ),
          ),
          suffixIcon: suffixIcon,
          labelText: label,
          labelStyle: TextStyle(
              fontFamily: fontFamily,
              color: Theme.of(context).colorScheme.primaryFixedDim,
              fontSize: 13
          ),
          // helperText: ''
      ),
    );
  }
}
