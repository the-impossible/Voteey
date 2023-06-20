import 'dart:convert';
import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedSnackBar.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/controllers/createAccountController.dart';
import 'package:voteey/models/user_data.dart';
import 'package:voteey/services/database.dart';
import 'package:voteey/utils/constant.dart';
import 'package:voteey/utils/title_case.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  CreateAccountController createAccountController =
      Get.put(CreateAccountController());

  DatabaseService databaseService = Get.put(DatabaseService());

  String? filePath;
  String selected = "No selected file";
  String preSelected = "";

  Future _pickCSV() async {
    setState(() {
      selected = "No selected file";
    });
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );

    // if no file is found
    if (result == null) return;

    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    filePath = result.files.first.path!;

    final String extension = path.extension(filePath!);

    if (extension.toLowerCase() == '.csv') {
      final input = File(filePath!).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(const CsvToListConverter())
          .toList();

      createAccountController.fields = fields;

      for (var element in fields) {
        final regNo = element[0].toString().toLowerCase();

        QuerySnapshot snaps = await FirebaseFirestore.instance
            .collection('Users')
            .where("regNo", isEqualTo: regNo)
            .get();
        if (snaps.docs.length != 1) {
          preSelected = "File Selected!";
          setState(() {
            isDisabled = false;
          });
        } else {
          preSelected = "No selected file";
          ScaffoldMessenger.of(Get.context!).showSnackBar(delegatedSnackBar(
              "Invalid CSV! contains existing account", false));
          break;
        }
      }
      setState(() {
        selected = preSelected;
      });
    } else {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Invalid file!", false));
    }

    navigator!.pop(Get.context!);
  }

  void uploadFile() {
    createAccountController.createAccount();
    setState(() {
      isDisabled = true;
      selected = "No selected file";
    });
  }

  bool isDisabled = true;
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
                          horizontal: 20, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DelegatedText(
                            text: selected,
                            fontSize: 15,
                            fontName: "InterBold",
                            color: Constants.basicColor,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * .4,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _pickCSV();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Constants.basicColor,
                                  ),
                                  child: DelegatedText(
                                    fontSize: 15,
                                    text: 'Select File',
                                    color: Constants.tertiaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: size.width * .4,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    (isDisabled)
                                        ? ScaffoldMessenger.of(Get.context!)
                                            .showSnackBar(delegatedSnackBar(
                                                "Error Uploading", false))
                                        : uploadFile();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Constants.basicColor,
                                  ),
                                  child: DelegatedText(
                                    fontSize: 15,
                                    text: 'Upload File',
                                    color: Constants.tertiaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .55,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          StreamBuilder<List<UserData>>(
                            stream: databaseService.getAccounts('std'),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    "Something went wrong! ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                final accountList = snapshot.data!;
                                if (accountList.isNotEmpty) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: accountList.length,
                                    itemBuilder: (context, index) {
                                      final accountData = accountList[index];
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        height: size.height * .13,
                                        decoration: BoxDecoration(
                                          color: Constants.basicColor,
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
                                                    text: accountData.name
                                                        .titleCase(),
                                                    fontSize: 18,
                                                    fontName: "InterBold",
                                                    color:
                                                        Constants.tertiaryColor,
                                                  ),
                                                  const Spacer(),
                                                  FutureBuilder<String?>(
                                                    future: databaseService
                                                        .getImage(
                                                            accountData.id,
                                                            'Users'),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      } else if (snapshot
                                                          .hasData) {
                                                        return ClipOval(
                                                          child: Image.network(
                                                            snapshot.data!,
                                                            height: 50,
                                                            width: 50,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        );
                                                      } else {
                                                        return Image.asset(
                                                          "assets/user.png",
                                                          width: 50,
                                                          height: 40,
                                                        );
                                                      }
                                                    },
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
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 50.0, bottom: 30),
                                          child: SvgPicture.asset(
                                            'assets/noFound.svg',
                                            width: 50,
                                            height: 200,
                                          ),
                                        ),
                                        DelegatedText(
                                          text: "No Student Record",
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
