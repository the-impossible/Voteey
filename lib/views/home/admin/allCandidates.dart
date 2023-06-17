import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/models/all_candidate_data.dart';
import 'package:voteey/models/candidate_details.dart';
import 'package:voteey/services/database.dart';
import 'package:voteey/utils/constant.dart';
import 'package:voteey/utils/title_case.dart';

class AllCandidate extends StatefulWidget {
  const AllCandidate({super.key});

  @override
  State<AllCandidate> createState() => _AllCandidateState();
}

class _AllCandidateState extends State<AllCandidate> {
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
                  SizedBox(
                    height: size.height * .8,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          StreamBuilder<List<CandidateDetail>>(
                            stream: databaseService.getCandidates(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    "Something went wrong! ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                final candidateList = snapshot.data!;
                                if (candidateList.isNotEmpty) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: candidateList.length,
                                    itemBuilder: (context, index) {
                                      final candidateData =
                                          candidateList[index];

                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        height: size.height * .17,
                                        decoration: BoxDecoration(
                                          color: Constants.basicColor,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Constants.primaryColor,
                                              blurRadius: 2,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Constants.primaryColor,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      print("Delete something");
                                                    },
                                                    child: const Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.red,
                                                      size: 25,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  DelegatedText(
                                                    text: candidateData.position
                                                        .titleCase(),
                                                    fontSize: 18,
                                                    fontName: "InterBold",
                                                    color:
                                                        Constants.tertiaryColor,
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
                                                    text: candidateData.name
                                                        .titleCase(),
                                                    fontSize: 18,
                                                    fontName: "InterBold",
                                                    color:
                                                        Constants.tertiaryColor,
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
                                                                  candidateData
                                                                      .image,
                                                                  width: 50,
                                                                  height: 40,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                )),
                                                          );
                                                        }),
                                                    child: Image.network(
                                                      candidateData.image,
                                                      width: 50,
                                                      height: 40,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  DelegatedText(
                                                    text: candidateData.regNo
                                                        .toUpperCase(),
                                                    fontSize: 18,
                                                    fontName: "InterBold",
                                                    color:
                                                        Constants.tertiaryColor,
                                                  ),
                                                  const Spacer(),
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
                                      padding: const EdgeInsets.only(top: 20.0),
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
