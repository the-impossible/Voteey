import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedSnackBar.dart';
import 'package:voteey/models/position_data.dart';
import 'package:voteey/services/database.dart';

class PositionController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getPosition();
  }

  TextEditingController regNoController = TextEditingController();
  DatabaseService databaseService = Get.put(DatabaseService());

  List<Position> positions = [];
  String? selectedPosition;

  Future<void> getPosition() async {
    try {
      positions = await databaseService.getPositions();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("FAILED: $e", false));
    }
  }

  Future<void> applyPosition() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      String regNo = regNoController.text.toLowerCase();
      // Verify user account exists
      bool status = await databaseService.verifyStudent(regNo);
      // Create position
      if (status) {
        // Verify if the the candidate has not been registered
        bool hasApplied = await databaseService.hasApplied(regNo);
        if (!hasApplied) {
          bool isCandidate =
              await databaseService.applyCandidate(regNo, selectedPosition!);

          if (isCandidate) {
            ScaffoldMessenger.of(Get.context!).showSnackBar(
                delegatedSnackBar("Application successful", true));
            regNoController.clear();
            selectedPosition = null;
          } else {
            ScaffoldMessenger.of(Get.context!)
                .showSnackBar(delegatedSnackBar("Application failed", false));
          }
        } else {
          ScaffoldMessenger.of(Get.context!).showSnackBar(delegatedSnackBar(
              "FAILED: Candidate has been registered!", false));
        }
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            delegatedSnackBar("FAILED: Regno don't exist!", false));
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("FAILED: $e", false));
    } finally {
      navigator!.pop(Get.context!);
    }
  }
}
