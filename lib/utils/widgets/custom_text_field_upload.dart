import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:vimeo_clone/config/colors.dart';

class CustomTextFieldUpload extends StatelessWidget {
  final TextEditingController controller;
  final String fieldLabel;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool? obscure;

  const CustomTextFieldUpload({
    super.key,
    required this.controller,
    required this.fieldLabel,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.obscure
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // validator: _validateTitle,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        // hintText: ' Title... ',
          labelText: '${fieldLabel}',
          labelStyle: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.secondaryFixedDim),

          // floatingLabelStyle: TextStyle(
          //
          // ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceDim,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: blue, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              // color: Colors.grey.shade900,
              color: Theme.of(context).colorScheme.secondaryFixedDim,
              width: 1.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          counterText: ''
      ),
    );
  }
}
