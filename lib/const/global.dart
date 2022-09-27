import 'package:flutter/material.dart';

messagesnackbar(BuildContext context, String str, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(str.toString()),
    duration: const Duration(seconds: 3),
    backgroundColor: color,
  ));
}
