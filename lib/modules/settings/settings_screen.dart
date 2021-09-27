import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/network/local/cash_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: defaultTextButton(
            text: 'logout',
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                CashHelper.removeData(key: USER_ID);
                AppCubit.get(context).currentIndex = 0;
                navigateAndFinish(context, LoginScreen());
              });
            }),
      ),
    );
  }
}
