import 'package:get/get.dart';
import 'package:voteey/services/database.dart';

class VoteStatusController extends GetxController {
  DatabaseService databaseService = Get.put(DatabaseService());

  final RxBool _isLive = false.obs;
  bool _isListening = false;

  RxBool get isLive => _isLive;
  bool get isListening => _isListening;

  void fetchVotingStatus() {
    databaseService.votingStatus().listen((status) {
      if (!_isListening && status) {
        _isListening =
            true; // Set the flag to true to indicate that we are now listening
        _isLive.value = status;
      } else if (_isListening && _isLive.value && !status) {
        _isListening = false; // Set the flag to false to stop listening
      }
    });
  }
}
