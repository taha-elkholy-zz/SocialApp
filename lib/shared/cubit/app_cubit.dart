import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cash_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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

  late UserModel userModel;

  void getUserData() {
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance
        .collection(USERS_COLLECTION)
        .doc(userId)
        .get()
        .then((value) {
      if (value.data() != null) {
        userModel = UserModel.fromJson(value.data()!);
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
    const NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

// change bottom nav bar
  void changeBottomNavBar({required int index}) {
    if (index == 2) {
      emit(AppNewPostState());
    } else {
      currentIndex = index;
      emit(AppChangeBottomNavState());
    }
  }

  // Pick image
  final ImagePicker picker = ImagePicker();

  // get profile image file
  File? profileImage;

  // pick profile image from phone
  Future<void> getProfileImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(AppPickProfileImageSuccessState());
    } else {
      print('No image picked');
      emit(AppPickProfileImageErrorState('No profile image picked'));
    }
  }

  // get cover image file
  File? coverImage;

  // pick cover image from phone
  Future<void> getCoverImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(AppPickCoverImageSuccessState());
    } else {
      print('No image picked');
      emit(AppPickCoverImageErrorState('No Cover image picked'));
    }
  }

  // upload profile image and update download url
  Future<void> uploadProfileImage() async {
    emit(AppUploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/$userId/profile')
        .child(Uri.file(profileImage!.path).pathSegments.last)
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // profileImageUrl = value;
        print('Profile image uploaded successfully with url: $value');
        emit(AppUploadProfileImageSuccessState());
        // update cover image
        updateUserData(profileImageUrl: value);
      }).catchError((error) {
        print('error when get profile image url');
        emit(AppUploadProfileImageErrorState(error));
      });
    }).catchError((error) {
      print('error when upload profile image $error');
      emit(AppUploadProfileImageErrorState(error));
    });
  }

  // upload cover image and update download url
  Future<void> uploadCoverImage() async {
    emit(AppUploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/$userId/cover')
        .child(Uri.file(coverImage!.path).pathSegments.last)
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('Cover image uploaded successfully with url: $value');
        emit(AppUploadCoverImageSuccessState());
        // update cover image
        updateUserData(coverImageUrl: value);
      }).catchError((error) {
        print('error when get cover image url');
        emit(AppUploadCoverImageErrorState(error));
      });
    }).catchError((error) {
      print('error when upload cover image $error');
      emit(AppUploadCoverImageErrorState(error));
    });
  }

  // update user data
  Future<void> updateUserData({
    String? name,
    String? phone,
    String? bio,
    String? profileImageUrl,
    String? coverImageUrl,
  }) async {
    emit(AppUpdateUserLoadingState());
    UserModel updatedModel = UserModel(
      userId: userModel.userId,
      // fixed not updated
      email: userModel.email,
      // fixed not updated
      isEmailVerified: userModel.isEmailVerified,
      // fixed not updated

      // may be changed or not if null use model data
      name: name ?? userModel.name,
      phone: phone ?? userModel.phone,
      bio: bio ?? userModel.bio,
      image: profileImageUrl ?? userModel.image,
      coverImage: coverImageUrl ?? userModel.coverImage,
    );
    FirebaseFirestore.instance
        .collection(USERS_COLLECTION)
        .doc(userId)
        .update(updatedModel.toMap())
        .then((value) {
      emit(AppUpdateUserSuccessState());
      getUserData();
    }).catchError((error) {
      emit(AppUpdateUserErrorState(error.toString()));
      print(error.toString());
    });
  }
}
