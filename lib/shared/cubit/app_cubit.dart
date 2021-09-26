import 'package:flutter_bloc/flutter_bloc.dart';
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

//********Start App Mode********
}
