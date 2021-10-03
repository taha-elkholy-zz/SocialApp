import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cash_helper.dart';

import 'login_cubit/login_cubit.dart';
import 'login_cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // start BlocProvider of LoginCubit here
      // as we do not need it in any where
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          // listen for states
          if (state is LoginSuccessState) {
            CashHelper.saveData(key: USER_ID, value: state.userId)
                .then((value) {
              navigateAndFinish(context, HomeLayout());
            });
          }

          if (state is LoginErrorState) {
            showToast(message: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Login now to Communicate with your friends',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          context: context,
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          inputType: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                            context: context,
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your password';
                              }
                            },
                            onSubmit: (value) {
                              if (_formKey.currentState!.validate()) {
                                cubit.userEmailLogin(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                              }
                            },
                            inputType: TextInputType.visiblePassword,
                            label: 'Password',
                            prefix: Icons.lock_open_rounded,
                            isPassword: cubit.isPassword,
                            suffix: cubit.suffixIcon,
                            onSuffixPressed: () {
                              cubit.changePasswordVisibility();
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (BuildContext context) => defaultButton(
                              text: 'login',
                              isUpperCase: true,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.userEmailLogin(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                                }
                              }),
                          fallback: (BuildContext context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have account?'),
                            defaultTextButton(
                                text: 'register',
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
