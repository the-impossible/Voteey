import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voteey/components/delegatedSnackBar.dart';
import 'package:voteey/services/database.dart';
import 'package:voteey/utils/loading.dart';

class LoginController extends GetxController {
  TextEditingController regNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DatabaseService databaseService = Get.put(DatabaseService());

  @override
  void dispose() {
    regNoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "${regNoController.text.trim()}@gmail.com",
          password: passwordController.text.trim());

      regNoController.clear();
      passwordController.clear();

      navigator!.pop(Get.context!);

      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Sign in successful", true));
    } on FirebaseAuthException catch (e) {
      navigator!.pop(Get.context!);
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Invalid login credentials", false));
    }
  }
}
