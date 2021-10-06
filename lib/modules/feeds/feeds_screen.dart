import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({Key? key}) : super(key: key);
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppCreatePostSuccessState) {
          AppCubit.get(context).getPosts();
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.userModel != null && cubit.posts.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: const EdgeInsets.all(8),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      const Image(
                        image: NetworkImage(
                            'https://image.freepik.com/free-photo/portrait-positive-male-with-brunette-hair-bristle-has-piercing-wearing-black-sweater-holding-mobile-phone-copy-space-right-isolated-yellow-wall_295783-14551.jpg'),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildPostItem(context, cubit.posts[index], index),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                    itemCount: cubit.posts.length),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(context, PostModel post, index) => Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(post.postUserImage),
                    radius: 25,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                post.postUserName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(height: 1.4),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(Icons.check_circle,
                                size: 15, color: Colors.blue),
                          ],
                        ),
                        Text(
                          post.dateTime,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 16,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  color: Colors.grey.shade300,
                  width: double.infinity,
                  height: 1,
                ),
              ),
              if (post.postText != null || post.postText == '')
                Text(
                  post.postText!,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              if (post.postHashTags != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 6,
                      children: [
                        SizedBox(
                            height: 25,
                            child: MaterialButton(
                              padding: EdgeInsets.zero,
                              minWidth: 1,
                              onPressed: () {},
                              child: Text(
                                '#Software',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.blue),
                              ),
                            )),
                        SizedBox(
                            height: 25,
                            child: MaterialButton(
                              padding: EdgeInsets.zero,
                              minWidth: 1,
                              onPressed: () {},
                              child: Text(
                                '#Software',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.blue),
                              ),
                            )),
                        SizedBox(
                            height: 25,
                            child: MaterialButton(
                              padding: EdgeInsets.zero,
                              minWidth: 1,
                              onPressed: () {},
                              child: Text(
                                '#Software',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.blue),
                              ),
                            )),
                        SizedBox(
                            height: 25,
                            child: MaterialButton(
                              padding: EdgeInsets.zero,
                              minWidth: 1,
                              onPressed: () {},
                              child: Text(
                                '#Software_development_workshop',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.blue),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              if (post.postImage != null)
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(
                        post.postImage!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Row(
                        children: [
                          const Icon(IconBroken.Heart, color: Colors.red),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${AppCubit.get(context).postLikes.length}',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(IconBroken.Chat, color: Colors.amber),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${post.postCommentsCount} Comments',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                      onTap: () {
                        AppCubit.get(context).getComments(post.postId);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  color: Colors.grey.shade300,
                  width: double.infinity,
                  height: 1,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                AppCubit.get(context).userModel!.image),
                            radius: 18,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Write a comment...',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          builder: (context) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Comment'),
                              const SizedBox(
                                height: 15,
                              ),
                              defaultTextFormField(
                                  context: context,
                                  controller: commentController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Type something';
                                    }
                                  },
                                  inputType: TextInputType.text,
                                  label: 'Comment',
                                  prefix: IconBroken.Edit),
                              defaultButton(
                                  text: 'Share a Comment',
                                  onPressed: () {
                                    AppCubit.get(context).comment(
                                        post.postId, commentController.text);
                                  })
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(IconBroken.Heart, color: Colors.amber),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    onTap: () {
                      AppCubit.get(context)
                          .likePost(AppCubit.get(context).postsIds[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
