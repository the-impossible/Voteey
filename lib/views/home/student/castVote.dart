import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/controllers/castVoteController.dart';
import 'package:voteey/models/candidate_details.dart';
import 'package:voteey/models/votingCategory.dart';
import 'package:voteey/routes/routes.dart';
import 'package:voteey/services/database.dart';
import 'package:voteey/utils/constant.dart';
import 'package:voteey/utils/title_case.dart';

class CastVote extends StatefulWidget {
  const CastVote({super.key});

  @override
  State<CastVote> createState() => _CastVoteState();
}

class _CastVoteState extends State<CastVote> {
  DatabaseService databaseService = Get.put(DatabaseService());
  CastVoteController castVoteController = Get.put(CastVoteController());

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
              child: SizedBox(
                height: size.height * .8,
                child: SingleChildScrollView(
                  child: StreamBuilder<bool>(
                      stream: databaseService.votingStatus(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              "Something went wrong! ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          if (snapshot.data!) {
                            return Column(
                              children: [
                                FutureBuilder<VotingCategory?>(
                                  future: databaseService.positionCategories(
                                      Get.parameters['posID']!),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text(
                                          "Something went wrong! ${snapshot.error}");
                                    } else if (snapshot.hasData) {
                                      final positionData = snapshot.data!;
                                      return Container(
                                        height: size.height * 0.15,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          color: Constants.secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    }
                                  },
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
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
                                          FutureBuilder<
                                              List<CandidateDetail?>?>(
                                            future: databaseService
                                                .allCandidateByPos(
                                                    Get.parameters['posID']!),
                                            builder: (context, snap) {
                                              if (snap.hasError) {
                                                return Text(
                                                    "Something went wrong! ${snap.error}");
                                              } else if (snap.hasData) {
                                                final canList = snap.data!;
                                                return ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: canList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final canData =
                                                        canList[index];

                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      height: size.height * .13,
                                                      decoration: BoxDecoration(
                                                        color: Constants
                                                            .basicColor,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    221,
                                                                    207,
                                                                    203,
                                                                    203),
                                                            blurRadius: 1,
                                                            offset:
                                                                Offset(1, 3),
                                                          ),
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () =>
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          contentPadding:
                                                                              EdgeInsets.zero,
                                                                          content: SizedBox(
                                                                              height: size.height * .5,
                                                                              child: Image.network(
                                                                                canData!.image,
                                                                                width: 50,
                                                                                height: 40,
                                                                                fit: BoxFit.contain,
                                                                              )),
                                                                        );
                                                                      }),
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    Color.fromARGB(
                                                                        255,
                                                                        228,
                                                                        236,
                                                                        230),
                                                                minRadius: 25,
                                                                maxRadius: 25,
                                                                child: ClipOval(
                                                                  child: Image
                                                                      .network(
                                                                    canData!
                                                                        .image,
                                                                    height: 40,
                                                                    width: 40,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            DelegatedText(
                                                              text: canData.name
                                                                  .titleCase(),
                                                              fontSize: 18,
                                                              fontName:
                                                                  "InterBold",
                                                              color: Constants
                                                                  .tertiaryColor,
                                                              truncate: true,
                                                            ),
                                                            const Spacer(),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          'Confirm Vote'),
                                                                      content: Text(
                                                                          'Are you sure you want to vote for ${canData.name.titleCase()}? '),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text('Cancel'),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            castVoteController.canID =
                                                                                canData.id;
                                                                            castVoteController.posID =
                                                                                Get.parameters['posID']!;
                                                                            Navigator.pop(context);
                                                                            castVoteController.castVote();
                                                                          },
                                                                          child:
                                                                              const Text('Vote'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                primary: Constants
                                                                    .primaryColor,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                              ),
                                                              child:
                                                                  DelegatedText(
                                                                text: "Vote",
                                                                fontSize: 15,
                                                                fontName:
                                                                    "InterBold",
                                                                color: Constants
                                                                    .basicColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                return const Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50.0, bottom: 30),
                                    child: SvgPicture.asset(
                                      'assets/notStarted.svg',
                                      width: 50,
                                      height: 200,
                                    ),
                                  ),
                                  DelegatedText(
                                    text: "Get set!",
                                    fontSize: 20,
                                  ),
                                ],
                              ),
                            );
                          }
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
