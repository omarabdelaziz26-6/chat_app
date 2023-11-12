import 'package:flutter/material.dart';

void showSnackBarFunction(BuildContext context,
    {required String snackBarText}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      showCloseIcon: true,
      closeIconColor: Colors.black,
      duration: const Duration(seconds: 3),
      content: Text(
        snackBarText,
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
    ),
  );
}
