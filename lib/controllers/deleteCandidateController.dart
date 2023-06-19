import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedSnackBar.dart';
import 'package:voteey/services/database.dart';

class DeleteCandidateController extends GetxController {
  DatabaseService databaseService = Get.put(DatabaseService());
  String? canID;

  Future<void> deleteAccount() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      bool status = await databaseService.deleteCandidate(canID!);

      if (status) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            delegatedSnackBar("Candidate Deleted Successfully", true));
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            delegatedSnackBar("Failed to delete candidate!", false));
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("FAILED: $e", false));
    } finally {
      navigator!.pop(Get.context!);
    }
  }
}
