import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedSnackBar.dart';
import 'package:voteey/services/database.dart';

class ProfileController extends GetxController {
  DatabaseService databaseService = Get.put(DatabaseService());
  File? image;

  Future<void> updateAccount() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      if (image != null) {
        bool status = await databaseService.updateImage(
            image, FirebaseAuth.instance.currentUser!.uid, 'Users');
        if (status) {
          await Future.delayed(const Duration(milliseconds: 3600));
          bool updated = await databaseService
              .updateProfileTime(FirebaseAuth.instance.currentUser!.uid);
          if (updated) {
            ScaffoldMessenger.of(Get.context!).showSnackBar(
                delegatedSnackBar("Profile Updated Successfully", true));
          }
        } else {
          ScaffoldMessenger.of(Get.context!)
              .showSnackBar(delegatedSnackBar("FAILED: update failed", false));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("FAILED: $e", false));
    } finally {
      navigator!.pop(Get.context!);
    }
  }

  Future<void> toggleVoting(bool stats) async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {

        bool status = await databaseService.beginOrEndVoting(stats);

        if (status) {
               ScaffoldMessenger.of(Get.context!).showSnackBar(
                delegatedSnackBar("Voting Status Updated", true));
        } else {
          ScaffoldMessenger.of(Get.context!)
              .showSnackBar(delegatedSnackBar("Failed to update voting status", false));
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("FAILED: $e", false));
    } finally {
      navigator!.pop(Get.context!);
    }
  }
}
