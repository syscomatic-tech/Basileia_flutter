import 'dart:async';
import "dart:convert";
import 'dart:ffi';
import 'package:basileia/Style/style.dart';
import 'package:http/http.dart' as http;

var jwt_token = "";
var userId = "";
var userFullname = "";
var userEmail = "";

class AuthClient {
  var BaseURL = "https://api.zahedhasan.com/api/v1";
  var RequestHeader = {"Content-Type": "application/json"};
  var jwt_token = "";
//Login API calling
  Future<String> getUserInfo(String userID) async {
    var request = http.Request('GET', Uri.parse('$BaseURL/auth/$userID'));
    var headers = {'Authorization': 'Bearer $jwt_token'};
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode < 300) {
      return await response.stream.bytesToString();
    } else {
      return await response.stream.bytesToString();
    }
  }

  Future<String> LoginRequest(String Email, String Password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$BaseURL/auth/user/signin'));
    request.body = json.encode({"email": Email, "password": Password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode < 300) {
      final resp = json.decode(await response.stream.bytesToString());

      jwt_token = resp["accessToken"];
      userId = resp["user"]["_id"];
      // final userInfo = json.decode(await getUserInfo(userId));
      // userFullname = userInfo["firstName"] + " " + userInfo["lastName"];
      userFullname = resp["user"]["email"];
      return resp["accessToken"];
    } else {
      print(response.reasonPhrase);
      var outp = await response.stream.bytesToString();
      return outp;
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

class SocialClient {
  final BaseUrl = "https://api.zahedhasan.com/api/v1";
  var RequestHeader = {"Content-Type": "application/json"};

  Future<dynamic> get_users() async {
    var headers = {
      'Authorization': 'Bearer $jwt_token',
      "Content-Type": "application/json"
    };
    var request = http.Request('GET', Uri.parse('$BaseUrl/auth/getAllUsers'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode < 300) {
      final obj_resp = json.decode(await response.stream.bytesToString());
      SuccessToast(obj_resp["message"]);
      final users = obj_resp["allUsers"];
      print(response.stream.bytesToString());
      return users;
    } else {
      print(response.reasonPhrase);
      final obj_resp = json.decode(await response.stream.bytesToString());
      return obj_resp;
    }
  }
}
