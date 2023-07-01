import 'package:get/get.dart';
import 'package:voteey/services/database.dart';

class VotingStatusController extends GetxController {

  DatabaseService databaseService = Get.put(DatabaseService());


  Future<bool> getStatus() async {
    return await databaseService.votingStatus().first;
  }

  void processStatus() {
    getStatus();
  }
}
