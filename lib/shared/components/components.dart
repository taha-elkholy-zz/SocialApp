import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/colors.dart';

// make all TextButtons with same style
Widget defaultTextButton({
  required String text,
  required Function() onPressed,
}) =>
    TextButton(
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: defaultColor, fontWeight: FontWeight.bold),
        ));

// Navigate and finish the screen default method
void navigateAndFinish({
  required BuildContext context,
  required Widget newScreen,
}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => newScreen));
}
