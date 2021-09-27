import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cash_helper.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  // constructor match super with app initial state
  AppCubit() : super(AppInitialState());

  // a static object from the AppCubit
  // to be use in other classes
  static AppCubit get(context) => BlocProvider.of(context);

  //********Start App Mode********
  // app mode start with light mode
  bool isDark = false;

  // this method tell the app which mode
  // should be start when app lunched
  void getAppMode({required bool? isDark}) {
    if (isDark != null) {
      this.isDark = isDark;
      emit(AppChangeModeState());
    } else {
      // first time  open the app
      // isDark from shared = null
      // save isDark false value in first time open
      CashHelper.saveData(key: IS_DARK, value: this.isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  // change the app mode by revers isDark value
  // and save the new one in shared preferences
  void changeAppMode() {
    // revers the value of isDark
    isDark = !isDark;
    // save isDark reversed value in shared preferences
    CashHelper.saveData(key: IS_DARK, value: isDark).then((value) {
      emit(AppChangeModeState());
    });
  }

//********End App Mode********

//********Start Get User********

  UserModel? model;

  void getUserData() {
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance
        .collection(USERS_COLLECTION)
        .doc(userId)
        .get()
        .then((value) {
      if (value.data() != null) {
        model = UserModel.fromJson(value.data()!);
        emit(AppGetUserSuccessState());
        print(value.data());
      }
    }).catchError((error) {
      emit(AppGetUserErrorState(error.toString()));
      print(error.toString());
    });
  }

// ********End Get User********

// bottom nav bar current index
  int currentIndex = 0;

  // home layout screens
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];

// change bottom nav bar
  void changeBottomNavBar({required int index}) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }
}
