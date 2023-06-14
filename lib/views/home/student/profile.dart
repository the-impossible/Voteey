import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voteey/components/delegatedForm.dart';
import 'package:voteey/components/delegatedSnackBar.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/routes/routes.dart';
import 'package:voteey/utils/constant.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;

  Future pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      setState(() {
        image = File(pickedFile.path);
        // editProfileController.image = image;
      });
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          delegatedSnackBar("Failed to Capture image: $e", false));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 15, right: 15, top: size.height * .1, bottom: 10),
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
                          Center(
                            child: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 228, 236, 230),
                              maxRadius: 50,
                              minRadius: 50,
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/comlogo.png",
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
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
                        onPressed: () {},
                        child: DelegatedText(
                          text: "Update picture",
                          fontSize: 16,
                          fontName: "InterBold",
                          color: Constants.primaryColor,
                        ),
                      ),
                      DelegatedText(
                        text: "Emmanuel Richard",
                        fontSize: 23,
                        fontName: "InterBold",
                        color: Constants.tertiaryColor,
                      ),
                      const SizedBox(height: 8),
                      DelegatedText(
                        text: "CST20HND0558",
                        fontSize: 18,
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
                      FirebaseAuth.instance.signOut();
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
          ],
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [

        //       const SizedBox(height: 5),
        //       const Divider(),

        //       const Divider(),
        //       const Spacer(),
        //       ListTile(
        //         leading: const Icon(Icons.logout),
        //         title: DelegatedText(
        //           text: "Sign Out",
        //           fontSize: 16,
        //           fontName: "InterBold",
        //           color: Constants.primaryColor,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
