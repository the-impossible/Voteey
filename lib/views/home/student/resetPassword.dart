import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteey/components/delegatedAppBar.dart';
import 'package:voteey/components/delegatedForm.dart';
import 'package:voteey/components/delegatedSnackBar.dart';
import 'package:voteey/components/delegatedText.dart';
import 'package:voteey/controllers/resetPasswordController.dart';
import 'package:voteey/utils/constant.dart';
import 'package:voteey/utils/form_validators.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  ResetPasswordController resetPasswordController =
      Get.put(ResetPasswordController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.basicColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DelegatedAppBar(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    DelegatedText(
                      text: "Reset Password",
                      fontSize: 18,
                      fontName: "InterBold",
                      color: Constants.primaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Container(
                        height: size.height * .7,
                        width: size.width,
                        margin: const EdgeInsets.only(bottom: 15, top: 8),
                        decoration: BoxDecoration(
                          color: Constants.basicColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(221, 207, 203, 203),
                              blurRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: delegatedForm(
                                      fieldName: 'Current Password',
                                      icon: Icons.person,
                                      hintText: 'Enter your current password',
                                      validator: FormValidator.validatePassword,
                                      formController:
                                          resetPasswordController.oldPass,
                                      isSecured: false,
                                    ),
                                  ),
                                  delegatedForm(
                                    fieldName: 'New Password',
                                    icon: Icons.lock,
                                    hintText: 'Enter your New password',
                                    isSecured: true,
                                    validator: FormValidator.validatePassword,
                                    formController:
                                        resetPasswordController.newPass,
                                    // formController: loginController.passwordController,
                                  ),
                                  delegatedForm(
                                    fieldName: 'Confirm Password',
                                    icon: Icons.lock,
                                    hintText: 'Confirm the new password',
                                    isSecured: true,
                                    validator: FormValidator.validatePassword,
                                    formController:
                                        resetPasswordController.newPass2,
                                  ),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (resetPasswordController
                                                  .newPass.text ==
                                              resetPasswordController
                                                  .newPass2.text) {
                                            resetPasswordController
                                                .updatePassword();
                                          } else {
                                            ScaffoldMessenger.of(Get.context!)
                                                .showSnackBar(
                                              delegatedSnackBar(
                                                  "FAILED: New and Confirm password don't match",
                                                  false),
                                            );
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Constants.primaryColor,
                                      ),
                                      child: DelegatedText(
                                        fontSize: 15,
                                        text: 'Reset Password',
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
