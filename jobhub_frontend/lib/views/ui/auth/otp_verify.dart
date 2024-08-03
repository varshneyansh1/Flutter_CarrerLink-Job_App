import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/services/helpers/otp_api.dart';
import 'package:jobhub/views/ui/auth/login.dart';
import 'package:pinput/pinput.dart';

class otpVerifyPage extends StatefulWidget {
  final String? email;
  final String? otpHash;

  const otpVerifyPage({Key? key, this.email, this.otpHash}) : super(key: key);

  @override
  State<otpVerifyPage> createState() => _otpVerifyPageState();
}

class _otpVerifyPageState extends State<otpVerifyPage> {
  String otpCode = '';

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kOrange.value),
        title: const Text('Email Verification'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          margin: const EdgeInsets.only(top: 40),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 120),
              const Text(
                "Verification",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                child: const Text(
                  "Enter the 4 digit code sent to your email id",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Color(kOrange.value)),
                  ),
                ),
                onCompleted: (pin) {
                  setState(() {
                    otpCode = pin;
                  });
                  if (otpCode.length == 4) {
                    APIService.verifyOTP(
                      widget.email!,
                      widget.otpHash!,
                      otpCode,
                    ).then(
                      (response) {
                        if (response.data != null) {
                          Get.offAll(() => const LoginPage());
                        }
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
