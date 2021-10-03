import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/register_cubit/register_states.dart';
import 'package:social_app/shared/components/constants.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // show and hide password of the password text form field
  IconData passwordSuffixIcon = Icons.visibility_outlined;
  bool passwordIsPassword = true;

  void changePasswordVisibility() {
    passwordIsPassword = !passwordIsPassword;
    passwordSuffixIcon = passwordIsPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  // show and hide password of the confirm password text form field
  IconData confirmPasswordSuffixIcon = Icons.visibility_outlined;
  bool confirmPasswordIsPassword = true;

  void changeConfirmPasswordVisibility() {
    confirmPasswordIsPassword = !confirmPasswordIsPassword;
    confirmPasswordSuffixIcon = confirmPasswordIsPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  // register with email and password
  void userEmailRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (value.user != null) {
        createUser(
          userId: value.user!.uid,
          name: name,
          email: email,
          phone: phone,
        );
        //remove register success state to make the loading
        // doing until the user created then navigate to home
        //emit(RegisterSuccessState());
      } else {
        emit(RegisterErrorState('There is no user created'));
      }
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

  // create user and save users data on firebase firestore
  void createUser({
    required String userId,
    required String name,
    required String email,
    required String phone,
  }) {
    // create user with my own model of user
    UserModel model = UserModel(
      userId: userId, name: name, phone: phone, email: email,
      // use default image
    );

    FirebaseFirestore.instance
        .collection(USERS_COLLECTION)
        .doc(userId)
        .set(model.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState());
      print('user created in data base with name: $name');
    }).catchError((error) {
      emit(RegisterCreateUserErrorState(error.toString()));
      print('user not created in data base with error: $error');
    });
  }
}
