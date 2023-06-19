import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedSnackBar.dart';
import 'package:voteey/services/database.dart';

class CastVoteController extends GetxController {
  TextEditingController regNoController = TextEditingController();
  DatabaseService databaseService = Get.put(DatabaseService());

  String? canID;
  String? posID;

  Future<void> castVote() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {

      bool status = await databaseService.castVote(
          FirebaseAuth.instance.currentUser!.uid, posID!, canID!);

      if (status) {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(delegatedSnackBar("Vote casted!", true));
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(delegatedSnackBar(
            "FAILED: vote might have been casted before!", false));
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("FAILED: $e", false));
    } finally {
      navigator!.pop(Get.context!);
    }
  }
}
