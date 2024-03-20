class Comment {
  String userId;
  String id;
  String content;
  String usrname;
  List<Comment> replies = [];

  // Constructor
  Comment(
      {required this.userId,
      required this.id,
      required this.content,
      required this.usrname});
}

class Post {
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
  List<dynamic> Upvotes = [];
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
