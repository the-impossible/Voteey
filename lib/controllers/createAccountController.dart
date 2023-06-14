import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voteey/components/delegatedSnackBar.dart';
import 'package:voteey/services/database.dart';

class CreateAccountController extends GetxController {
  DatabaseService databaseService = Get.put(DatabaseService());
  final password = '12345678';
  List<List<dynamic>> fields = [];

  Future createAccount() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      if (fields.isNotEmpty) {
        for (var element in fields) {
          final regNo = element[0].toString().toLowerCase().trim();
          final name = element[1].toString().toLowerCase().trim();

          FirebaseApp secondaryApp = await Firebase.initializeApp(
            name: 'SecondaryApp',
            options: Firebase.app().options,
          );

          FirebaseAuth createAuth = FirebaseAuth.instanceFor(app: secondaryApp);

          var user = await createAuth.createUserWithEmailAndPassword(
            email: "$regNo@gmail.com",
            password: password,
          );

          // Create a new user
          await DatabaseService(uid: user.user!.uid)
              .createStudentData(name, regNo, 'std');

          // after creating the account, delete the secondary app
          await secondaryApp.delete();
        }
      }

      navigator!.pop(Get.context!);

      ScaffoldMessenger.of(Get.context!).showSnackBar(
          delegatedSnackBar("Accounts created successfully!", true));
    } on FirebaseAuthException catch (e) {
      navigator!.pop(Get.context!);
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar(e.message.toString(), false));
    }
  }
}
