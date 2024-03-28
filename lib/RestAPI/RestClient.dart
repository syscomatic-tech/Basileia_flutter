import 'dart:async';
import "dart:convert";
import 'dart:io';
import 'package:basileia/Style/style.dart';
import 'package:basileia/RestAPI/model.dart';
import 'package:http/http.dart' as http;

var jwt_token = "";
var userId = "";
var userFullname = "";
var userPass = "";
var userEmail = "";

class AuthClient {
  var BaseURL = "https://api.zahedhasan.com/api/v1";
  var RequestHeader = {"Content-Type": "application/json"};
//Login API calling
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
      print(userId);
      final userInfo = await getUserInfo(userId);
      print(userInfo);
      if (userInfo["user"] != null) {
        userFullname =
            userInfo["user"]["firstName"] + " " + userInfo["user"]["lastName"];
      } else {
        userFullname = "Deleted User";
      }
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
    userFullname = FirstName + " " + LastName;
    userEmail = Email;
    userPass = pass;

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
      final out = json.decode(await response.stream.bytesToString());
      ErrorToast(out["message"]);
      ErrorToast(response.reasonPhrase);
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
      var out = await LoginRequest(userEmail, userPass);
      print(out);
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

  Future<bool> upload_post(String filepath, caption) async {
    var headers = {'Authorization': 'Bearer $jwt_token'};
    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.zahedhasan.com/api/v1/upload/fileSystem'));
    request.fields.addAll({'userId': userId, 'caption': caption});
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
        var useid = resp["userId"];
        final userInf = await getUserInfo(useid);
        print(userInf["user"]);
        if (userInf["user"] != null) {
          userInfo = userInf["user"];
        } else {
          userInfo = {"firstName": "Deleted", "lastName": "user"};
        }

        bool hasVerse = resp.containsKey('verse');
        Post postt;
        var og_cmnt = resp["comments"];
        List<Comment> comments = [];
        String capt = "";
        for (var cmt in og_cmnt) {
          final cInf = await getUserInfo(cmt["userId"]);
          Map<String, dynamic> cInfo;
          if (cInf["user"] != null) {
            cInfo = cInf["user"];
          } else {
            cInfo = {"firstName": "Deleted", "lastName": "user"};
          }
          comments.add(Comment(
              userId: cmt["userId"].toString(),
              id: cmt["_id"].toString(),
              content: cmt["comment"].toString(),
              usrname: cInfo["firstName"]! + " " + cInfo["lastName"]!));
        }
        if (resp.containsKey("caption")) {
          capt = resp["caption"];
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
              post_type: 0,
              caption: capt);
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
              post_type: pst_tp,
              caption: capt);
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
            post_type: 0,
            caption: "Failed to Fetch")
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

Future<List<Question>> getForumPosts() async {
  var headers = {
    'Authorization': 'Bearer $jwt_token',
  };
  var request = http.Request('GET',
      Uri.parse('https://api.zahedhasan.com/api/v1/question/latestQuestion'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode < 300) {
    List<Question> Forums = [];
    var ForumPosts = jsonDecode(await response.stream.bytesToString());
    for (var forum in ForumPosts["latestQuestions"]) {
      List<Comment> cmments = [];
      for (var cmnt in forum["comments"]) {
        SocialClient socialClient = SocialClient();
        var userinf = (await socialClient.getUserInfo(cmnt["userId"]))["user"];
        if (userinf == null) {
          userinf["firstName"] = "Deleted";
          userinf["lastName"] = "User";
        }
        cmments.add(Comment(
            userId: cmnt["userId"],
            id: cmnt["_id"],
            content: cmnt["comment"],
            usrname: userinf["firstName"] + " " + userinf["lastName"]));
      }
      if (forum["userId"] == null) {
        forum["userId"] = {
          "_id": "0",
          "firstName": "Deleted",
          "lastName": "User"
        };
      }
      Forums.add(Question(
          type: forum["categories"],
          id: forum["_id"],
          content: forum["question"],
          upvotes: forum["upvotes"],
          userID: forum["userId"]["_id"],
          usrName:
              forum["userId"]["firstName"] + " " + forum["userId"]["lastName"],
          comments: cmments));
    }
    return Forums;
  } else {
    print(response.reasonPhrase);
    var outp = jsonDecode(await response.stream.bytesToString());
    ErrorToast(outp["message"]);
    return [];
  }
}

Future<bool> uploadForumPost(post, category) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt_token',
  };
  var request = http.Request('POST',
      Uri.parse('https://api.zahedhasan.com/api/v1/question/questionAdd'));
  request.body =
      json.encode({"userId": userId, "question": post, "categories": category});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var outp = jsonDecode(await response.stream.bytesToString());
    SuccessToast(outp["message"]);
    return true;
  } else {
    var outp = jsonDecode(await response.stream.bytesToString());
    ErrorToast(outp["message"]);
    print(response.reasonPhrase);
    return false;
  }
}

Future<bool> totalFollowers(String id) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt_token'
  };
  var request = http.Request('POST',
      Uri.parse('https://api.zahedhasan.com/api/v1//upload/$id/followers'));
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
