import 'package:flutter/material.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import 'constants.dart';

Widget confirmationSlider({
  Function onConfirmed,
  double height,
}) {
  return ConfirmationSlider(
    onConfirmation: onConfirmed,
    foregroundColor: kaccentColor,
    text: "Slide to Finish",
    textStyle: const TextStyle(
      color: Color(0xFF616161),
      fontWeight: FontWeight.w600,
    ),
    shadow: const BoxShadow(
      blurRadius: 5,
      spreadRadius: 0.5,
      color: Colors.black26,
    ),
    backgroundColor: Colors.grey[900],
    height: height,
  );
}
