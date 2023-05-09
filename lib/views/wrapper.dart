import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/utils/loading.dart';
import 'package:voteey/views/auth/signIn.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // DatabaseService databaseService = Get.put(DatabaseService());

  @override
  Widget build(BuildContext context) {
    return SignIn();

  //   return StreamBuilder<User?>(
  //     stream: FirebaseAuth.instance.authStateChanges(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Loading();
  //       } else if (snapshot.hasError) {
  //         return Center(
  //           child: DelegatedText(
  //             text: 'Something went wrong!',
  //             fontSize: 20,
  //           ),
  //         );
  //       } else if (snapshot.hasData) {
  //         // check for the userType (userType == Driver)? DriverHomepage : Homepage
  //         final userId = FirebaseAuth.instance.currentUser!.uid;

  //         databaseService.uid = userId;
  //         return FutureBuilder(
  //           future: databaseService.getUser(userId, 'Users'),
  //           builder: (context, AsyncSnapshot<UserData?> userData) {
  //             if (userData.connectionState == ConnectionState.waiting) {
  //               return const Loading();
  //             } else if (userData.hasError) {
  //               return Center(
  //                 child: DelegatedText(
  //                   text: 'Something went wrong!',
  //                   fontSize: 20,
  //                 ),
  //               );
  //             } else {
  //               if (userData.data!.userType == 'Driver') {
  //                 return const DriverHomePage();
  //               }
  //               return HomePage();
  //             }
  //           },
  //         );
  //       } else {
  //         return const Authenticate();
  //       }
  //     },
  //   );
  }
}
