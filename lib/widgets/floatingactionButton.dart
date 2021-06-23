import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

SizedBox floatingActionButton({
  BuildContext context,
  var location,
  IconData icon,
  Color backgroundColor,
}) {
  return SizedBox(
    height: 60,
    width: 60,
    child: FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, location),
      backgroundColor: backgroundColor,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    ),
  );
}
