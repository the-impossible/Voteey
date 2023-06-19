import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedSnackBar.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/controllers/logoutController.dart';
import 'package:voteey/controllers/profileController.dart';
import 'package:voteey/routes/routes.dart';
import 'package:voteey/services/database.dart';
import 'package:voteey/utils/constant.dart';
import 'package:voteey/utils/title_case.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController profileController = Get.put(ProfileController());
  LogoutController logoutController = Get.put(LogoutController());
  DatabaseService databaseService = Get.put(DatabaseService());
  File? image;

  Future pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      setState(() {
        image = File(pickedFile.path);
        profileController.image = image;
      });
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          delegatedSnackBar("Failed to Capture image: $e", false));
    }
  }

  bool isSwitched = false;
  var textValue = 'Start Voting';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        profileController.toggleVoting(value);
        isSwitched = true;
        textValue = 'End Voting';
      });
    } else {
      setState(() {
        profileController.toggleVoting(value);

        isSwitched = false;
        textValue = 'Start Voting';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const DelegatedAppBar(),
            Padding(
              padding: EdgeInsets.only(
                  left: 15, right: 15, top: size.height * .05, bottom: 10),
              child: Container(
                height: size.height * .43,
                width: size.width,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Constants.basicColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(221, 207, 203, 203),
                      blurRadius: 1,
                      offset: Offset(1, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          StreamBuilder<String?>(
                            stream: databaseService.getCurrentUserImage(
                                FirebaseAuth.instance.currentUser!.uid,
                                'Users'),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    "Something went wrong! ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                return Center(
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 228, 236, 230),
                                    maxRadius: 50,
                                    minRadius: 50,
                                    child: ClipOval(
                                      child: (image != null)
                                          ? Image.file(
                                              image!,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              snapshot.data!,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                              // colorBlendMode: BlendMode.darken,
                                            ),
                                    ),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 60,
                              left: 80,
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  pickImage();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Constants.basicColor,
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Constants.primaryColor,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          if (image != null) {
                            profileController.updateAccount();
                            image = null;
                          } else {
                            ScaffoldMessenger.of(Get.context!).showSnackBar(
                              delegatedSnackBar(
                                  "FAILED: No image selected", false),
                            );
                          }
                        },
                        child: DelegatedText(
                          text: "Update picture",
                          fontSize: 16,
                          fontName: "InterBold",
                          color: Constants.primaryColor,
                        ),
                      ),
                      DelegatedText(
                        text: databaseService.userData!.name.titleCase(),
                        fontSize: 23,
                        fontName: "InterBold",
                        color: Constants.tertiaryColor,
                      ),
                      const SizedBox(height: 8),
                      DelegatedText(
                        text: databaseService.userData!.regNo.toUpperCase(),
                        fontSize: 18,
                        fontName: "InterBold",
                        color: Constants.tertiaryColor,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          DelegatedText(
                            text:
                                "Year Joined ${databaseService.userData!.created!.year.toString()}",
                            fontSize: 15,
                            fontName: "InterBold",
                            color: Constants.tertiaryColor,
                          ),
                          const Spacer(),
                          DelegatedText(
                            text: (databaseService.userData!.type == 'adm')
                                ? "⚫ Admin"
                                : "⚫ Student",
                            fontSize: 15,
                            fontName: "InterBold",
                            color: Constants.primaryColor,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.resetPassword),
                    child: DelegatedText(
                      text: "Reset Password",
                      fontSize: 16,
                      fontName: "InterBold",
                      color: Constants.primaryColor,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Confirm Logout'),
                            content:
                                const Text('Are you sure you want to logout? '),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  logoutController.signOut();
                                },
                                child: const Text('Log out'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: DelegatedText(
                      text: "Sign Out",
                      fontSize: 16,
                      fontName: "InterBold",
                      color: Constants.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            (databaseService.userData!.type == 'adm')
                ? Transform.scale(
                    scale: 1.5,
                    child: Switch(
                      value: isSwitched,
                      onChanged: toggleSwitch,
                      activeColor: Constants.primaryColor,
                    ),
                  )
                : const Text(''),
            (databaseService.userData!.type == 'adm')
                ? DelegatedText(text: textValue, fontSize: 20)
                : const Text(''),
          ],
        ),
      ),
    );
  }
}
