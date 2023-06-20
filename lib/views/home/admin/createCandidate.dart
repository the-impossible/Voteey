import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedForm.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/controllers/positionController.dart';
import 'package:voteey/controllers/votingStatusController.dart';
import 'package:voteey/routes/routes.dart';
import 'package:voteey/services/database.dart';
import 'package:voteey/utils/constant.dart';
import 'package:voteey/utils/form_validators.dart';

class CreateCandidate extends StatefulWidget {
  const CreateCandidate({super.key});

  @override
  State<CreateCandidate> createState() => _CreateCandidateState();
}

class _CreateCandidateState extends State<CreateCandidate> {
  DatabaseService databaseService = Get.put(DatabaseService());
  PositionController positionController = Get.put(PositionController());
  VotingStatusController votingStatusController = Get.put(VotingStatusController());


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.basicColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DelegatedAppBar(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              height: size.height * 0.06,
                              width: size.width,
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                color: Constants.secondaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: DelegatedText(
                                  text: 'Apply Candidate',
                                  fontSize: 18,
                                  color: Constants.basicColor,
                                ),
                              ),
                            ),
                            delegatedForm(
                              fieldName: 'Candidate RegNo',
                              icon: Icons.person,
                              hintText: 'Enter Candidate RegNo',
                              isSecured: false,
                              validator: FormValidator.validateRegNo,
                              formController:
                                  positionController.regNoController,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.work),
                                  const SizedBox(width: 15),
                                  DelegatedText(
                                    text: "Select Position",
                                    fontSize: 15,
                                    fontName: 'InterMed',
                                  ),
                                ],
                              ),
                            ),
                            const PositionDropdownMenu(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.allCandidate);
                                    },
                                    child: DelegatedText(
                                      text: 'All Registered Candidate',
                                      fontSize: 15,
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    positionController.applyPosition();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Constants.primaryColor,
                                ),
                                child: DelegatedText(
                                  fontSize: 15,
                                  text: 'Apply Position',
                                  color: Constants.basicColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PositionDropdownMenu extends StatefulWidget {
  const PositionDropdownMenu({super.key});

  @override
  State<PositionDropdownMenu> createState() => _PositionDropdownMenuState();
}

class _PositionDropdownMenuState extends State<PositionDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    PositionController positionController = Get.put(PositionController());
    String? position;

    return DropdownButtonFormField<String>(
      validator: FormValidator.validatePosition,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Constants.tertiaryColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: Constants.tertiaryColor,
          ),
        ),
      ),
      value: position,
      hint: const Text('Select Position'),
      onChanged: (String? newValue) {
        setState(() {
          position = newValue!;
          positionController.selectedPosition = position;
        });
      },
      items: positionController.positions
          .map((entries) => DropdownMenuItem<String>(
                value: entries.id.toString(),
                child: Text(entries.title),
              ))
          .toList(),
    );
  }
}
