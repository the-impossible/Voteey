import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/models/all_categories.dart';
import 'package:voteey/models/candidate_details.dart';
import 'package:voteey/models/votingCategory.dart';
import 'package:voteey/routes/routes.dart';
import 'package:voteey/services/database.dart';
import 'package:voteey/utils/constant.dart';
import 'package:voteey/utils/title_case.dart';

class ResultCategory extends StatefulWidget {
  const ResultCategory({super.key});

  @override
  State<ResultCategory> createState() => _ResultCategoryState();
}

class _ResultCategoryState extends State<ResultCategory> {
  DatabaseService databaseService = Get.put(DatabaseService());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              child: Column(
                children: [
                  StreamBuilder<List<CandidateDetail>>(
                    stream: databaseService.winningCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong! ${snapshot.error}");
                      } else if (snapshot.hasData) {
                        final categoryList = snapshot.data!;
                        if (categoryList.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categoryList.length,
                            itemBuilder: (context, index) {
                              final categoryData = categoryList[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                height: size.height * 0.15,
                                width: size.width * .9,
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
                                            text: categoryData.position,
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
                                            text: "Winning : ",
                                            fontSize: 15,
                                            fontName: "InterBold",
                                            color: Constants.basicColor,
                                          ),
                                          DelegatedText(
                                            text: categoryData.name.titleCase(),
                                            fontSize: 15,
                                            fontName: "InterBold",
                                            truncate: true,
                                            color: Constants.basicColor,
                                          ),
                                          const Spacer(),
                                          OutlinedButton(
                                            onPressed: () =>
                                                Get.toNamed(Routes.resultStats),
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                color: Constants.basicColor,
                                                width: 1.5,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: DelegatedText(
                                              text: "Stats",
                                              fontSize: 13,
                                              fontName: "InterBold",
                                              color: Constants.basicColor,
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
                              padding: const EdgeInsets.only(top: 20.0),
                              child: DelegatedText(
                                text: "No Candidate Record",
                                fontSize: 20,
                              ),
                            ),
                          );
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
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
  }
}
