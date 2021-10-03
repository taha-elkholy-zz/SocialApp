import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modules/register/register_cubit/register_cubit.dart';
import 'package:social_app/modules/register/register_cubit/register_states.dart';
import 'package:social_app/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          // listen for states
          if (state is RegisterCreateUserSuccessState) {
            navigateAndFinish(context, HomeLayout());
          }

          if (state is RegisterErrorState) {
            showToast(message: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              // control of status bar color
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark),
            ),
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
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Register now to Communicate with your friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                            context: context,
                            controller: _nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your name';
                              }
                            },
                            inputType: TextInputType.text,
                            label: 'User Name',
                            prefix: Icons.person,
                            textCapitalization: TextCapitalization.sentences),
                        const SizedBox(
                          height: 15,
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
                          controller: _phoneController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }
                          },
                          inputType: TextInputType.phone,
                          label: 'Phone Number',
                          prefix: Icons.phone,
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
                            inputType: TextInputType.visiblePassword,
                            label: 'Password',
                            prefix: Icons.lock_open_rounded,
                            isPassword: cubit.passwordIsPassword,
                            suffix: cubit.passwordSuffixIcon,
                            onSuffixPressed: () {
                              cubit.changePasswordVisibility();
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                            context: context,
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please confirm your password';
                              } else if (value != _passwordController.text) {
                                return 'Password not match';
                              }
                            },
                            onSubmit: (value) {
                              if (_formKey.currentState!.validate()) {
                                cubit.userEmailRegister(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    phone: _phoneController.text,
                                    password: _passwordController.text);
                              }
                            },
                            inputType: TextInputType.visiblePassword,
                            label: 'Confirm Password',
                            prefix: Icons.lock_open_rounded,
                            isPassword: cubit.confirmPasswordIsPassword,
                            suffix: cubit.confirmPasswordSuffixIcon,
                            onSuffixPressed: () {
                              cubit.changeConfirmPasswordVisibility();
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (BuildContext context) => defaultButton(
                              text: 'register',
                              isUpperCase: true,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.userEmailRegister(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      phone: _phoneController.text,
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
                            const Text('Already have an account?'),
                            defaultTextButton(
                                text: 'Login',
                                onPressed: () {
                                  Navigator.pop(context);
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
