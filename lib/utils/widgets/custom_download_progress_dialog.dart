import 'package:flutter/material.dart';

class DownloadVideoAlertDialog {
  void showDownloadProgressDialog(BuildContext context, int progress) {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Downloading Video'),
          // content: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     LinearProgressIndicator(
          //       value: progress / 100.0,
          //       backgroundColor: Colors.grey[200],
          //       color: Colors.blue,
          //     ),
          //     SizedBox(height: 10),
          //     Text('$progress%'),
          //   ],
          // ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(error),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
