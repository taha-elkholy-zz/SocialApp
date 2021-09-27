import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/search/search_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);

  List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Feeds'),
    const BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: 'Chats'),
    const BottomNavigationBarItem(
        icon: Icon(IconBroken.Location), label: 'Users'),
    const BottomNavigationBarItem(
        icon: Icon(IconBroken.Setting), label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(IconBroken.Notification)),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(Icons.brightness_2_outlined)),
              IconButton(
                  onPressed: () {
                    navigateTo(context, const SearchScreen());
                  },
                  icon: const Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) => cubit.changeBottomNavBar(index: index),
            items: bottomNavBarItems,
          ),
        );
      },
    );
  }
}