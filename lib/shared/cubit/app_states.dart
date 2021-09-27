abstract class AppStates {}

// initial State of my app
class AppInitialState extends AppStates {}

// Change Mode state of the app
class AppChangeModeState extends AppStates {}

// Get User States
class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserErrorState extends AppStates {
  final String error;

  AppGetUserErrorState(this.error);
}

// change bottom nav state
class AppChangeBottomNavState extends AppStates {}
