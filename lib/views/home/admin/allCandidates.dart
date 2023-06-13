import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/routes/routes.dart';
import 'package:voteey/utils/constant.dart';

class AllCandidate extends StatefulWidget {
  const AllCandidate({super.key});

  @override
  State<AllCandidate> createState() => _AllCandidateState();
}

class _AllCandidateState extends State<AllCandidate> {
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
                  SizedBox(
                    height: size.height * .8,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                height: size.height * .13,
                                decoration: BoxDecoration(
                                  color: Constants.basicColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Constants.primaryColor,
                                      blurRadius: 1,
                                      offset: Offset(2, 3),
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
                                            text: "Prisident",
                                            fontSize: 18,
                                            fontName: "InterBold",
                                            color: Constants.tertiaryColor,
                                          ),
                                        ],
                                      ),
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
