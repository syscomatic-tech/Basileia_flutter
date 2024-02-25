import 'dart:async';
import "dart:convert";
import 'package:http/http.dart' as http;

class AuthClient {
  var BaseURL = "https://api.zahedhasan.com/api/v1";
  var RequestHeader = {"Content-Type": "application/json"};
  var jwt_token = "";
//Login API calling

  Future<String> LoginRequest(String Email, String Password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$BaseURL/auth/user/signin'));
    request.body = json.encode({"email": Email, "password": Password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode < 300) {
      print(await response.stream.bytesToString());

      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
      //final outp = jsonDecode(await response.stream.bytesToString());
      return await response.stream.bytesToString();
    }
  }

// Registration API

  Future<bool> RegistrationRequest(String FirstName, String LastName,
      String Email, String Role, String pass) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('$BaseURL/auth/admin/register'));

    request.body = jsonEncode({
      "firstName": FirstName,
      "lastName": LastName,
      "email": Email,
      "role": Role,
      "password": pass
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode < 300) {
      return true;
    } else {
      print(await response.stream.bytesToString());

      print(await response.reasonPhrase);
      return false;
    }
  }

// Verify OTP Request
  Future<bool> VerifyOTPRequest(String Email, String OTP) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://api.zahedhasan.com/api/v1/auth/otp/verify'));
    request.body = json.encode({"email": Email, "otp": OTP});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode < 300) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future<bool> OTPResend(String Email) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$BaseURL/auth/otp/resend'));
    request.body = '''{\n    "email":"$Email"\n}''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode < 300) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future<Map> Refresh() async {
    var request = http.Request('GET', Uri.parse('$BaseURL/auth/refresh'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode < 300) {
      print(await response.stream.bytesToString());
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      return jsonResponse;
    } else {
      print(response.reasonPhrase);
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      return jsonResponse;
    }
  }
}
