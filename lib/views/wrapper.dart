import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/controllers/positionController.dart';
import 'package:voteey/models/user_data.dart';
import 'package:voteey/services/database.dart';
import 'package:voteey/utils/loading.dart';
import 'package:voteey/views/auth/signIn.dart';
import 'package:voteey/views/home/admin/adminHome.dart';
import 'package:voteey/views/home/student/home.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  DatabaseService databaseService = Get.put(DatabaseService());
  PositionController positionController = Get.put(PositionController());

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return Center(
            child: DelegatedText(
              text: 'Something went wrong!',
              fontSize: 20,
            ),
          );
        } else if (snapshot.hasData) {
          // check for the userType (userType == std)? stdHomepage : admHomepage
          final userId = FirebaseAuth.instance.currentUser!.uid;
          databaseService.uid = userId;

          return FutureBuilder(
            future: databaseService.getUser(userId),
            builder: (context, AsyncSnapshot<UserData?> userData) {
              if (userData.connectionState == ConnectionState.waiting) {
                return const Loading();
              } else if (userData.hasError) {
                return Center(
                  child: DelegatedText(
                    text: 'Something went wrong!',
                    fontSize: 20,
                  ),
                );
              } else {
                if (userData.data!.type == 'std') {
                  return HomePage();
                }
                return AdminHomePage();
              }
            },
          );
        } else {
          return SignIn();
        }
      },
    );
  }
}
