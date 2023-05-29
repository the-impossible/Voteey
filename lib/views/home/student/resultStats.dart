import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/routes/routes.dart';
import 'package:voteey/utils/constant.dart';

class ResultStats extends StatefulWidget {
  const ResultStats({super.key});

  @override
  State<ResultStats> createState() => _ResultStatsState();
}

class _ResultStatsState extends State<ResultStats> {
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
                  SizedBox(
                    height: size.height * .6,
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
                                  color: (index == 0)
                                      ? Constants.secondaryColor
                                      : Constants.basicColor,
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
                                            color: (index == 0)
                                                ? Constants.basicColor
                                                : Constants.tertiaryColor,
                                          ),
                                          const Spacer(),
                                          Image.asset(
                                            "assets/comlogo.png",
                                            width: 50,
                                            height: 40,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          DelegatedText(
                                            text: "12000 Votes",
                                            fontSize: 13,
                                            fontName: "InterBold",
                                            color: (index == 0)
                                                ? Constants.basicColor
                                                : Constants.tertiaryColor,
                                          ),
                                          const Spacer(),
                                          DelegatedText(
                                            text: (index == 0)
                                                ? "⚫ Winner"
                                                : "⚫ ${getOrdinal(index + 1)}",
                                            fontSize: 13,
                                            fontName: "InterBold",
                                            color: (index == 0)
                                                ? Constants.basicColor
                                                : Constants.tertiaryColor,
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

String getOrdinal(int number) {
  if (number % 100 >= 11 && number % 100 <= 13) {
    return '${number}th';
  } else {
    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }
}
