class Post {
  var usrName = "";
  var userID = "";
  var id = "";
  var likes = [''];
  var followers = [''];
  var comments = [''];
  var file_content = "";
  var post_type =
      0; // 0 = verse , 1 = file_link, 2 = audio_link, 3 = video_link

  Post(
      {required this.usrName,
      required this.userID,
      required this.id,
      required this.likes,
      required this.followers,
      required this.file_content,
      required this.post_type});
}
