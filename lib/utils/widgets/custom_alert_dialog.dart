import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String alertDialogTitle;
  final Widget alertDialogWidgets;

  const CustomAlertDialog({
    super.key,
    required this.alertDialogTitle,
    required this.alertDialogWidgets
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(alertDialogTitle),
      content: alertDialogWidgets
    );
  }
}
