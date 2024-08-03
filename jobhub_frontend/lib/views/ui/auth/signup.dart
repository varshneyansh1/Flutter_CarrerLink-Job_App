import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/auth/signup_model.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/auth/login.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(
      builder: (context, signupNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              text: "Sign Up",
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.arrow_left),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: signupNotifier.signupFormKey,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const HeightSpacer(size: 50),
                  ReusableText(
                      text: "Hello, Welcome!",
                      style: appstyle(30, Color(kDark.value), FontWeight.w600)),
                  ReusableText(
                      text: "Fill the details to signup for an account",
                      style: appstyle(
                          16, Color(kDarkGrey.value), FontWeight.w600)),
                  const HeightSpacer(size: 50),
                  CustomTextField(
                    controller: name,
                    keyboardType: TextInputType.text,
                    hintText: "Full name",
                    validator: (name) {
                      if (name!.isEmpty) {
                        return "Please enter your name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email",
                    validator: (email) {
                      if (email!.isEmpty || !email.contains("@")) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: password,
                    keyboardType: TextInputType.text,
                    hintText: "Password",
                    obscureText: signupNotifier.obscureText,
                    validator: (password) {
                      if (password!.isEmpty || password.length < 8) {
                        return "Please enter a valid password with at least one uppercase, one lowercase, one digit, a special character and length of 8 characters";
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        signupNotifier.obscureText =
                            !signupNotifier.obscureText;
                      },
                      child: Icon(
                        signupNotifier.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(kDark.value),
                      ),
                    ),
                  ),
                  const HeightSpacer(size: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.offAll(() => const LoginPage());
                      },
                      child: ReusableText(
                          text: "Login",
                          style: appstyle(
                              14, Color(kDark.value), FontWeight.w500)),
                    ),
                  ),
                  const HeightSpacer(size: 50),
                  CustomButton(
                    onTap: () {
                      signupNotifier.upSignup(
                        SignupModel(
                          username: name.text,
                          email: email.text,
                          password: password.text,
                        ),
                        email.text,
                      );
                    },
                    text: "Sign Up",
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}