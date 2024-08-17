import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:basileia/RestAPI/model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import '../Style/controller.dart';
import 'dart:io';

class MyTabsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

class TabsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

class religionsPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

class CheckboxController extends GetxController {
  var isChecked = false.obs;
  void acceptPrivacyPolicy() {
    isChecked.value = true;
  }
}

class PasswordController extends GetxController {
  var isObscured = true.obs;
}

class ColorController extends GetxController {
  RxBool isMute = false.obs;

  void toggleColor() {
    isMute.value = !isMute.value;
  }
}

class LeadersController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

Future<String?> getVideoThumbnail(String videoUrl) async {
  final directory = await getTemporaryDirectory();
  final thumbnailPath = await VideoThumbnail.thumbnailFile(
    video: videoUrl,
    thumbnailPath: directory.path,
    imageFormat: ImageFormat.PNG,
    maxHeight: 200, // specify the height of the thumbnail
    quality: 75, // specify the quality of the thumbnail
  );

  if (thumbnailPath != null) {
    return thumbnailPath;
  }
  return null;
}

class ImagePick extends GetxController {
  RxString imagePath = ''.obs;
  var video_selected = false.obs;
  var thumbnail_pth = "".obs;

  Future pickImage() async {
    final result = await FilePicker.platform
        .pickFiles()!; // await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      String pickedFile = result.files.single.path!;
      imagePath.value = pickedFile;
      if (imagePath.split(".")[-1] == "mkv" ||
          imagePath.split(".")[-1] == "mp4") {
        var thumbnail_pt = await getVideoThumbnail(pickedFile);
        if (thumbnail_pt != null) {
          video_selected.value = true;
          thumbnail_pth.value = thumbnail_pt;
        }
      }
    } else {
      print('No image selected');
    }
  }

  void clearImagePath() {
    imagePath = ''.obs;
  }
}

class PostLikeController extends GetxController {
  var isLiked = false.obs;
  var id = "";

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }
}

class PostCommentController extends GetxController {
  var post = Rx<Post>(Post(
    profilePic: "",
    usrName: '',
    userID: '',
    id: '',
    likes: [],
    comments: [],
    followers: [],
    file_content: '',
    post_type: 0,
    caption: '',
  ));
  PostCommentController(Post initialPost) {
    post.value = initialPost;
  }

  void AddComment(comnt) {
    post.value.comments.add(comnt);
  }
}

class CommentRepliesController extends GetxController {
  var replies = Rx<List<Replies>>([]);
  CommentRepliesController(List<Replies> repl) {
    replies.value = repl;
    print(replies.value);
  }

  void AddComment(comnt) {
    replies.value.add(comnt);
  }
}

class DropdownController extends GetxController {
  var selectedItem = 'Option 1'.obs;
  void setSelectedItem(String value) {
    selectedItem.value = value;
  }
}

class FollowController extends GetxController {
  var isFollowing = false.obs;

  void toggleFollow() {
    isFollowing.value = !isFollowing.value;
  }
}

class ImagePick_1 extends GetxController {
  RxString imagePath = ''.obs;
  final ImagePicker picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path.toString();
    } else {
      print('No image selected');
    }
  }

  void clearImagePath() {
    imagePath = ''.obs;
  }
}

class ToggleController extends GetxController {
  var showImage = false.obs;
  var userId = "".obs;
  var name = "".obs;
  ToggleController(this.userId, this.name);
  void toggleImage() {
    showImage.value = !showImage.value;
  }
}
