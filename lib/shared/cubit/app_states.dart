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

// Update User States
class AppUpdateUserLoadingState extends AppStates {}

class AppUpdateUserSuccessState extends AppStates {}

class AppUpdateUserErrorState extends AppStates {
  final String error;

  AppUpdateUserErrorState(this.error);
}

// change bottom nav state
class AppChangeBottomNavState extends AppStates {}

class AppNewPostState extends AppStates {}

// pick image states
class AppPickCoverImageSuccessState extends AppStates {}

class AppPickCoverImageErrorState extends AppStates {
  final String error;

  AppPickCoverImageErrorState(this.error);
}

class AppPickProfileImageSuccessState extends AppStates {}

class AppPickProfileImageErrorState extends AppStates {
  final String error;

  AppPickProfileImageErrorState(this.error);
}

// upload images states
class AppUploadCoverImageLoadingState extends AppStates {}

class AppUploadCoverImageSuccessState extends AppStates {}

class AppUploadCoverImageErrorState extends AppStates {
  final String error;

  AppUploadCoverImageErrorState(this.error);
}

class AppUploadProfileImageLoadingState extends AppStates {}

class AppUploadProfileImageSuccessState extends AppStates {}

class AppUploadProfileImageErrorState extends AppStates {
  final String error;

  AppUploadProfileImageErrorState(this.error);
}
