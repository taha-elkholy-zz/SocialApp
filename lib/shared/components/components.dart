import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

// make all TextButtons with same style
Widget defaultTextButton({
  required String text,
  required Function() onPressed,
  Color color = defaultColor,
}) =>
    TextButton(
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ));

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

// Navigate and finish the screen default method
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    // save the last route or note
    (route) => false); // remove all l

// text form field

Widget defaultTextFormField({
  required context,
  required TextEditingController controller,
  required String? Function(String? value) validator,
  required TextInputType inputType,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? onSuffixPressed,
  Function()? onTap,
  Function(String s)? onChanged,
  Function(String s)? onSubmit,
  bool isPassword = false,
  TextCapitalization textCapitalization = TextCapitalization.none,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: isPassword,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      textCapitalization: textCapitalization,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: onSuffixPressed,
        ),
      ),
      validator: validator,
    );

// default button

Widget defaultButton({
  double width = double.infinity, // giv it default width but can edit later
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 5.0,
  required String text,
  required Function()? onPressed,
}) =>
    Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: onPressed,
      ),
    );

// Show toast depends on the state of the operation
void showToast({required String message, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WARNING }

// get hte color of the toast depend on the state
// success, error and warning
Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

defaultAppBarr({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      titleSpacing: 5,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(IconBroken.Arrow___Left_2)),
      title: (title != null) ? Text(title) : null,
      actions: (actions != null) ? actions : null,
    );
