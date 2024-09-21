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

// class Question {
//   var type = ""; //it can be BL=Bible, GEN=general, QS=questions
//   var id = "";
//   var content = "";
//   List<dynamic> upvotes = [];
//   var userID = "";
//   var usrName = "";
//   Question({
//     required this.type,
//     required this.id,
//     required this.content,
//     required this.upvotes,
//     required this.userID,
//     required this.usrName,
//   });
// }
// models.dart

class User {
  String id;
  String firstName;
  String lastName;

  User({required this.id, required this.firstName, required this.lastName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }
}

class Answer {
  String id;
  String userId; // User ID as a string
  String questionId;
  String answer;
  String name;
  List<dynamic> upvotes;
  String createdAt;
  String updatedAt;
  int v;

  Answer({
    required this.id,
    required this.userId,
    required this.name,
    required this.questionId,
    required this.answer,
    required this.upvotes,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['_id'] ?? '',
      name:
          (json['user']["firstName"] ?? "") + (json['user']["lastName"] ?? ""),
      userId: json['user']["_id"] ?? '',
      questionId: json['question'] ?? '',
      answer: json['answer'] ?? '',
      upvotes: json['upvotes'] ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}

class Question {
  String id;
  User user;
  String questionText;
  String category;
  List<dynamic> tags;
  List<dynamic> upvotes;
  String createdAt;
  String updatedAt;
  int v;
  List<Answer> answers;

  Question({
    required this.id,
    required this.user,
    required this.questionText,
    required this.category,
    required this.tags,
    required this.upvotes,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    var answerList = json['answers'] as List<dynamic>?;
    List<Answer> answers = [];
    if (answerList != null) {
      answers = answerList.map((e) => Answer.fromJson(e)).toList();
    }
    return Question(
      id: json['_id'] ?? '',
      user: User.fromJson(json['user']),
      questionText: json['question'] ?? '',
      category: json['category'] ?? '',
      tags: json['tags'] ?? [],
      upvotes: json['upvotes'] ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      answers: answers,
    );
  }
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
