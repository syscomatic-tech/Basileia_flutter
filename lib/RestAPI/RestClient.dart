import 'dart:async';
import "dart:convert";
import 'dart:io';
import 'package:basileia/Style/style.dart';
import 'package:basileia/RestAPI/social.dart';
import 'package:http/http.dart' as http;

var jwt_token = "";
var userId = "";
var userFullname = "";
var userEmail = "";

class AuthClient {
  var BaseURL = "https://api.zahedhasan.com/api/v1";
  var RequestHeader = {"Content-Type": "application/json"};
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
      final userInfo = json.decode(await getUserInfo(userId));
       userFullname = userInfo["firstName"] + " " + userInfo["lastName"];
      userEmail = resp["user"]["email"];
      return resp["accessToken"];
    } else {
      print(response.reasonPhrase);
      var outp = await response.stream.bytesToString();
      return "Error " + outp;
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

  Future<bool> update_profile(String Fname, String Lname, String path) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt_token'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://api.zahedhasan.com/api/v1/auth/updateUserProfiler/$userId'));
    final bytes = await File(path).readAsBytes();
    request.body = json.encode({
      "firstName": Fname,
      "lastName": Lname,
      "profilePicture": "data:image/jpeg;base64," + base64Encode(bytes)
    });
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

  Future<Map<String, dynamic>> getUserInfo(String usrid) async {
    var headers = {'Authorization': 'Bearer $jwt_token'};
    var request = http.Request(
        'GET', Uri.parse('https://api.zahedhasan.com/api/v1/auth/$usrid'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode < 300) {
      Map<String, dynamic> resp =
          json.decode(await response.stream.bytesToString());
      return resp;
    } else {
      print(response.reasonPhrase);
      Map<String, dynamic> resp =
          json.decode(await response.stream.bytesToString());
      print(resp);
      return resp;
    }
  }

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

      return users;
    } else {
      print(response.reasonPhrase);
      final obj_resp = json.decode(await response.stream.bytesToString());
      return obj_resp;
    }
  }

  Future<bool> upload_verse(String text) async {
    var headers = {'Authorization': 'Bearer $jwt_token'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.zahedhasan.com/api/v1/upload/addVerse'));
    request.fields.addAll({'userId': userId, "verse": text});
    http.StreamedResponse response = await request.send();

    if (response.statusCode < 300) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future<bool> upload_post(String filepath) async {
    var headers = {'Authorization': 'Bearer $jwt_token'};
    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.zahedhasan.com/api/v1/upload/fileSystem'));
    request.fields.addAll({'userId': userId,'caption':''});
    request.files.add(await http.MultipartFile.fromPath('files', filepath));
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

  Future<List<Post>> get_all_posts() async {
    var headers = {'Authorization': 'Bearer $jwt_token'};
    var request = http.Request('GET',
        Uri.parse('https://api.zahedhasan.com/api/v1/upload/postGetAll'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode < 300) {
      List<Post> posttt = [];
      Map<String, dynamic> respp =
          jsonDecode(await response.stream.bytesToString());
      print("Number of posts fetched");
      print(respp["postAll"].length);
      Map<String, dynamic> userInfo = {
        "firstName": "Deleted",
        "lastName": "user"
      };
      for (var resp in respp["postAll"]) {
        userId = resp["userId"];
        final userInf = await getUserInfo(userId);

        if (userInf["user"] != null) {
          userInfo = userInf["user"];
        } else {
          userInfo = {"firstName": "Deleted", "lastName": "user"};
        }
        userFullname = userInfo["firstName"] + " " + userInfo["lastName"];
        bool hasVerse = resp.containsKey('verse');
        Post postt;
        var og_cmnt = resp["comments"];
        List<Comment> comments = [];
        for (var cmt in og_cmnt) {
          comments.add(Comment(
            userId: cmt["userId"].toString(),
            id: cmt["_id"].toString(),
            content: cmt["comment"].toString(),
          ));
        }
        if (hasVerse) {
          postt = Post(
              usrName: userInfo["firstName"] + " " + userInfo["lastName"],
              userID: resp["userId"],
              id: resp["_id"],
              likes: resp['likes'].cast<String>(),
              followers: resp['followers'].cast<String>(),
              comments: comments,
              file_content: resp["verse"],
              post_type: 0);
        } else {
          var fl = resp["fileUrl"];
          var extension = fl.toString().split(".").last;
          int pst_tp = 1;
          if (extension == "mp3") {
            pst_tp = 2;
          } else if (extension == "mp4") {
            pst_tp = 3;
          }
          postt = Post(
              usrName: userInfo["firstName"] + " " + userInfo["lastName"],
              userID: resp["userId"],
              id: resp["_id"],
              likes: resp['likes'].cast<String>(),
              followers: resp['followers'].cast<String>(),
              comments: comments,
              file_content: fl,
              post_type: pst_tp);
        }
        posttt.add(postt);
      }

      return posttt;
    } else {
      print(response.reasonPhrase);
      return [
        Post(
            usrName: "eRROR",
            userID: "",
            id: "",
            likes: [""],
            comments: [],
            followers: [""],
            file_content: "",
            post_type: 0)
      ];
    }
  }

  Future<bool> likePost(String id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt_token'
    };
    var request = http.Request('POST',
        Uri.parse('https://api.zahedhasan.com/api/v1/upload/likePost/$id'));
    request.body = json.encode({"userId": userId});
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

  Future<bool> comment_post(String com, String post_id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt_token'
    };
    var request = http.Request('POST',
        Uri.parse('https://api.zahedhasan.com/api/v1/upload/comment/$post_id'));
    request.body = json.encode({"userId": userId, "comment": com});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode < 300) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(await response.stream.bytesToString());
      return false;
    }
  }
}
