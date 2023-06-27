import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/navigationDrawer.dart';
import 'package:voteey/utils/constant.dart';
import 'package:voteey/views/home/admin/createCandidate.dart';
import 'package:voteey/views/home/admin/studentList.dart';
import 'package:voteey/views/home/student/profile.dart';
import 'package:voteey/views/home/student/resultCategory.dart';
import 'package:voteey/views/home/student/resultStats.dart';
import 'package:voteey/views/home/student/voteCategory.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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
          children: const [
            StudentList(),
            ResultCategory(),
            CreateCandidate(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: FancyBottomNavigation(
          circleColor: Constants.primaryColor,
          inactiveIconColor: Constants.primaryColor,
          textColor: Constants.primaryColor,
          tabs: [
            TabData(
              iconData: Icons.people,
              title: "Students",
            ),
            TabData(
              iconData: Icons.dashboard,
              title: "Result",
            ),
            TabData(iconData: Icons.people, title: "Candidates"),
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
