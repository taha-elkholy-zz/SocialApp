import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ConditionalBuilder(
              condition: cubit.users.isNotEmpty &&
                  state is! AppGetAllUsersLoadingState,
              builder: (context) => ListView.separated(
                    itemBuilder: (context, index) =>
                        buildUserItem(context, cubit.users[index]),
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        color: Colors.grey.shade300,
                        width: double.infinity,
                        height: 1,
                      ),
                    ),
                    itemCount: cubit.users.length,
                  ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator())),
        );
      },
    );
  }

  Widget buildUserItem(context, UserModel user) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(user.image),
          radius: 25,
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            user.name,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(height: 1.4),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
