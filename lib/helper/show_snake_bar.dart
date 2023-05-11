import 'package:flutter/material.dart';

import '../constans.dart';

void showSnakeBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      showCloseIcon: true,
      backgroundColor: kPrimaryColor,
      duration: const Duration(seconds: 2),
      closeIconColor: Colors.red,
    ),
  );
}
