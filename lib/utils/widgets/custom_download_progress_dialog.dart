import 'package:flutter/material.dart';

class DownloadVideoSnackbar {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? _snackBarController;

  void showDownloadProgressSnackbar(BuildContext context, int progress) {
    // Check if a snackbar is already showing and dismiss it before showing a new one
    _snackBarController?.close();

    _snackBarController = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Downloading Video'),
            Text('$progress%'),
          ],
        ),
        duration: const Duration(days: 1), // Long duration so it stays visible until dismissed
      ),
    );
  }

  void updateProgressSnackbar(BuildContext context, int progress) {
    // Update the snackbar with the new progress
    if (_snackBarController != null) {
      _snackBarController!.close(); // Close the old one
    }
    _snackBarController = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Downloading Video'),
            Text('$progress%'),
          ],
        ),
        duration: const Duration(days: 1), // Keep it open
      ),
    );
  }

  void dismissSnackbar(BuildContext context) {
    if (_snackBarController != null) {
      _snackBarController!.close();
    }
  }

  void showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showErrorSnackbar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
