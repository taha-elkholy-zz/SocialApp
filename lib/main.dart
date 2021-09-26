import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';
import 'package:social_app/shared/network/local/cash_helper.dart';
import 'package:social_app/shared/styles/themes.dart';

void main() async {
  // wait until async processes complete first
  // then run the app
  WidgetsFlutterBinding.ensureInitialized();

  // add bloc observer for monitoring my code
  Bloc.observer = MyBlocObserver();

  // init SharedPreferences
  await CashHelper.init();

  // get app mode from shared preferences
  // dynamic as it may be null in first time
  dynamic _isDark = CashHelper.getData(key: IS_DARK);

  // start home of the app
  // it may be OnBoarding, Login or HomeScreen
  late Widget _home;

  // dynamic as it may be null in first time
  dynamic _isBoardingSeen = CashHelper.getData(key: BOARDING_SEEN);

  if (_isBoardingSeen != null) {
    // user seen the on boarding before
    // we will not shown it again
    // todo if user login go to home screen
    _home = const LoginScreen();
  } else {
    // user do not see on boarding yet
    _home = const OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: _isDark,
    home: _home,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({required this.isDark, required this.home, Key? key}) : super(key: key);

  // refer to app mode
  bool? isDark;

  // refer to the start page of the app
  Widget home;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..getAppMode(isDark: isDark),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: home,
          );
        },
      ),
    );
  }
}

