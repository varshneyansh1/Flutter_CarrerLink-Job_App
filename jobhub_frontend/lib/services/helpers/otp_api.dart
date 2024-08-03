import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:jobhub/models/response/auth/otp_login_res.dart';

class APIService {
  static var client = https.Client();

  static Future<OtpLoginResModel> otpLogin(String email) async {
    var url = Uri.https("flutter-carrerlink.onrender.com", "/api/otp-login");

    try {
      var response = await client.post(url,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({"email": email}));

      print("Response body: ${response.body}");

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return otpLoginResModel(response.body);
      } else {
        throw Exception('Empty response body or non-200 status code');
      }
    } catch (e) {
      // Handle exceptions
      print("Error occurred: $e");
      throw Exception('Failed to fetch data');
    }
  }

  static Future<OtpLoginResModel> verifyOTP(
      String email, String otpHash, String otpCode) async {
    var url = Uri.https("flutter-carrerlink.onrender.com", "/api/otp-verify");

    try {
      var response = await client.post(url,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({
            "email": email,
            "otp": otpCode,
            "hash": otpHash,
          }));

      print("Response body: ${response.body}");

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return otpLoginResModel(response.body);
      } else {
        throw Exception('Empty response body or non-200 status code');
      }
    } catch (e) {
      // Handle exceptions
      print("Error occurred: $e");
      throw Exception('Failed to fetch data');
    }
  }
}
