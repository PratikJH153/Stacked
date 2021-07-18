import 'package:dailytodo/views/wrapper.dart';
import 'package:flutter/material.dart';

AlertDialog alertDialog({
  BuildContext context,
  String title,
  Function isYes,
}) {
  return AlertDialog(
    backgroundColor: Colors.grey[900],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    title: Text(title),
    content: Text(
      "Are you sure to reset every $title?",
      style: TextStyle(
        color: Colors.grey[400],
        fontWeight: FontWeight.w400,
        height: 1.5,
        fontSize: 16,
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => isYes(),
        child: Text(
          "Yes",
          style: TextStyle(
            color: Colors.red[400],
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          return Navigator.pop(context);
        },
        child: Text("No"),
      ),
    ],
  );
}
