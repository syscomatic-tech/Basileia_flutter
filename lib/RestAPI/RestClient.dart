import 'dart:async';
import "dart:convert";
import 'dart:io';
import 'package:basileia/Style/style.dart';
import 'package:basileia/RestAPI/model.dart';
import 'package:http/http.dart' as http;

var jwt_token = "";
var userId = "";
var userFullname = "";
var userFollowings = [""];
var userPass = "";
var userEmail = "";
var userProfile = "";
int userFollowers = 0;
int userPoststotal = 0;

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

      if (resp["user"].containsKey("profilePicture")) {
        userProfile = resp["user"]["profilePicture"];
      }
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
      SuccessToast("Processing");
      final resp = json.decode(await response.stream.bytesToString());

      jwt_token = resp["accessToken"];
      userId = resp["user"]["_id"];
      print(userId);
      final userInfo = await getUserInfo(userId);
      final usPost = json.decode(await totalPost(userId));
      final usFollowers = json.decode(await totalFollowers(userId));
      userFollowers = usFollowers["totalFollowers"];
      userPoststotal = usPost["totalPosts"];
      print(userInfo);
      if (userInfo["user"] != null) {
        userFullname =
            userInfo["user"]["firstName"] + " " + userInfo["user"]["lastName"];
      } else {
        userFullname = "Deleted User";
      }
      userEmail = resp["user"]["email"];
      return "Login Successful";
    } else {
      print(response.reasonPhrase);
      var outp = await response.stream.bytesToString();
      print(outp);
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
      var outp = json.decode(await response.stream.bytesToString());
      ErrorToast(outp["message"]);
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
      ErrorToast(json.decode(await response.stream.bytesToString())["message"]);
      return false;
    }
  }

  Future<String> ResetPassword(String newpassword, String otp) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST',
        Uri.parse('https://api.zahedhasan.com/api/v1/auth/reset-password'));
    request.body = json
        .encode({"email": userEmail, "otp": otp, "newPassword": newpassword});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode < 300) {
      var outp = json.decode(await response.stream.bytesToString());
      return outp["message"];
    } else {
      print(response.reasonPhrase);
      var outp = json.decode(await response.stream.bytesToString());
      return outp["message"];
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
    var request = http.MultipartRequest(
        'PATCH', Uri.parse('https://api.zahedhasan.com/api/v1/auth/$userId'));
    final bytes = await File(path).readAsBytes();
    request.fields.addAll({
      "firstName": Fname,
      "lastName": Lname,
      "email": userEmail,
    });
    request.files
        .add(await http.MultipartFile.fromPath('profilePicture', path));
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
    if (true) {
      var headers = {'Authorization': 'Bearer $jwt_token'};
      var request = http.Request(
          'GET', Uri.parse('https://api.zahedhasan.com/api/v1/auth/$usrid'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode < 300) {
        final resp = json.decode(await response.stream.bytesToString());

        if (resp["user"] != null) {
          if (resp["user"].containsKey("profilePicture")) {
            resp["user"]["hasPic"] = true;
          } else {
            resp["user"]["hasPic"] = false;
          }
        }
        return resp;
      } else {
        print(response.reasonPhrase);
        Map<String, dynamic> resp =
            json.decode(await response.stream.bytesToString());
        print(resp);
        return resp;
      }
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

  Future<String> upload_verse(String text) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt_token'
    };
    var request = http.Request(
        'POST', Uri.parse('https://api.zahedhasan.com/api/v1/upload/addVerse'));
    ;
    request.body = json.encode({'userId': userId, "verse": text});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var outp = jsonDecode(await response.stream.bytesToString());
    if (response.statusCode < 300) {
      return outp["message"];
    } else {
      print(response.reasonPhrase);
      return outp["message"];
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
      ErrorToast(json.decode(await response.stream.bytesToString())["message"]);
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
      print(respp["randomPosts"].length);
      Map<String, dynamic> userInfo = {
        "firstName": "Deleted",
        "lastName": "user"
      };
      for (var resp in respp["randomPosts"]) {
        var profPic = "";
        var useid = resp["userId"];
        final userInf = await getUserInfo(useid);
        print(userInf["user"]);
        if (userInf["user"] != null) {
          userInfo = userInf["user"];
          if (userInfo.containsKey("profilePicture")) {
            profPic = userInfo["profilePicture"];
          }
        } else {
          userInfo = {"firstName": "Deleted", "lastName": "user"};
        }

        bool hasVerse = resp.containsKey('verse');
        bool hasFileUrl = resp.containsKey('fileUrl');
        Post postt;
        var og_cmnt = resp["comments"];
        List<Comment> comments = [];
        String capt = "";
        for (var cmt in og_cmnt) {
          var cInf = await getUserInfo(cmt["userId"]);
          Map<String, dynamic> cInfo;
          var hspic = false;
          if (cInf["user"] != null) {
            cInfo = cInf["user"];
            if (cInfo.containsKey("profilePicture")) {
              hspic = true;
            }
          } else {
            cInfo = {"firstName": "Deleted", "lastName": "user"};
          }
          // Replies handling
          List<Replies> repls = [];
          for (var reppl in cmt["replies"]) {
            var ccInf = await getUserInfo(cmt["userId"]);
            Map<String, dynamic> ccInfo;
            if (ccInf["user"] != null) {
              ccInfo = ccInf["user"];
            } else {
              ccInfo = {"firstName": "Deleted", "lastName": "user"};
            }
            repls.add(Replies(
                userId: reppl["userId"].toString(),
                id: reppl["_id"].toString(),
                content: reppl["reply"].toString(),
                usrname: ccInfo["firstName"]! + " " + ccInfo["lastName"]!,
                time: reppl["createdAt"]));
          }

          ///
          comments.add(Comment(
              profilePic: hspic ? cInfo["profilePicture"] : "",
              userId: cmt["userId"].toString(),
              id: cmt["_id"].toString(),
              content: cmt["comment"].toString(),
              usrname: cInfo["firstName"]! + " " + cInfo["lastName"]!,
              time: cmt["createdAt"],
              replies: repls));
        }
        if (resp.containsKey("caption")) {
          capt = resp["caption"];
        }
        if (hasVerse) {
          postt = Post(
              profilePic: profPic,
              usrName: userInfo["firstName"] + " " + userInfo["lastName"],
              userID: resp["userId"],
              id: resp["_id"],
              likes: resp['likes'].cast<String>(),
              followers: resp['followers'].cast<String>(),
              comments: comments,
              file_content: resp["verse"],
              post_type: 0,
              caption: capt);
        } else if (hasFileUrl) {
          var fl = resp["fileUrl"];
          print(fl);
          var exten = fl.toString().split(".").last;
          int pst_tp = 1;
          if (exten == "mp3") {
            pst_tp = 2;
          } else if (exten == "mp4") {
            pst_tp = 3;
          }
          print(resp['followers']);
          postt = Post(
              profilePic: profPic,
              usrName: userInfo["firstName"] + " " + userInfo["lastName"],
              userID: resp["userId"],
              id: resp["_id"],
              likes: resp['likes'].cast<String>(),
              followers: resp['followers'].cast<String>(),
              comments: comments,
              file_content: resp["fileUrl"],
              post_type: pst_tp,
              caption: capt);
        } else {
          postt = Post(
              profilePic: "",
              usrName: userInfo["firstName"] + " " + userInfo["lastName"],
              userID: resp["userId"],
              id: resp["_id"],
              likes: resp['likes'].cast<String>(),
              followers: resp['followers'].cast<String>(),
              comments: comments,
              file_content: "No Data Can be found",
              post_type: 0,
              caption: capt);
        }
        posttt.add(postt);
      }

      return posttt;
    } else {
      print(response.reasonPhrase);
      return [
        Post(
            profilePic: "",
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
            profilePic: "",
            userId: cmnt["userId"],
            id: cmnt["_id"],
            content: cmnt["comment"],
            usrname: userinf["firstName"] + " " + userinf["lastName"],
            time: cmnt["createdAt"],
            replies: []));
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

  if (response.statusCode < 300) {
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

Future<String> Follow_user(String id) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt_token'
  };
  var request = http.Request(
      'POST', Uri.parse('https://api.zahedhasan.com/api/v1/upload/follow'));
  request.body = json.encode({"followerId": userId, "followingId": id});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode < 300) {
    var outp = jsonDecode(await response.stream.bytesToString());
    return outp["message"];
  } else {
    print(response.reasonPhrase);
    var outp = jsonDecode(await response.stream.bytesToString());
    return outp["message"];
  }
}

Future<String> reply_comment(
    String content, String postId, String commentId) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt_token'
  };
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://api.zahedhasan.com/api/v1/upload/reply/$postId/$commentId'));
  request.body = json.encode({"userId": userId, "reply": content});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode < 300) {
    var outp = jsonDecode(await response.stream.bytesToString());
    return outp["message"];
  } else {
    var outp = jsonDecode(await response.stream.bytesToString());
    ErrorToast(outp["message"]);
    print(response.reasonPhrase);
    return "Error";
  }
}

Future<String> Share_post(String postId) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt_token'
  };
  var request = http.Request('POST',
      Uri.parse('https://api.zahedhasan.com/api/v1/upload/share/$postId'));
  request.body = json.encode({"userId": userId});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode < 300) {
    var outp = jsonDecode(await response.stream.bytesToString());
    return outp["message"];
  } else {
    var outp = jsonDecode(await response.stream.bytesToString());
    return outp["message"];
  }
}

Future<UsrProfile> GetUserProfile(String usId) async {
  var headers = {'Authorization': 'Bearer $jwt_token'};
  var request = http.Request(
      'GET', Uri.parse('https://api.zahedhasan.com/api/v1/upload/$usId'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode < 300) {
    Map<String, dynamic> userInfo = {
      "firstName": "Deleted",
      "lastName": "user"
    };
    List<dynamic> resps = json.decode(await response.stream.bytesToString());
    var profPic = "";
    print(resps);
    var scl_client = SocialClient();
    List<Post> posts = [];
    var haspic = false;
    final resp_info = await scl_client.getUserInfo(usId);
    if (resp_info["user"] != null) {
      userInfo = resp_info["user"];
      if (userInfo.containsKey("profilePicture")) {
        profPic = userInfo["profilePicture"];
      }
    } else {
      userInfo = {"firstName": "Deleted", "lastName": "user"};
    }

    var totalPosts = resps.length;
    String totalFols = "0";
    String totalFolls = "0"; //Total followings
    List<String> times = [""];

    if (totalPosts > 0) {
      totalFols = resps[0]["followers"].length.toString();
      totalFolls = resps[0]["following"].length.toString();
      for (var resp in resps) {
        var useid = resp["userId"];

        bool hasVerse = resp.containsKey('verse');
        bool hasFileUrl = resp.containsKey('fileUrl');
        Post postt;
        var og_cmnt = resp["comments"];
        List<Comment> comments = [];
        String capt = "";
        for (var cmt in og_cmnt) {
          var cInf = await scl_client.getUserInfo(cmt["userId"]);
          Map<String, dynamic> cInfo;
          if (cInf["user"] != null) {
            cInfo = cInf["user"];
          } else {
            cInfo = {"firstName": "Deleted", "lastName": "user"};
          }

          List<Replies> repls = [];
          for (var reppl in cmt["replies"]) {
            var ccInf = await scl_client.getUserInfo(cmt["userId"]);
            Map<String, dynamic> ccInfo;
            if (ccInf["user"] != null) {
              ccInfo = ccInf["user"];
            } else {
              ccInfo = {"firstName": "Deleted", "lastName": "user"};
            }
            repls.add(Replies(
                userId: reppl["userId"].toString(),
                id: reppl["_id"].toString(),
                content: reppl["reply"].toString(),
                usrname: ccInfo["firstName"]! + " " + ccInfo["lastName"]!,
                time: reppl["createdAt"]));
          }
          comments.add(Comment(
              profilePic: cInfo.containsKey("profilePicture")
                  ? cInfo["profilePicture"]
                  : "",
              userId: cmt["userId"].toString(),
              id: cmt["_id"].toString(),
              content: cmt["comment"].toString(),
              usrname: cInfo["firstName"]! + " " + cInfo["lastName"]!,
              time: cmt["createdAt"],
              replies: repls));
        }
        if (resp.containsKey("caption")) {
          capt = resp["caption"];
        }
        if (hasVerse) {
          postt = Post(
              profilePic: profPic,
              usrName: userInfo["firstName"] + " " + userInfo["lastName"],
              userID: resp["userId"],
              id: resp["_id"],
              likes: resp['likes'].cast<String>(),
              followers: resp['followers'].cast<String>(),
              comments: comments,
              file_content: resp["verse"],
              post_type: 0,
              caption: capt);
        } else if (hasFileUrl) {
          var fl = resp["fileUrl"];
          print(fl);
          var exten = fl.toString().split(".").last;
          int pst_tp = 1;
          if (exten == "mp3") {
            pst_tp = 2;
          } else if (exten == "mp4") {
            pst_tp = 3;
          }
          print(resp['followers']);
          postt = Post(
              profilePic: profPic,
              usrName: userInfo["firstName"] + " " + userInfo["lastName"],
              userID: resp["userId"],
              id: resp["_id"],
              likes: resp['likes'].cast<String>(),
              followers: resp['followers'].cast<String>(),
              comments: comments,
              file_content: resp["fileUrl"],
              post_type: pst_tp,
              caption: capt);
        } else {
          postt = Post(
              profilePic: profPic,
              usrName: userInfo["firstName"] + " " + userInfo["lastName"],
              userID: resp["userId"],
              id: resp["_id"],
              likes: resp['likes'].cast<String>(),
              followers: resp['followers'].cast<String>(),
              comments: comments,
              file_content: "No Data Can be found",
              post_type: 0,
              caption: capt);
        }
        times.add(resp["createdAt"]);
        posts.add(postt);
      }
    }
    return UsrProfile(
        userId: userInfo["_id"],
        profilePic: profPic,
        name: userInfo["firstName"]! + " " + userInfo["lastName"],
        totFollowers: totalFols,
        totFollowings: totalFolls,
        totPosts: totalPosts.toString(),
        times: times,
        posts: posts);
  } else {
    print(response.reasonPhrase);
    return json.decode(await response.stream.bytesToString());
  }
}

Future<String> totalPost(String usId) async {
  var headers = {'Authorization': 'Bearer $jwt_token'};
  var request = http.Request('GET',
      Uri.parse('https://api.zahedhasan.com/api/v1/upload/$usId/totalPost'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode < 300) {
    return jsonDecode(await response.stream.bytesToString())["totalPosts"];
  } else {
    print(response.reasonPhrase);
    return await response.stream.bytesToString();
  }
}

Future<String> totalFollowers(String usid) async {
  var headers = {'Authorization': 'Bearer $jwt_token'};
  var request = http.Request('GET',
      Uri.parse('https://api.zahedhasan.com/api/v1/upload/$usid/followers'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode < 300) {
    return json.decode(await response.stream.bytesToString())["totalFollowers"];
  } else {
    print(response.reasonPhrase);
    return await response.stream.bytesToString();
  }
}
