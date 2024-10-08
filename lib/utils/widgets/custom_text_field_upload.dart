import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';

class CustomTextFieldUpload extends StatelessWidget {
  final TextEditingController controller;
  final String fieldLabel;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool? obscure;
  final bool? isEnabled;
  final Widget? suffix;
  final bool? readOnly;
  final bool? autoFocus;
  final Function(String)? onChange;
  final String? Function(String?)? validator;

  const CustomTextFieldUpload({
    super.key,
    required this.controller,
    required this.fieldLabel,
    this.validator,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.obscure,
    this.isEnabled,
    this.suffix,
    this.readOnly,
    this.onChange,
    this.autoFocus
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // validator: _validateTitle,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      enabled: isEnabled ?? true,
      readOnly: readOnly ?? false,
      autofocus: autoFocus ?? false,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        // hintText: ' Title... ',
          labelText: fieldLabel,
          labelStyle: TextStyle(
            fontFamily: fontFamily,
              fontSize: 15,
              color: Theme.of(context).colorScheme.secondaryFixedDim),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceDim,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          suffix: suffix,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              // color: Colors.grey.shade900,
              color: Theme.of(context).colorScheme.secondary,
              width: 1.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          counterText: ''
      ),
      onChanged: onChange,
    );
  }
}
