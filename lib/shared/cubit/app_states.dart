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

// remove user state
class AppRemoveUserModelState extends AppStates {}

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

class AppPickPostImageSuccessState extends AppStates {}

class AppPickPostImageErrorState extends AppStates {
  final String error;

  AppPickPostImageErrorState(this.error);
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

class AppUploadPostImageLoadingState extends AppStates {}

class AppUploadPostImageSuccessState extends AppStates {}

class AppUploadPostImageErrorState extends AppStates {
  final String error;

  AppUploadPostImageErrorState(this.error);
}

// create post states
class AppCreatePostLoadingState extends AppStates {}

class AppCreatePostSuccessState extends AppStates {}

class AppCreatePostErrorState extends AppStates {
  final String error;

  AppCreatePostErrorState(this.error);
}

// remove image states
class AppRemoveProfileImageState extends AppStates {}

class AppRemoveCoverImageState extends AppStates {}

class AppRemovePostImageState extends AppStates {}

// get posts states
class AppGetPostsLoadingState extends AppStates {}

class AppGetPostsSuccessState extends AppStates {}

class AppGetPostsErrorState extends AppStates {
  final String error;

  AppGetPostsErrorState(this.error);
}

// like a post states
class AppLikePostsSuccessState extends AppStates {}

class AppLikePostsErrorState extends AppStates {
  final String error;

  AppLikePostsErrorState(this.error);
}

// Write a Comment states
class AppWriteCommentSuccessState extends AppStates {}

class AppWriteCommentErrorState extends AppStates {
  final String error;

  AppWriteCommentErrorState(this.error);
}

// Write a Comment states
class AppGetCommentsSuccessState extends AppStates {}

class AppGetCommentsErrorState extends AppStates {
  final String error;

  AppGetCommentsErrorState(this.error);
}

// get all users states
class AppGetAllUsersLoadingState extends AppStates {}

class AppGetAllUsersSuccessState extends AppStates {}

class AppGetAllUsersErrorState extends AppStates {
  final String error;

  AppGetAllUsersErrorState(this.error);
}
