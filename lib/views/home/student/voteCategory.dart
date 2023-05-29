import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/routes/routes.dart';
import 'package:voteey/utils/constant.dart';

class VoteCategory extends StatelessWidget {
  const VoteCategory({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

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
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
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
                                  const Spacer(),
                                  OutlinedButton(
                                    onPressed: () =>
                                        Get.toNamed(Routes.castVote),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Constants.basicColor,
                                        width: 1.5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: DelegatedText(
                                      text: "Vote",
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
