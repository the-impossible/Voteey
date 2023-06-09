import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/models/votingCategory.dart';
import 'package:voteey/routes/routes.dart';
import 'package:voteey/services/database.dart';
import 'package:voteey/utils/constant.dart';

class VoteCategory extends StatefulWidget {
  const VoteCategory({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<VoteCategory> createState() => _VoteCategoryState();
}

class _VoteCategoryState extends State<VoteCategory> {
  DatabaseService databaseService = Get.put(DatabaseService());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DelegatedAppBar(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: StreamBuilder<bool>(
                  stream: databaseService.votingStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong! ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      if (snapshot.data!) {
                        return Column(
                          children: [
                            StreamBuilder<List<VotingCategory>>(
                              stream: databaseService.groupCategories(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text(
                                      "Something went wrong! ${snapshot.error}");
                                } else if (snapshot.hasData) {
                                  final categoryList = snapshot.data!;
                                  if (categoryList.isNotEmpty) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: categoryList.length,
                                      itemBuilder: (context, index) {
                                        final votingData = categoryList[index];
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          height: widget.size.height * 0.15,
                                          width: widget.size.width * .9,
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
                                                      text: votingData.posTitle,
                                                      fontSize: 20,
                                                      fontName: "InterBold",
                                                      color:
                                                          Constants.basicColor,
                                                    ),
                                                    const Spacer(),
                                                    DelegatedText(
                                                      text: "⚫ Ongoing",
                                                      fontSize: 13,
                                                      fontName: "InterBold",
                                                      color:
                                                          Constants.basicColor,
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Row(
                                                  children: [
                                                    DelegatedText(
                                                      text:
                                                          "${votingData.candidateNo.toString()} Candidate",
                                                      fontSize: 15,
                                                      fontName: "InterBold",
                                                      color:
                                                          Constants.basicColor,
                                                    ),
                                                    const Spacer(),
                                                    OutlinedButton(
                                                      onPressed: () {
                                                        var data = {
                                                          'posID': votingData.id
                                                              .toString()
                                                        };

                                                        Get.toNamed(
                                                            Routes.castVote,
                                                            parameters: data);
                                                      },
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: const BorderSide(
                                                          color: Constants
                                                              .basicColor,
                                                          width: 1.5,
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child: DelegatedText(
                                                        text: "Vote",
                                                        fontSize: 13,
                                                        fontName: "InterBold",
                                                        color: Constants
                                                            .basicColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: DelegatedText(
                                          text: "No Candidate Record",
                                          fontSize: 20,
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
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
                                text: "Get set voting will start soon!",
                                fontSize: 20,
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
