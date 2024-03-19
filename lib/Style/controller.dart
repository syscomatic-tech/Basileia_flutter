import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  var isChecked = true.obs;
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

class ImagePick extends GetxController {
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
}

class PostLikeController extends GetxController {
  var isLiked = false.obs; // Observable variable
  var id = "";

  void toggleLike() {
    isLiked.value = !isLiked.value;
    // Toggle post like status
    // Here, you can also handle your backend logic such as calling API to like the post
    // For example: SocialClient().likePost(postID);
    // And then, you can update the UI accordingly based on the response
  }
}
