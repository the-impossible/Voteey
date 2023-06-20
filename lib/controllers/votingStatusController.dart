import 'package:get/get.dart';
import 'package:voteey/services/database.dart';

class VotingStatusController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // getStatus();
  }

  DatabaseService databaseService = Get.put(DatabaseService());

  // bool isSwitched = false;

  Future<bool> getStatus() async {
    return await databaseService.votingStatus().first;
  }

  void processStatus() {
    getStatus();
  }
}
