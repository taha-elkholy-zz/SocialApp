import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var model = cubit.userModel!;
        nameController.text = model.name;
        bioController.text = model.bio;
        phoneController.text = model.phone;

        final snackBar = SnackBar(
          content: const Text('You have un saved image'),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                if (cubit.coverImage != null) {
                  cubit.removeCoverImage();
                }
                if (cubit.profileImage != null) {
                  cubit.removeProfileImage();
                }
              }),
        );
        return Scaffold(
          appBar: defaultAppBarr(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                  text: 'update',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (cubit.profileImage != null ||
                          cubit.coverImage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        cubit
                            .updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              bio: bioController.text,
                            )
                            .then((value) => Navigator.pop(context));
                      }
                    }
                  }),
              const SizedBox(
                width: 15,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is AppUpdateUserLoadingState ||
                        state is AppUploadCoverImageLoadingState ||
                        state is AppUploadProfileImageLoadingState)
                      Column(
                        children: const [
                          LinearProgressIndicator(),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    SizedBox(
                      height: 240,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 180,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.0),
                                      topLeft: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      // if user picked image use it
                                      image: (cubit.coverImage == null)
                                          ? NetworkImage(model.coverImage)
                                          : FileImage(cubit.coverImage!)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.getCoverImage();
                                      },
                                      icon: const Icon(IconBroken.Camera),
                                      iconSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  backgroundImage: (cubit.profileImage == null)
                                      ? NetworkImage(model.image)
                                      : FileImage(cubit.profileImage!)
                                          as ImageProvider,
                                  radius: 60,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.getProfileImage();
                                    },
                                    icon: const Icon(IconBroken.Camera),
                                    iconSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (cubit.profileImage != null || cubit.coverImage != null)
                      Column(
                        children: [
                          Row(
                            children: [
                              if (cubit.profileImage != null)
                                Expanded(
                                    child: defaultButton(
                                  text: 'save profile',
                                  onPressed: () {
                                    // upload the profile image and update it
                                    cubit.uploadProfileImage().then(
                                        (value) => cubit.profileImage = null);
                                  },
                                )),
                              if (cubit.profileImage != null &&
                                  cubit.coverImage != null)
                                const SizedBox(
                                  width: 5,
                                ),
                              if (cubit.coverImage != null)
                                Expanded(
                                    child: defaultButton(
                                  text: 'save cover',
                                  onPressed: () {
                                    // upload the cover image and update it
                                    cubit.uploadCoverImage().then(
                                        (value) => cubit.coverImage = null);
                                  },
                                )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    defaultTextFormField(
                      context: context,
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'User name must not be empty';
                        }
                      },
                      inputType: TextInputType.name,
                      label: 'User Name',
                      prefix: IconBroken.User,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextFormField(
                      context: context,
                      controller: bioController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'User Bio must not be empty';
                        }
                      },
                      inputType: TextInputType.name,
                      label: 'User Bio',
                      prefix: IconBroken.Info_Circle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextFormField(
                      context: context,
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'User Phone must not be empty';
                        }
                      },
                      inputType: TextInputType.phone,
                      label: 'User Phone',
                      prefix: IconBroken.Call,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
