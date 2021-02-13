import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/controller/controller.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';

class SplashPage extends GetView<SplashController> {
  @override
  build(BuildContext context) => Scaffold(
          body: Center(
              child: SlideTransition(
                  position: controller.offsetAnimation,
                  child: Text(appName, style: splashTitleStyle))));
}
