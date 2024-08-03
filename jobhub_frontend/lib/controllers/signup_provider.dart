import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhub/models/request/auth/signup_model.dart';
import 'package:jobhub/services/helpers/auth_helper.dart';
import 'package:jobhub/services/helpers/otp_api.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/ui/auth/login.dart';
import 'package:jobhub/views/ui/auth/otp_verify.dart';

class SignUpNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool passwordValidator(String password) {
    if (password.isEmpty) return false;
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

   final signupFormKey = GlobalKey<FormState>(); // Initialize form key

  bool validateAndSave() {
    final form = signupFormKey.currentState;
    if (form != null && form.validate()) { // Check if form is not null
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future<void> upSignup(SignupModel model, String email) async {
    if (!validateAndSave()) return;

    try {
      // Attempt to sign up the user
      print("---entered signupmodel---");
      final signUpSuccess = await AuthHelper.signup(model);
         print("---success from signupmodel---");
      if (signUpSuccess) {
        // If signup is successful, request OTP
        final otpResponse = await APIService.otpLogin(email);
           print("---got otp response---");
        if (otpResponse.data != null) {
          // Navigate to OTP verification page
          Get.offAll(() => otpVerifyPage(
                otpHash: otpResponse.data,
                email: email,
              ),
              transition: Transition.fade,
              duration: const Duration(seconds: 1));
        } else {
          // Handle case when OTP request fails
          Get.snackbar("Error", "Failed to request OTP",
              colorText: Color(kLight.value),
              backgroundColor: Colors.red,
              icon: const Icon(Icons.error));
        }
      } else {
        // Handle case when signup fails
        Get.snackbar("Error", "Failed to sign up",
            colorText: Color(kLight.value),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error));
      }
    } catch (error) {
      // Handle any unexpected errors
      print("Signup Error: $error");
      Get.snackbar("Error", "An unexpected error occurred during signup",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error));
    }
  }
}