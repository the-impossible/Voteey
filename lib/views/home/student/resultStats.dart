import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/models/result_stats.dart';
import 'package:voteey/models/votingCategory.dart';
import 'package:voteey/services/database.dart';
import 'package:voteey/utils/constant.dart';
import 'package:voteey/utils/title_case.dart';

class ResultStats extends StatefulWidget {
  const ResultStats({super.key});

  @override
  State<ResultStats> createState() => _ResultStatsState();
}

class _ResultStatsState extends State<ResultStats> {
  DatabaseService databaseService = Get.put(DatabaseService());
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
                  FutureBuilder<VotingCategory?>(
                    future: databaseService
                        .positionCategories(Get.parameters['posID']!),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong! ${snapshot.error}");
                      } else if (snapshot.hasData) {
                        final positionData = snapshot.data!;
                        return Container(
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
                                      text: positionData.posTitle,
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
                                      text:
                                          "${positionData.candidateNo.toString()} Candidate",
                                      fontSize: 15,
                                      fontName: "InterBold",
                                      color: Constants.basicColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: size.height * .6,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          StreamBuilder<List<ResultDetails>>(
                            stream: databaseService
                                .resultStatistics(Get.parameters['posID']!),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    "Something went wrong! ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                final resultData = snapshot.data!;

                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: resultData.length,
                                    itemBuilder: (context, index) {
                                      final resultDetails = resultData[index];
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
                                              color: Color.fromARGB(
                                                  221, 207, 203, 203),
                                              blurRadius: 1,
                                              offset: Offset(1, 3),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  DelegatedText(
                                                    text: resultDetails.name
                                                        .titleCase(),
                                                    truncate: true,
                                                    fontSize: 18,
                                                    fontName: "InterBold",
                                                    color: (index == 0)
                                                        ? Constants.basicColor
                                                        : Constants
                                                            .tertiaryColor,
                                                  ),
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap: () => showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            content: SizedBox(
                                                                height:
                                                                    size.height *
                                                                        .5,
                                                                child: Image
                                                                    .network(
                                                                  resultDetails
                                                                      .image,
                                                                  width: 50,
                                                                  height: 40,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                )),
                                                          );
                                                        }),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              228, 236, 230),
                                                      minRadius: 25,
                                                      maxRadius: 25,
                                                      child: ClipOval(
                                                        child: Image.network(
                                                          resultDetails.image,
                                                          height: 40,
                                                          width: 40,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  DelegatedText(
                                                    text:
                                                        "${resultDetails.votes} Vote",
                                                    fontSize: 13,
                                                    fontName: "InterBold",
                                                    color: (index == 0)
                                                        ? Constants.basicColor
                                                        : Constants
                                                            .tertiaryColor,
                                                  ),
                                                  const Spacer()
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                return const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
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
