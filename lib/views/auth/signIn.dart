import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedForm.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/routes/routes.dart';
import 'package:voteey/utils/constant.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.basicColor,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 50),
                    child: Image.asset(
                      "assets/logo.png",
                      width: 150,
                      height: 130,
                    ),
                  ),
                  const delegatedForm(
                    fieldName: 'Reg. No',
                    icon: Icons.person,
                    hintText: 'Enter your registration number',
                    // formController: loginController.emailController,
                    isSecured: false,
                  ),
                  const delegatedForm(
                    fieldName: 'Password',
                    icon: Icons.lock,
                    hintText: 'Enter your password',
                    isSecured: true,
                    // formController: loginController.passwordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: DelegatedText(
                            text: 'Forget password?',
                            fontSize: 15,
                            color: Constants.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.studHome);
                      },
                      // onPressed: () => loginController.signIn(),
                      style: ElevatedButton.styleFrom(
                        primary: Constants.primaryColor,
                      ),
                      child: DelegatedText(
                        fontSize: 15,
                        text: 'Sign In',
                        color: Constants.basicColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
