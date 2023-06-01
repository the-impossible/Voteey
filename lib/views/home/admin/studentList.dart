import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/routes/routes.dart';
import 'package:voteey/utils/constant.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.basicColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DelegatedAppBar(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.15,
                    width: size.width,
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Constants.secondaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DelegatedText(
                            text: "No selected file",
                            fontSize: 15,
                            fontName: "InterBold",
                            color: Constants.basicColor,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * .4,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.adminHome);
                                  },
                                  // onPressed: () => loginController.signIn(),
                                  style: ElevatedButton.styleFrom(
                                    primary: Constants.basicColor,
                                  ),
                                  child: DelegatedText(
                                    fontSize: 15,
                                    text: 'Select File',
                                    color: Constants.tertiaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: size.width * .4,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.adminHome);
                                  },
                                  // onPressed: () => loginController.signIn(),
                                  style: ElevatedButton.styleFrom(
                                    primary: Constants.basicColor,
                                  ),
                                  child: DelegatedText(
                                    fontSize: 15,
                                    text: 'Upload File',
                                    color: Constants.tertiaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .55,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                height: size.height * .13,
                                decoration: BoxDecoration(
                                  color: Constants.basicColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(221, 207, 203, 203),
                                      blurRadius: 1,
                                      offset: Offset(1, 3),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          DelegatedText(
                                            text: "Emmanuel Richard",
                                            fontSize: 18,
                                            fontName: "InterBold",
                                            color: Constants.tertiaryColor,
                                          ),
                                          const Spacer(),
                                          Image.asset(
                                            "assets/comlogo.png",
                                            width: 50,
                                            height: 40,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
