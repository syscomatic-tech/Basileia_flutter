class Comment {
  String profilePic;
  String userId;
  String id;
  String content;
  String usrname;
  String time;
  List<Replies> replies = [];

  // Constructor
  Comment(
      {required this.userId,
      required this.profilePic,
      required this.id,
      required this.content,
      required this.usrname,
      required this.time,
      required this.replies});
}

class Replies {
  String userId;
  String id;
  String content;
  String usrname;
  String time;

  // Constructor
  Replies(
      {required this.userId,
      required this.id,
      required this.content,
      required this.time,
      required this.usrname});
}

class Post {
  var profilePic = "";
  var usrName = "";
  var userID = "";
  var id = "";
  var likes = [''];
  var followers = [''];
  List<Comment> comments = [];
  var file_content = "";
  var caption = "";
  var post_type =
      0; // 0 = verse , 1 = file_link, 2 = audio_link, 3 = video_link

  Post(
      {required this.usrName,
      required this.profilePic,
      required this.userID,
      required this.id,
      required this.likes,
      required this.comments,
      required this.followers,
      required this.file_content,
      required this.post_type,
      required this.caption});
}

class Question {
  var type = ""; //it can be BL=Bible, GEN=general, QS=questions
  var id = "";
  var content = "";
  List<dynamic> upvotes = [];
  var userID = "";
  var usrName = "";
  List<Comment> comments = [];
  Question({
    required this.type,
    required this.id,
    required this.content,
    required this.upvotes,
    required this.userID,
    required this.usrName,
    required this.comments,
  });
}

class UsrProfile {
  String profilePic; // Base64 encoded image
  String name;
  String totFollowers;
  String totFollowings;
  String totPosts = "";
  String userId;
  List<String> times;
  late List<Post> posts;

  // Constructor with required parameters
  UsrProfile({
    required this.userId,
    required this.profilePic,
    required this.name,
    required this.totFollowers,
    required this.totFollowings,
    required this.totPosts,
    required this.times,
    required List<Post> posts,
  }) {
    // Initialize the 'posts' field with the provided 'posts' parameter
    this.posts = posts;
  }
}
