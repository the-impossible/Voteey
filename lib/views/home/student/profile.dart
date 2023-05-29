import 'package:flutter/material.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/utils/constant.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/comlogo.png",
                width: 60,
                height: 60,
              ),
              DelegatedText(
                text: "Emmanuel Richard",
                fontSize: 20,
                fontName: "InterBold",
                color: Constants.tertiaryColor,
              ),
              const SizedBox(height: 5),
              DelegatedText(
                text: "CST20HND0558",
                fontSize: 15,
                fontName: "InterBold",
                color: Constants.tertiaryColor,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  DelegatedText(
                    text: "Year Joined 2023",
                    fontSize: 15,
                    fontName: "InterBold",
                    color: Constants.tertiaryColor,
                  ),
                  const Spacer(),
                  DelegatedText(
                    text: "⚫ Active",
                    fontSize: 15,
                    fontName: "InterBold",
                    color: Constants.primaryColor,
                  )
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.how_to_vote),
                title: DelegatedText(
                  text: "Vote",
                  fontSize: 16,
                  fontName: "InterBold",
                  color: Constants.tertiaryColor,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard),
                title: DelegatedText(
                  text: "Results",
                  fontSize: 16,
                  fontName: "InterBold",
                  color: Constants.tertiaryColor,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: DelegatedText(
                  text: "Reset Password",
                  fontSize: 16,
                  fontName: "InterBold",
                  color: Constants.tertiaryColor,
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: DelegatedText(
                  text: "Sign Out",
                  fontSize: 16,
                  fontName: "InterBold",
                  color: Constants.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
