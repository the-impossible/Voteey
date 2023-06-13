import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedForm.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/routes/routes.dart';
import 'package:voteey/utils/constant.dart';

class CreateCandidate extends StatefulWidget {
  const CreateCandidate({super.key});

  @override
  State<CreateCandidate> createState() => _CreateCandidateState();
}

class _CreateCandidateState extends State<CreateCandidate> {
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
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            children: [
                              const Icon(Icons.person),
                              const SizedBox(width: 15),
                              DelegatedText(
                                text: "Select student",
                                fontSize: 15,
                                fontName: 'InterMed',
                              ),
                            ],
                          ),
                        ),
                        const StudentDropdownMenu(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
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
                              Get.toNamed(Routes.adminHome);
                            },
                            // onPressed: () => loginController.signIn(),
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
          ],
        ),
      ),
    );
  }
}

List<String> regNo = [
  'CST20HND0558',
  'CST20HND0559',
  'CST20HND0550',
  'CST20HND0551',
  'CST20HND0552',
];

List<String> positions = [
  'President',
  'Sec. Gen',
  'Welfare Director',
  'Fin. Sec',
  'Auditor',
];

class StudentDropdownMenu extends StatefulWidget {
  const StudentDropdownMenu({super.key});

  @override
  State<StudentDropdownMenu> createState() => _StudentDropdownMenuState();
}

class _StudentDropdownMenuState extends State<StudentDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    String? student;

    return DropdownButtonFormField<String>(
      // validator: FormValidator.validatestudent,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: Constants.primaryColor,
          ),
        ),
      ),
      value: student,
      hint: const Text('Select Student'),
      onChanged: (String? newValue) {
        setState(() {
          student = newValue!;
        });
      },
      items: regNo
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
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
    String? position;

    return DropdownButtonFormField<String>(
      // validator: FormValidator.validateLocation,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.primaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: Constants.primaryColor,
          ),
        ),
      ),
      value: position,
      hint: const Text('Select Position'),
      onChanged: (String? newValue) {
        setState(() {
          position = newValue!;
        });
      },
      items: positions
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
    );
  }
}
