import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class ScreenShotController extends GetxController {
  var selectedPage = 0.obs;
  List<dynamic> screenshotList;

  var pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    screenshotList = Get.arguments;
  }

  forwardAction() {
    pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }
}
