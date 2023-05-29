import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/routes/routes.dart';
import 'package:voteey/utils/constant.dart';

class CastVote extends StatefulWidget {
  const CastVote({super.key});

  @override
  State<CastVote> createState() => _CastVoteState();
}

class _CastVoteState extends State<CastVote> {
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
                    decoration: BoxDecoration(
                      color: Constants.secondaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              DelegatedText(
                                text: "President",
                                fontSize: 20,
                                fontName: "InterBold",
                                color: Constants.basicColor,
                              ),
                              const Spacer(),
                              DelegatedText(
                                text: "⚫ Ongoing",
                                fontSize: 13,
                                fontName: "InterBold",
                                color: Constants.basicColor,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              DelegatedText(
                                text: "4 Candidate",
                                fontSize: 15,
                                fontName: "InterBold",
                                color: Constants.basicColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: size.height * .63,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Constants.basicColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Color.fromARGB(221, 207, 203, 203),
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  height: size.height * .13,
                                  decoration: BoxDecoration(
                                    color: Constants.basicColor,
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(221, 207, 203, 203),
                                        blurRadius: 1,
                                        offset: Offset(1, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          "assets/comlogo.png",
                                          width: 50,
                                          height: 40,
                                        ),
                                        const SizedBox(width: 10),
                                        DelegatedText(
                                          text: "Emmanuel Richard",
                                          fontSize: 18,
                                          fontName: "InterBold",
                                          color: Constants.tertiaryColor,
                                        ),
                                        const Spacer(),
                                        ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Confirm Vote'),
                                                  content: const Text(
                                                      'Are you sure you want to vote for Emmanuel Richard? '),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('Vote'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Constants.primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          child: DelegatedText(
                                            text: "Vote",
                                            fontSize: 15,
                                            fontName: "InterBold",
                                            color: Constants.basicColor,
                                          ),
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
