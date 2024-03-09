import 'package:flutter/material.dart';

void showSnackbar(
  context, {
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
    ),
  );
}
