import 'package:get/get.dart';
import 'package:voteey/views/splashScreen.dart';

class Routes {
  static String splash = '/';
  static String signIn = '/signIn';
  static String signUp = '/signUp';
}

bool isLogin = true;

final getPages = [
  GetPage(
    name: Routes.splash,
    page: () => const Splash(),
  ),
];
