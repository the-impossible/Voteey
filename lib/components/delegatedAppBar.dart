import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/models/user_data.dart';
import 'package:voteey/services/database.dart';
import 'package:voteey/utils/constant.dart';

class DelegatedAppBar extends StatelessWidget {
  const DelegatedAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = Get.put(DatabaseService());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/comlogo.png",
            width: 50,
            height: 40,
          ),
          const SizedBox(width: 5),
          DelegatedText(
            text: "Voteey",
            fontSize: 28,
            fontName: "InterBold",
            color: Constants.primaryColor,
          ),
          const Spacer(),
          StreamBuilder<UserData?>(
            stream: databaseService
                .getUserProfile(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) {
              return StreamBuilder<String?>(
                stream: databaseService.getCurrentUserImage(
                    FirebaseAuth.instance.currentUser!.uid, 'Users'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 228, 236, 230),
                      minRadius: 25,
                      maxRadius: 25,
                      child: ClipOval(
                        child: Image.network(
                          snapshot.data!,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return Image.asset(
                      "assets/user.png",
                      width: 50,
                      height: 40,
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
