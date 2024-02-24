import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabsController extends GetxController with GetSingleTickerProviderStateMixin {
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

class TabsController extends GetxController with GetSingleTickerProviderStateMixin {
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
class religionsPageController extends GetxController with GetSingleTickerProviderStateMixin {
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

class LeadersController extends GetxController with GetSingleTickerProviderStateMixin {
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