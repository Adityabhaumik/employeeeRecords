import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text),
    duration: Duration(seconds: 3), // Set the duration for how long the Snackbar will be visible
  );

  // Show the Snackbar using the ScaffoldMessenger
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
