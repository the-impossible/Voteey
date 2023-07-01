import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:voteey/utils/constant.dart';
import 'package:voteey/views/home/student/profile.dart';
import 'package:voteey/views/home/student/resultCategory.dart';
import 'package:voteey/views/home/student/voteCategory.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey bottomNavigationKey = GlobalKey();
  int currentPage = 0;

  // DatabaseService databaseService = Get.put(DatabaseService());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Constants.basicColor,
        body: IndexedStack(
          index: currentPage,
          children: [
            VoteCategory(size: size),
            const ResultCategory(),
            const ProfilePage(),
          ],
        ),
        bottomNavigationBar: FancyBottomNavigation(
          circleColor: Constants.primaryColor,
          inactiveIconColor: Constants.primaryColor,
          textColor: Constants.primaryColor,
          tabs: [
            TabData(
              iconData: Icons.how_to_vote_rounded,
              title: "Vote",
            ),
            TabData(
              iconData: Icons.dashboard,
              title: "Result",
            ),
            TabData(iconData: Icons.person, title: "Profile")
          ],
          initialSelection: 0,
          key: bottomNavigationKey,
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          },
        ),
      ),
    );
  }
}
