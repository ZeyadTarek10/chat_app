   import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required String text, required Color color}) {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      text,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: color,
    elevation: 10, 
    margin: const EdgeInsets.all(20), 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    duration: const Duration(seconds: 2),
    // action: SnackBarAction(
    //   label: 'DISMISS',
    //   textColor: Colors.white,
    //   onPressed: () {
    //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //   },
    // ),
  ),
);
  }