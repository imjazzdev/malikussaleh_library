import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malikussaleh_library/views/mahasiswa/home.dart';
import 'package:malikussaleh_library/views/mahasiswa/profile.dart';
import 'package:malikussaleh_library/views/mahasiswa/search.dart';
import 'package:malikussaleh_library/views/signin.dart';
import 'package:malikussaleh_library/views/signup.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../constants/constant.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  // bool isTapSearchButton = false;
  final controller = PersistentTabController(initialIndex: 0);

  List<Widget> _screen() {
    return [
      const HomeMahasiswaPage(),
      const SearchMahasiswaPage(),
      const Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.search,
          color: Colors.transparent,
        ),
        // activeColorPrimary: Colors.blue,
        // inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  _buildScreen() {
    return PersistentTabView(
      context,
      controller: controller,
      screens: _screen(),
      items: _navBarItems(),
      navBarHeight: 45,
      backgroundColor: Colors.white,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      navBarStyle: NavBarStyle.style12,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        splashColor: Colors.amber.withOpacity(0.25),
        focusColor: Colors.amber.withOpacity(0.25),
        hoverColor: Colors.amber.withOpacity(0.25),
        onPressed: () {
          controller.index = 1;
        },
        child: const Icon(
          CupertinoIcons.search,
          size: 33,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
