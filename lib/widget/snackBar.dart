import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String massage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(massage),
      duration: const Duration(milliseconds: 1000),
      action: SnackBarAction(
        label: 'Done',
        onPressed: () {},
      ),
    ),
  );
}
