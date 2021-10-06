import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:crop/crop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);
  var textController = TextEditingController();
  var cropController = CropController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppCreatePostSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar:
              defaultAppBarr(context: context, title: 'Create Post', actions: [
            defaultTextButton(
                text: 'post',
                onPressed: () {
                  if (cubit.postImage != null) {
                    cubit.uploadPostImage(
                      dateTime: DateTime.now().toString(),
                      text: textController.text,
                    );
                  } else {
                    if (textController.text.isEmpty) {
                      showToast(
                          message: 'Type something or upload a photo...',
                          state: ToastStates.WARNING);
                    } else {
                      cubit.createPost(
                        dateTime: DateTime.now().toString(),
                        text: textController.text,
                      );
                    }
                  }
                })
          ]),
          body: ConditionalBuilder(
            condition: state is! AppCreatePostLoadingState,
            fallback: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(cubit.userModel!.image),
                          radius: 25,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            cubit.userModel!.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(height: 1.4),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: 'What\'s on your mind...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (cubit.postImage != null)
                      SizedBox(
                        height: 240,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 180,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: FileImage(cubit.postImage!),
                                      fit: BoxFit.cover)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 20,
                                child: IconButton(
                                  onPressed: () {
                                    cubit.removePostImage();
                                  },
                                  icon: const Icon(IconBroken.Close_Square),
                                  iconSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                cubit.getPostImage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(IconBroken.Image),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Add Photo'),
                                ],
                              )),
                        ),
                        Expanded(
                            child: TextButton(
                          onPressed: () {},
                          child: const Text('# tags'),
                        ))
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
