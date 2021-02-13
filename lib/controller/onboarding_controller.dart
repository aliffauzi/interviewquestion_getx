import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:interviewquestion/model/onboarding/onboarding_response.dart';
import 'package:interviewquestion/resource/api.dart';
import 'package:interviewquestion/resource/routes.dart';
import 'package:interviewquestion/shared/repository/local_auth_repository.dart';

class OnBoardingController extends GetxController {
  var _localAuthRepository = Get.find<LocalAuthRepository>();
  var selectedPage = 0.obs;

  var pageController = PageController();
  bool get isLastPage => selectedPage.value == onBoardingResponseList.length - 1;

  forwardAction() {
    if (isLastPage) {
      _localAuthRepository.setSession(SECURE_STORAGE_ON_BOARDING, ON_BOARDING);

      Get.offNamedUntil(loginRoute, (_) => false);
    } else
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  List<OnBoardingResponse> onBoardingResponseList = [
    OnBoardingResponse(
        imageAssets: 'assets/images/app_icon.png',
        title: 'Preparation interview question',
        description:
            'Now you can preparation interview any time, free and paid source code provide, right from your mobile.'),
    OnBoardingResponse(
        imageAssets: 'assets/images/app_icon.png',
        title: 'Favourite question',
        description:
            'Favourite interview question like, no need to write question.'),
    OnBoardingResponse(
        imageAssets: 'assets/images/app_icon.png',
        title: 'Best company choose',
        description: 'Large category of programming interview questions likes for Android, Java, Flutter etc.')
  ];
}
